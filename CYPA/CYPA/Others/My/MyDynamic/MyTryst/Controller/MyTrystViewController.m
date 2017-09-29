//
//  MyTrystViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/18.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MyTrystViewController.h"
#import "Header.h"

@interface MyTrystViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UIButton * invatedBT;
@property(nonatomic, strong)UIView * selectInvateView;
@property(nonatomic, strong)UIButton * waitBT;
@property(nonatomic, strong)UIView * selectWaitView;
@property(nonatomic, strong)UIButton * endedBT;
@property(nonatomic, strong)UIView * selectEndView;
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSMutableArray * dataArray;
@property(nonatomic, assign)NSInteger selectNum;


@end

@implementation MyTrystViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self makeDataWithType:@"0"];
    [self setupViews];

}

-(void)makeDataWithType:(NSString *)type {
    
    self.dataArray = [NSMutableArray array];
    
    NSMutableDictionary * dictory = [[NSMutableDictionary alloc] init];
    [dictory setObject:[[NSUserDefaults  standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dictory setObject:type forKey:@"Type"];
    
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/group/listMyGroup" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                TrystModel * model = [[TrystModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"加载数据失败");
        
    }];
    
}



-(void)setTopView {
    UIView * functionView = [[UIView alloc] init];
    functionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:functionView];
    
    [functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        
    }];
    
    _invatedBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_invatedBT setTitle:@"受邀请" forState:(UIControlStateNormal)];
    [_invatedBT setTitleColor:[UIColor blackColor] forState:normal];
    _invatedBT.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_invatedBT];
    
    [_invatedBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(functionView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(42));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(18)));
    }];
    
    self.selectInvateView = [[UIView alloc] init];
    self.selectInvateView.backgroundColor = [UIColor colorWithRed:32/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [functionView addSubview:self.selectInvateView];
    [self.selectInvateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.invatedBT.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(5));
        make.right.mas_equalTo(self.invatedBT.mas_right);
        make.bottom.mas_equalTo(0);
    }];
    
    [_invatedBT addTarget:self action:@selector(selectInvateAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    _waitBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_waitBT setTitle:@"等待开始" forState:(UIControlStateNormal)];
    [_waitBT setTitleColor:[UIColor blackColor] forState:normal];
    _waitBT.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_waitBT];
    
    [_waitBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(functionView.mas_centerY);
        make.centerX.mas_equalTo(functionView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(100), SIZE_SCALE_IPHONE6(18)));
    }];
    
    [_waitBT addTarget:self action:@selector(selectWaitAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.selectWaitView = [[UIView alloc] init];
    self.selectWaitView.backgroundColor = [UIColor colorWithRed:32/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    self.selectWaitView.hidden = YES;
    [functionView addSubview:self.selectWaitView];
    [self.selectWaitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.waitBT.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(5));
        make.right.mas_equalTo(self.waitBT.mas_right);
        make.bottom.mas_equalTo(0);
    }];
    
    _endedBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_endedBT setTitle:@"已结束" forState:(UIControlStateNormal)];
    [_endedBT setTitleColor:[UIColor blackColor] forState:normal];
    _endedBT.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_endedBT];
    
    [_endedBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(functionView.mas_centerY);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-42));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(18)));
    }];
    
    [_endedBT addTarget:self action:@selector(selectEndedAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.selectEndView = [[UIView alloc] init];
    self.selectEndView.backgroundColor = [UIColor colorWithRed:32/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    self.selectEndView.hidden = YES;
    [functionView addSubview:self.selectEndView];
    [self.selectEndView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.endedBT.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(5));
        make.right.mas_equalTo(self.endedBT.mas_right);
        make.bottom.mas_equalTo(0);
    }];

}

-(void)setupViews{
    [self setTopView];
    
    self.selectNum = 0;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[InvateTrystTableViewCell class] forCellReuseIdentifier:@"CELL_tryst"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(30));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];


    
}

