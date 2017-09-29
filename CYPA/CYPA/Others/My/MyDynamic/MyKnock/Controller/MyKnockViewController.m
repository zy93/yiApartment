//
//  MyKnockViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/18.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MyKnockViewController.h"
#import "Header.h"

@interface MyKnockViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSMutableArray * newsArray;

@end

@implementation MyKnockViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self makeData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViews];

}

-(void)makeData {
    
    self.newsArray = [NSMutableArray array];
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/friend/listMyKnock" success:^(NSMutableDictionary * dict) {
        
//        NSLog(@"%@", dict);
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            for (NSDictionary * dic in dict[@"data"]) {
                FriendModel * model = [FriendModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.newsArray addObject:model];
            }
            
        }else{
            NSLog(@"加载出错");
            [self showAlertWithString:dict[@"message"]];
        }
        //刷新UI
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"加载数据出错");
    }];
    
    
    
}

-(void)setupViews {
        
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[MyKnockTableViewCell class] forCellReuseIdentifier:@"CELL_knock"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
 
}

//tableview的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.newsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE_SCALE_IPHONE6(5);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyKnockTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_knock" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    FriendModel * model = [FriendModel new];
    model = self.newsArray[indexPath.section];
    
    [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,model.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    cell.nameLabel.text = model.UNickName;
    cell.ageLabel.text = model.UAge;
    cell.constellationLabel.text = model.UConstellation;
    cell.areaLabel.text = model.Area;
    
    
    
    if (model.Ftype == 1) {
        cell.stateLabel.text = @"已开门";
        cell.stateLabel.hidden = NO;
        cell.openDoorBT.hidden = YES;
        cell.refuseBT.hidden = YES;
    }else {
        if (model.State == 1) {
            cell.stateLabel.text = @"已拒绝";
            cell.stateLabel.hidden = NO;
            cell.openDoorBT.hidden = YES;
            cell.refuseBT.hidden = YES;
        }else{
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] intValue] == model.UID) {
                cell.stateLabel.text = @"等待";
                cell.stateLabel.hidden = NO;
                cell.openDoorBT.hidden = YES;
                cell.refuseBT.hidden = YES;
            }
            else {
                cell.openDoorBT.hidden = NO;
                cell.refuseBT.hidden = NO;
            }
        }
    }
    
    cell.openDoorBT.FID = model.FID;
    cell.openDoorBT.UID = [NSString stringWithFormat:@"%d", model.UID];
    [cell.openDoorBT addTarget:self action:@selector(openDoorAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    cell.refuseBT.FID = model.FID;
//    cell.refuseBT.indexPath1 = indexPath;
    cell.refuseBT.UID = [NSString stringWithFormat:@"%d", model.UID];
    [cell.refuseBT addTarget:self action:@selector(refuseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
    
}

//点击开门
-(void)openDoorAction:(HeadButton *)sender {

    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    
    [dictory setValue:sender.FID forKey:@"UID"];
    [dictory setValue:sender.UID forKey:@"FID"];
    [dictory setValue:@"1" forKey:@"Ftype"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/friend/accept" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
           
//            [self showAlertWithString:dict[@"message"]];
            sender.hidden = YES;
            
            [self makeData];
            
//            [self.tableView reloadData];
            
        }else{
            [self showAlertWithString:@"操作失败"];
        }
        
    } failed:^{
        NSLog(@"加载数据出错");
    }];
    
}

//拒绝
-(void)refuseAction:(HeadButton *)sender {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];

    [dictory setValue:sender.FID forKey:@"UID"];
    [dictory setValue:sender.UID forKey:@"FID"];
    [dictory setValue:@"0" forKey:@"Ftype"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/friend/accept" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            NSLog(@"拒绝");
            [self makeData];
            
            [self.tableView reloadData];
        }else{
            [self showAlertWithString:@"操作失败"];
        }
        
    } failed:^{
        NSLog(@"加载数据出错");
    }];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendModel * model = [FriendModel new];
    model = self.newsArray[indexPath.section];
    
    PersonShowViewController * personVC = [[PersonShowViewController alloc] init];
//    personVC.UID = [NSString stringWithFormat:@"%d", model.FID];
    personVC.UID = model.FID;
    [self.navigationController pushViewController:personVC animated:YES];
    
}


//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SIZE_SCALE_IPHONE6(90);
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
