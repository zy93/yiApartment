//
//  MyOrderViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MyOrderViewController.h"
#import "Header.h"
#import "OrderDatilyViewController.h"
@interface MyOrderViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation MyOrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self makeData];

}

-(void)makeData{
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/order/listMyOrder" success:^(NSMutableDictionary * dict) {
//        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            for (NSDictionary * dic in dict[@"data"]) {
                OrderModel *model = [OrderModel new];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.dataArray addObject:model];
            }
            
            [self.tableView reloadData];
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        
    } failed:^{
        
        [self showAlertWithString:@"错误"];
    }];
 
}

-(void)setupViews{
    
    self.dataArray = [[NSMutableArray alloc] init];

    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:@"CELL_order"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_order" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    OrderModel * model = self.dataArray[indexPath.section];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"收货人：%@", model.UNickName];
    cell.costLabel.text = [NSString stringWithFormat:@"总金额：%.1f元", model.TotalFee];
    //时间戳转时间
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:([model.OrderTime longLongValue] / 1000)];
    NSLog(@"%@", model.OrderTime);
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd/ HH:MM"];
    NSString *dateString = [formatter stringFromDate:date];

    cell.createLabel.text = [NSString stringWithFormat:@"下单时间：%@", dateString];

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(125);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderModel * model = self.dataArray[indexPath.section];
    OrderDatilyViewController * orderVC = [[OrderDatilyViewController alloc] init];
    orderVC.orderID = model.OrderID;
    orderVC.sumMoney = model.TotalFee;
    [self.navigationController pushViewController:orderVC animated:YES];
    
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
