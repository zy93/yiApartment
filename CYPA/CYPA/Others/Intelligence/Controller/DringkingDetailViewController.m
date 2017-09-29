//
//  DringkingDetailViewController.m
//  CYPA
//
//  Created by 张雨 on 2017/5/11.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import "DringkingDetailViewController.h"
#import "Header.h"
#import "TDSCell.h"
#import "QueryDeviceCell.h"
#import "UserUseCell.h"
#import "SetDeviceInfoCell.h"

@interface DringkingDetailViewController ()<UITableViewDelegate, UITableViewDataSource, SetDeviceInfoCellDelegate>
{
    UITableView *mTable;
    UIButton *mSwitchBtn;
}



@end

@implementation DringkingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"直饮水";
    [self setupView];
    [self loadData];
    
    [self addObserver:self.mDevice forKeyPath:@"fluxPulse" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [self removeObserver:self.mDevice forKeyPath:@"fluxPulse"];
}


-(void)setupView
{
    mTable = [[UITableView alloc] init];
    mTable.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    mTable.separatorStyle = UITableViewStylePlain;
    mTable.showsVerticalScrollIndicator = NO;
    mTable.delegate = self;
    mTable.dataSource = self;
    [self.view addSubview:mTable];
    
    mSwitchBtn = [[UIButton alloc] init];
    [mSwitchBtn setTitle:@"开" forState:UIControlStateNormal];
    [mSwitchBtn setTitle:@"关" forState:UIControlStateSelected];
    [mSwitchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mSwitchBtn addTarget:self action:@selector(deviceSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [mSwitchBtn setBackgroundColor:UIColorHEX(0xea5404)];
    [self.view addSubview:mSwitchBtn];
    
    
    [mTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(mSwitchBtn.mas_top);
        make.right.mas_equalTo(0);
    }];
    
    [mSwitchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
}

-(void)loadData
{
    [self.mDevice getTDS];
    [self.mDevice getPrice];
    [self.mDevice getBalance];
    [self.mDevice getFluxSum];
    [self.mDevice getDeviceID];
    [self.mDevice getFluxPulse];
    
}

-(void)updateView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [mTable reloadData];
    });
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self updateView];
}

#pragma mark - action
-(void)deviceSwitch:(UIButton *)sender
{
    [self.mDevice controlWith:sender.isSelected withResponse:^(NSDictionary *dic) {
        if ([dic[@"data"][@"result"] isEqualToString:@"success"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                sender.selected = !sender.isSelected;
            });
        }
    }];
}


#pragma mark - cell delegate
-(void)changeDeviceIdWithType:(NSString *)type number:(NSString *)number
{
    [self.mDevice setDeviceIDWithType:type number:number withResponse:^(NSDictionary *dic) {
    }];
}

-(void)changePriceWithPrice:(NSString *)price
{
    [self.mDevice setPriceWithPrice:price withResponse:^(NSDictionary *dic) {
    }];
}

-(void)changeFluxSumWithPrice:(NSString *)price
{
    [self.mDevice setFluxPulseWithPulse:price withResponse:^(NSDictionary *dic) {
    }];
}

#pragma  mark - table delegate & dataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        return 275;
    }
    else if (indexPath.section==1) {
        return 268;
    }
    else if (indexPath.section==2||indexPath.section==3) {
        return 92;
    }
    
    return 267;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        TDSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TDSCell"];
        if (!cell) {
            cell = [[TDSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TDSCell"];
        }
        cell.number = self.mDevice.TDS.integerValue;
        return cell;
    }
    else if (indexPath.section==1) {
        UserUseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserUseCell"];
        if (!cell) {
            cell = [[UserUseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserUseCell"];
        }
        cell.fluxSum = self.mDevice.fluxSum.integerValue;
        cell.balance = self.mDevice.balance.integerValue;
        cell.price   = self.mDevice.price.integerValue;
        return cell;
    }
    else if (indexPath.section==2 || indexPath.section==3){
        QueryDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QueryDeviceCell"];
        if (!cell) {
            cell = [[QueryDeviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserUseCell"];
        }
        if (indexPath.section==3) {
            [cell.mIconImg setImage:[UIImage imageNamed:@"脉冲_icon"]];
            cell.number = [NSString stringWithFormat:@"%ld",self.mDevice.fluxPulse.integerValue];
        }
        else {
            cell.number = [NSString stringWithFormat:@"type:%ld,number:%ld",self.mDevice.type.integerValue,self.mDevice.number.integerValue];
        }
        
        return cell;
    }
    else {
        SetDeviceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetDeviceInfoCell"];
        if (!cell) {
            cell = [[SetDeviceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SetDeviceInfoCell"];
        }
        cell.mDelegate = self;
        return cell;
    }
    
    
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
