//
//  IntelligenceViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "IntelligenceViewController.h"
#import "Header.h"
#import <AudioToolbox/AudioToolbox.h>
#import "WebsocketChannel.h"
#import "DeviceManager.h"
#import "BaseDevice.h"
#import "DrinkingWater.h"
#import "AITTwoSwitch.h"
#import "AITCurtain.h"
#import "DringkingDetailViewController.h"
#import "AITSwitchTableViewCell.h"

static SystemSoundID shake_sound_male_id = 0;

@interface IntelligenceViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, assign)NSInteger select1;
@property(nonatomic, assign)NSInteger select2;
@property(nonatomic, assign)NSInteger select3;
@property(nonatomic, assign)NSInteger select4;
@property(nonatomic, strong)NSString *lastOpenTime; //上次开门时间

@property(nonatomic, strong)NSMutableArray *mDeviceList;

@property(nonatomic, assign)int temperatureNum;  //温度
@property(nonatomic, strong)UIButton *backIndexBT; //回到首页


@end

@implementation IntelligenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"state"] isEqualToString:@""]) {
        
        VistorView * view1 = [[VistorView alloc] init];
        self.view = view1;
    }else{
        [self setupViews];
        
        [self getLastOpenTime];
        [[WebsocketChannel shareWebsocketChannel] openSocketWithURL:WOTWebsocketURL];
        __weak IntelligenceViewController *weakSelf = self;
        [[DeviceManager shareDeviceManager] sendRequestToGetAllGroupResponse:^(NSArray *dic) {
            [_mDeviceList removeAllObjects];
            [weakSelf addFristObject];
            [_mDeviceList addObjectsFromArray:dic];
            [weakSelf updateView];
        }];
    }
    
}

-(void)addFristObject
{
    if (!_mDeviceList) {
        _mDeviceList = [NSMutableArray new];
    }
    [_mDeviceList addObject:@""];
    [_mDeviceList addObject:@""];

}

//获取最近一次的开门时间
-(void)getLastOpenTime {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    [params setValue:@"0" forKey:@"PageNum"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:params path:@"/unlock_door/history" success:^(NSMutableDictionary *dic) {
        
        if ([dic[@"data"] count] != 0) {
            self.lastOpenTime = dic[@"data"][0][@"CreateTime"];
        }

        [self.tableView reloadData];
        
    } failed:^{
        [self showAlertWithString:@"获取历史记录失败"];
    }];
}

-(void)setupViews{
    
    self.backBT.hidden = YES;
    //回到首页
    self.backIndexBT = [UIButton buttonTitle:@"回到首页" setBackground:nil andImage:nil titleColor:[UIColor colorWithHexString:@"FFFFFF"] titleFont:15];
    [self.view addSubview:self.backIndexBT];
    [self.backIndexBT addTarget:self action:@selector(backToIndexAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.backIndexBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleImv);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(43.5)));
    }];

    //判断button的当前图片
    self.select1 = 0;
    self.select2 = 0;
    self.select3 = 0;
    self.select4 = 0;
    
    self.temperatureNum = 24;
    
    self.tableView = [[UITableView alloc] init];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    self.tableView.separatorStyle = UITableViewStylePlain;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-44));
        
    }];
    
    [self.tableView registerClass:[SwitchTableViewCell class] forCellReuseIdentifier:@"CELL_switch"];
    [self.tableView registerClass:[LockTitleTableViewCell class] forCellReuseIdentifier:@"CELL_lockTitle"];
    [self.tableView registerClass:[LockTableViewCell class] forCellReuseIdentifier:@"CELL_lock"];
    [self.tableView registerClass:[ConditionTitleTableViewCell class] forCellReuseIdentifier:@"CELL_conditionTitle"];
    [self.tableView registerClass:[ConditionTableViewCell class] forCellReuseIdentifier:@"CELL_condition"];
    [self.tableView registerClass:[AITSwitchTableViewCell class] forCellReuseIdentifier:@"CELL_AITswitch"];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
}