-(void)selectInvateAction{
    self.selectInvateView.hidden = NO;
    self.selectEndView.hidden = YES;
    self.selectWaitView.hidden = YES;
    self.selectNum = 0;
    
    [self makeDataWithType:@"0"];
    
}

-(void)selectWaitAction{
    self.selectInvateView.hidden = YES;
    self.selectEndView.hidden = YES;
    self.selectWaitView.hidden = NO;
    self.selectNum = 1;
    
    [self makeDataWithType:@"1"];

}

-(void)selectEndedAction{
    self.selectInvateView.hidden = YES;
    self.selectEndView.hidden = NO;
    self.selectWaitView.hidden = YES;
    self.selectNum = 2;

    [self makeDataWithType:@"2"];

}

//tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TrystModel * model = [TrystModel new];
    model = self.dataArray[indexPath.section];
    InvateTrystTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_tryst" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.activeLabel.text = model.Name;
    NSArray * array = [model.picID componentsSeparatedByString:@";"];
    [cell.trystImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseImageURL, array[0]]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseImageURL, model.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    cell.nameLabel.text = model.Admin;
    cell.numberLabel.text = [NSString stringWithFormat:@"已参加%d人", model.PersonCount];
//    NSLog(@"%@", model.BeginDate);
    cell.timeLabel.text = model.BeginDate;
    cell.placeLabel.text = [NSString stringWithFormat:@"集合地点：%@", model.Area];
    
    if (self.selectNum == 0){
        cell.aLabel.text = @"邀请您参加";
        cell.acceptBT.hidden = NO;
        cell.refuseBT.hidden = NO;
        cell.stateBT.hidden = YES;
//        cell.evaluateBT.hidden = YES;
        
        cell.acceptBT.GroupID = model.GroupID;
        
        [cell.acceptBT addTarget:self action:@selector(acceptAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.refuseBT addTarget:self action:@selector(refuseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    }else if (self.selectNum == 1){
        cell.aLabel.text = @"发起了活动";
        cell.acceptBT.hidden = YES;
        cell.refuseBT.hidden = YES;
        cell.stateBT.hidden = NO;
//        cell.evaluateBT.hidden = YES;
        
        [cell.stateBT setTitle:@"等待开始" forState:normal];
        return cell;
        
    }else{
        cell.aLabel.text = @"发起的活动";
        cell.acceptBT.hidden = YES;
        cell.refuseBT.hidden = YES;
        cell.stateBT.hidden = NO;
//        cell.evaluateBT.hidden = NO;
        
        [cell.stateBT setTitle:@"已结束" forState:normal];
//        [cell.evaluateBT addTarget:self action:@selector(evaluateAction:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }
        
}

//接受活动邀请
-(void)acceptAction:(HeadButton *)sender {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dictory setValue:sender.GroupID forKey:@"GroupID"];
    [dictory setValue:@"1" forKey:@"Type"];
    
//    NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/group/accept" success:^(NSMutableDictionary * dict) {
//        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            [self makeDataWithType:@"2"];
            
        }else{
            [self showAlertWithString:@"操作失败"];
        }
        
    } failed:^{
        NSLog(@"加载数据出错");
    }];
    
    
    
    
}
//拒绝活动邀请
-(void)refuseAction:(HeadButton *)sender {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dictory setValue:sender.GroupID forKey:@"GroupID"];
    [dictory setValue:@"0" forKey:@"Type"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/group/accept" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            [self makeDataWithType:@"2"];
            
        }else{
            [self showAlertWithString:@"操作失败"];
        }
        
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"加载数据出错");
    }];
    
}

////评价活动
//-(void)evaluateAction:(HeadButton *)sender {
//    
//    
//    
//    
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TrystModel * model = [TrystModel new];
    model = self.dataArray[indexPath.section];
    
    ActivityDetailViewController * activityVC = [[ActivityDetailViewController alloc] init];
    activityVC.GroupID = model.GroupID;
    
    [self.navigationController pushViewController:activityVC animated:YES];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(175);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE_SCALE_IPHONE6(5);
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
