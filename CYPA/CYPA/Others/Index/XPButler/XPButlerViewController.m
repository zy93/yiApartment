
//
//  XPButlerViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "XPButlerViewController.h"
#import "Header.h"

@interface XPButlerViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView * tableView;
//服务按钮
@property(nonatomic, strong)UIButton * cleanBT;
@property(nonatomic, strong)UIButton * serviceBT;
@property(nonatomic, strong)UIButton * complainBT;
@property(nonatomic, strong)NSMutableArray * dataArray;
@property(nonatomic, strong)XPServiceModel * serviceModel;
@property(nonatomic, strong)NSArray * indexArray;

@end

@implementation XPButlerViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self makeData];
    
}

//获取数据
-(void)makeData {
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustId"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/workorder/getList" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
//            NSLog(@"%@", dict);
            for (NSDictionary * dic in dict[@"data"]) {
                XPServiceModel * model = [XPServiceModel new];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.dataArray addObject:model];
            }
            
            if (self.dataArray.count > 3) {
                self.indexArray = [self.dataArray subarrayWithRange:NSMakeRange(0, 3)];
            }else{
                self.indexArray = self.dataArray;
            }
            //数据刷新
            [self.tableView reloadData];
        }else{
//            [self showAlertWithString:@"获取数据失败"];
            NSLog(@"获取用户数据失败");
        }
    } failed:^{
        NSLog(@"获取用户数据失败");
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //功能view
    UIView * functionView = [[UIView alloc] init];
        functionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:functionView];
    [functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(97));
    }];
    
    
    //tableView
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView setScrollEnabled:NO];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(functionView.mas_bottom).offset(1);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(0));
    }];
    
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, self.view.frame.size.width, SIZE_SCALE_IPHONE6(30));
    
    self.tableView.tableFooterView = bottomView;
    
    UIButton * historyBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [historyBT setTitle:@"服务记录>>" forState:(UIControlStateNormal)];
    [historyBT setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    historyBT.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:historyBT];
    
    [historyBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(10));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(70, SIZE_SCALE_IPHONE6(30)));
    }];
    
    [historyBT addTarget:self action:@selector(historyAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //保洁
    self.cleanBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.cleanBT.backgroundColor = [UIColor yellowColor];
    [self.cleanBT setImage:[UIImage imageNamed:@"组-999"] forState:normal];
    [self.view addSubview:self.cleanBT];
    [self.cleanBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(functionView.mas_top).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(46));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(49), SIZE_SCALE_IPHONE6(77)));
    }];
    
    [self.cleanBT addTarget:self action:@selector(cleanAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //维修
    self.serviceBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.serviceBT.backgroundColor = [UIColor yellowColor];
    [self.serviceBT setImage:[UIImage imageNamed:@"组-997"] forState:normal];
    [self.view addSubview:self.serviceBT];
    [self.serviceBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cleanBT.mas_top);
        make.left.mas_equalTo(self.cleanBT.mas_right).offset(SIZE_SCALE_IPHONE6(67.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(49), SIZE_SCALE_IPHONE6(77)));
    }];
    [self.serviceBT addTarget:self action:@selector(serviceAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //投诉
    self.complainBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.complainBT.backgroundColor = [UIColor yellowColor];
    [self.complainBT setImage:[UIImage imageNamed:@"组-998"] forState:normal];
    [self.view addSubview:self.complainBT];
    [self.complainBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cleanBT.mas_top);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-46));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(49), SIZE_SCALE_IPHONE6(77)));
    }];
    [self.complainBT addTarget:self action:@selector(complainAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //注册cell
    [self.tableView registerClass:[ServiceHistoryTableViewCell class] forCellReuseIdentifier:@"CELL_service"];
    
    //客服服务时间
    UILabel * serverlabel = [UILabel labelText:@"客服服务时间为:10:00 - 18:30" andFont:14.f andColor:[UIColor colorWithHexString:@"666666"]];
    serverlabel.textAlignment = NSTextAlignmentCenter;
    serverlabel.numberOfLines = 0;
    [self.view addSubview:serverlabel];
    
    [serverlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(-30);
//        make.top.mas_equalTo(historyBT.mas_bottom).offset(30);
    }];
    
    
    
}
//历史记录
-(void)historyAction {
    ServiceHistoryViewController * serviceVC = [[ServiceHistoryViewController alloc] init];
    [self.navigationController pushViewController:serviceVC animated:YES];
}

//点击方法
-(void)cleanAction {
    CleanViewController * cleanVC = [[CleanViewController alloc] init];

    [self.navigationController pushViewController:cleanVC animated:YES];
    
}

-(void)serviceAction {
    ServiceViewController * serviceVC = [[ServiceViewController alloc] init];

    [self.navigationController pushViewController:serviceVC animated:YES];
}

-(void)complainAction {
    
    ComplainViewController * complainVC = [[ComplainViewController alloc] init];

    [self.navigationController pushViewController:complainVC animated:YES];
}




#pragma mark tableView delegate datasourse

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.indexArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%@", self.dataArray);
    
    ServiceHistoryTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_service" forIndexPath:indexPath];
    XPServiceModel * serviceModel = [[XPServiceModel alloc] init];
    
    serviceModel = self.indexArray[indexPath.section];
    
    if ([serviceModel.orderType isEqualToString:@"04_001_1"]) {
        cell.kindImv.image = [UIImage imageNamed:@"组-994"];
    }else if ([serviceModel.orderType isEqualToString:@"04_001_2"]) {
        cell.kindImv.image = [UIImage imageNamed:@"组-996"];
    }else{
        cell.kindImv.image = [UIImage imageNamed:@"组-995"];
    }

    cell.kindLabel.text = serviceModel.orderType;
    cell.timeLabel.text = serviceModel.CREATETime;
    cell.statusLabel.text = serviceModel.STATUS;
    cell.evaluateBT.workOrderID = serviceModel.WorkOrderID;
    
    if ([serviceModel.STATUS isEqualToString:@"完成"]) {
        if ([serviceModel.Score isEqualToString:@""]) {
            cell.evaluateBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
            [cell.evaluateBT setTitle:@"评价" forState:(UIControlStateNormal)];
            
            [cell.evaluateBT addTarget:self action:@selector(evaluateAction:) forControlEvents:(UIControlEventTouchUpInside)];
            
        }else{
            [cell.evaluateBT setImage:[UIImage imageNamed:@"形状-53-拷贝-3"] forState:normal];
            [cell.evaluateBT setTitle:@"" forState:normal];
            cell.evaluateBT.backgroundColor = [UIColor whiteColor];
        }
        
    }else{
        [cell.evaluateBT setImage:[UIImage imageNamed:@"形状-53-拷贝-3"] forState:normal];
    }
    
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return SIZE_SCALE_IPHONE6(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

//点击评价
-(void)evaluateAction:(ServiceButton *)sender {
    
    EvaluateViewController * evaluateVC = [[EvaluateViewController alloc] init];
    evaluateVC.workOrderID = sender.workOrderID;
    
    [self.navigationController pushViewController:evaluateVC animated:YES];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServiceDetailViewController * serviceVC = [[ServiceDetailViewController alloc] init];
    XPServiceModel * model = self.indexArray[indexPath.section];
    serviceVC.WorkOrderID = model.WorkOrderID;
    [self.navigationController pushViewController:serviceVC animated:YES];
    
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