//返回首页
-(void)backToIndexAction{
    RootTabBarController *rootVC =  (RootTabBarController *)self.tabBarController;
    rootVC.selectedIndex = 2;
}

-(void)updateView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

BOOL swit = NO;


//加温
-(void)addTemperature {
    if (self.temperatureNum < 32) {
        self.temperatureNum += 1;
        [self.tableView reloadData];
    }
    
}

//降温
-(void)decreaseTemperature {
    if (self.temperatureNum > 16) {
        self.temperatureNum -= 1;
        [self.tableView reloadData];
    }
}


//开房间门
-(void)dragAction:(UISlider *)sender {
    if (sender.value == 1.0) {
        sleep(1);
        //开门
        [self openTheDoorWithDoorType:@"2"];
    }
    else if ((sender.value < 1.0) && (sender.value > 0)){
        sender.value = 0;
    }
    else{
        sender.value = 0;
        
    }
    sender.value = 0;

    
}
//开公寓门
-(void)openApartmentAction {
    [self openTheDoorWithDoorType:@"1"];
}

//开门
-(void)openTheDoorWithDoorType:(NSString *)type {
    
    LockTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    [params setValue:type forKey:@"DoorType"];
//    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"RoomID"] forKey:@"DoorID"];
    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] forKey:@"Phone"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:params path:@"/unlock_door/unlock" success:^(NSMutableDictionary *dic) {
        if ([dic[@"code"] intValue] == 0) {
            
            if ([type intValue] == 2) {
                cell.openLabel.hidden = NO;
                cell.openLabel.text = @"门开了";
            } else {
                
            }
            [self showAlertWithString:@"开门成功"];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                cell.openLabel.hidden = YES;
            });
        } else {
            if ([type intValue] == 2) {
                cell.openLabel.hidden = NO;
                cell.openLabel.text = @"很抱歉";
            } else {
                
            }
//            [self showAlertWithString:dic[@"message"]];
            [self showAlertWithString:@"开门失败"];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                cell.openLabel.hidden = YES;
            });
        }
        //开门播放声音
        [self playSound];
        
    } failed:^{
        [self showAlertWithString:@"开门失败"];
    }];
}

-(void) playSound
{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"opendoor1" ofType:@"wav"];
//    if (path) {
//        //注册声音到系统
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
//        AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
//    }
//    
//    AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
}

