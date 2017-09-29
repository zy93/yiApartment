//
//  ServiceHistoryViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/27.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ServiceHistoryViewController.h"
#import "Header.h"
#import "MJRefresh.h"


@interface ServiceHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView * tableView;

@end

@implementation ServiceHistoryViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self makeData];
    
//    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self makeData];
    //tableView
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    [self.tableView setScrollEnabled:NO];
    
    [self.view addSubview:self.tableView];
    
    //下拉刷新
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];

    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(0));
    }];
    
    [self.tableView registerClass:[ServiceHistoryTableViewCell class] forCellReuseIdentifier:@"CELL_service"];

}

//获取数据
-(void)makeData {
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustId"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/workorder/getList" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                XPServiceModel * model = [XPServiceModel new];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.dataArray addObject:model];
            }
            
            //数据刷新
            [self.tableView reloadData];
        }else{
            [self showAlertWithString:@"获取数据失败"];
        }
    } failed:^{
        [self showAlertWithString:@"获取数据失败"];
        
    }];
    
}

//下拉刷新
-(void)headerRereshing{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    });
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServiceHistoryTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_service" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    XPServiceModel * serviceModel = [[XPServiceModel alloc] init];
    
    serviceModel = self.dataArray[indexPath.section];
    
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
        if (serviceModel.Score.length == 0) {
            cell.evaluateBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
            [cell.evaluateBT setTitle:@"评价" forState:(UIControlStateNormal)];
            [cell.evaluateBT setImage:nil forState:normal];
            
            [cell.evaluateBT addTarget:self action:@selector(evaluateAction:) forControlEvents:(UIControlEventTouchUpInside)];

        }else{
            [cell.evaluateBT setImage:[UIImage imageNamed:@"形状-53-拷贝-3"] forState:normal];
            [cell.evaluateBT setTitle:@"" forState:normal];
        }

    }else{
        [cell.evaluateBT setImage:[UIImage imageNamed:@"形状-53-拷贝-3"] forState:normal];
        [cell.evaluateBT setTitle:@"" forState:normal];
        cell.evaluateBT.backgroundColor = [UIColor clearColor];

    }
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SIZE_SCALE_IPHONE6(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceDetailViewController * serviceVC = [[ServiceDetailViewController alloc] init];
    XPServiceModel * model = self.dataArray[indexPath.section];
    
    serviceVC.WorkOrderID = model.WorkOrderID;
    
    [self.navigationController pushViewController:serviceVC animated:YES];
}


//点击评价
-(void)evaluateAction:(ServiceButton *)sender {
    
    EvaluateViewController * evaluateVC = [[EvaluateViewController alloc] init];
    evaluateVC.workOrderID = sender.workOrderID;
    
    [self.navigationController pushViewController:evaluateVC animated:YES];
    
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