//开关选择
-(void)switchChoose:(HeadButton *)sender {
    if (sender.isSelected == 0) {
        SwitchTableViewCell * cell = [self.tableView cellForRowAtIndexPath:sender.index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

//        [cell.switchBT setImage:[UIImage imageNamed:@"组-990"] forState:normal];
        sender.isSelected = 1;
    }else{
        SwitchTableViewCell * cell = [self.tableView cellForRowAtIndexPath:sender.index];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

//        [cell.switchBT setImage:[UIImage imageNamed:@"组-989"] forState:normal];
        sender.isSelected = 0;

    }
    
    
}

-(void)changeImage1:(UIButton *)sender {
    
    if (self.select1 == 0) {
//        [sender setImage:[UIImage imageNamed:@"组-990"] forState:normal];
        self.select1 = 1;
    }else{
//        [sender setImage:[UIImage imageNamed:@"组-989"] forState:normal];
        self.select1 = 0;
    }
    [self updateView];
}

#pragma tableView delegate dataSourse
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _mDeviceList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        if (section==1) {
            if (!swit) {
                swit = !swit;
                return 1;
            }
            else {
                swit = !swit;
            }
        }
        return 2;
    }
        else
    {
        NSArray *arr = _mDeviceList[section];
        return arr.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LockTitleTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_lockTitle" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.historyBT addTarget:self action:@selector(historyAction) forControlEvents:(UIControlEventTouchUpInside)];
            
            return cell;
            
        }else {
            LockTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_lock" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //不断触发valueEvent
            cell.slider.continuous = YES ;
            [cell.slider addTarget:self action:@selector(dragAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [cell.apartmentBT addTarget:self action:@selector(openApartmentAction) forControlEvents:(UIControlEventTouchUpInside)];
            
            if (self.lastOpenTime) {
                cell.lastLabel.text = [NSString stringWithFormat:@"上次开锁时间:%@", self.lastOpenTime];
            } else {
                cell.lastLabel.text = @"最近还没开过锁哦";
            }
            
            return cell;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ConditionTitleTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_conditionTitle" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //            [cell.changeBT setImage:[UIImage imageNamed:@"组-989"] forState:(UIControlStateNormal)];
            //
            [cell.mSwitch addTarget:self action:@selector(changeImage1:) forControlEvents:(UIControlEventTouchUpInside)];
            
            return cell;
            
            
        }else {
            ConditionTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_condition" forIndexPath:indexPath];
            
            //温度
            //            cell.temperature.text = [NSString stringWithFormat:@"%d", self.temperatureNum];
            //
            //            //加温度
            //            [cell.addBT addTarget:self action:@selector(addTemperature) forControlEvents:(UIControlEventTouchUpInside)];
            //
            //            //减温度
            //            [cell.decreaseBT addTarget:self action:@selector(decreaseTemperature) forControlEvents:(UIControlEventTouchUpInside)];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }else {
        BaseDevice *device = self.mDeviceList[indexPath.section][indexPath.row];

        if ([device isKindOfClass:[AITTwoSwitch class]]) {
            AITSwitchTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_AITswitch" forIndexPath:indexPath];
            [cell setMDeviceType:AIT_DEVICE_TYPE_SWITCH];
            [cell setMSwitchType:SWITCH_TYPE_TWO];
            cell.mDevice = device;
            return cell;
        }
        else if ([device isKindOfClass:[AITCurtain class]]) {
            AITSwitchTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_AITswitch" forIndexPath:indexPath];
            [cell setMDeviceType:AIT_DEVICE_TYPE_CURTAIN];
            [cell setMSwitchType:SWITCH_TYPE_THREE];
            cell.mDevice = device;
            return cell;

        }
        else {
            SwitchTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_switch" forIndexPath:indexPath];
            if ([device isKindOfClass:[DrinkingWater class]]) {
                [cell.mIconView setImage:[UIImage imageNamed:@"饮水机-1"]];
                [cell.nameLabel setText:@"饮水机"];
            }
            
            if (device.state.integerValue == 0) {
                if (![cell.nameLabel.text containsString:@"离线"]) {
                    [cell.nameLabel setText:[NSString stringWithFormat:@"%@(离线)",cell.nameLabel.text]];
                }
            }
            
            cell.mDevice = device;
            
            return cell;
        }
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
//cell行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        if (indexPath.row == 0) {
            return SIZE_SCALE_IPHONE6(40);
        }else if (indexPath.section == 1) {
            return SIZE_SCALE_IPHONE6(260);
        }else {
            return SIZE_SCALE_IPHONE6(160);
        }
    }else{
        BaseDevice *device = self.mDeviceList[indexPath.section][indexPath.row];
        if ([device isKindOfClass:[AITTwoSwitch class]] || [device isKindOfClass:[AITCurtain class]]) {
            return SIZE_SCALE_IPHONE6(135);
        }
        else {
            return SIZE_SCALE_IPHONE6(50);
        }
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[SwitchTableViewCell class]]) {
        BaseDevice *device = ((SwitchTableViewCell *)cell).mDevice;
        
//        if (device.state.integerValue == 1) {
            if ([device.templateId containsString:@"净水机"]) {
                DringkingDetailViewController * vc = [[DringkingDetailViewController alloc] init];
                vc.mDevice = (DrinkingWater *)device;
                [self.navigationController pushViewController:vc animated:YES];
            }
//        }
//        else {
//            [MBProgressHUD showError:@"设备不在线!"];
//        }
        
        
        
    }
}

//cell上的button点击
-(void)historyAction {

    LockHistoryViewController * historyVC = [[LockHistoryViewController alloc] init];
    [self.navigationController pushViewController:historyVC animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
