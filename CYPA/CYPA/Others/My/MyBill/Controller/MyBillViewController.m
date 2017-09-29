//
//  MyBillViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MyBillViewController.h"
#import "Header.h"
@interface MyBillViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView * historyTableView;
@property(nonatomic, strong)NSMutableArray * checkArray;
@property(nonatomic, strong)NSMutableArray * historyArray;
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)UILabel * totalLabel;
//待缴费数组
@property(nonatomic, strong)NSMutableArray * billArray;
@property(nonatomic, strong)NSMutableString * billIDString;
@property(nonatomic, assign)double totalMoney;

@end

@implementation MyBillViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self makeData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self makeData];
    [self setupViews];
    
}

-(void)makeData {
    
    self.checkArray = [NSMutableArray array];
    self.historyArray = [NSMutableArray array];
    
    //获取缴费列表
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    //    NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/rmb/listUnPay" success:^(NSMutableDictionary * dict) {
        //                        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                CheckModel * model = [CheckModel new];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.checkArray addObject:model];
            }
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"获取用户信息失败");
    }];
    
    
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * nowDate = [formatter stringFromDate:date];
    //获取缴费历史信息
    NSMutableDictionary * dictory1 = [NSMutableDictionary dictionary];
    [dictory1 setValue:@"1990-01-01" forKey:@"BeginDate"];
    [dictory1 setValue:nowDate forKey:@"EndDate"];
    [dictory1 setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    //    [dictory setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>]
    //
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory1 path:@"/rmb/listBusiness" success:^(NSMutableDictionary * dict) {
        //                        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            for (NSDictionary * dic in dict[@"data"]) {
                CheckModel * model = [CheckModel new];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.historyArray addObject:model];
            }
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        
        //刷新数据
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"获取用户信息失败");
    }];
    
    
    
    
}

-(void)setupViews {
    self.billArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[kindOfPayTableViewCell class] forCellReuseIdentifier:@"CELL_pay"];
    [self.tableView registerClass:[PayHistoryTableViewCell class] forCellReuseIdentifier:@"CELL_history"];
    [self.tableView registerClass:[PayTableViewCell class] forCellReuseIdentifier:@"CELL_jiaofei"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(0));
    }];
}

//缴费
-(void)payAction {
    //缴费
    //缴费id字符串
    self.billIDString = [[NSMutableString alloc] init];
    
    for (int i = 0; i < self.billArray.count; i++) {
        
        if (i == 0) {
            self.billIDString = [NSMutableString stringWithFormat:@"%@",self.billArray[0]];
        }else{
            [self.billIDString appendString:[NSString stringWithFormat:@",%@",self.billArray[i]]];
        }
        
        for (CheckModel * model in self.checkArray) {
            
            if (model.BillID == self.billArray[i]) {
                self.totalMoney += [model.TotalFee doubleValue];
            }
        }
        
    }
    if (self.billIDString.length == 0) {
        [self showAlertWithString:@"请选择缴费项"];
    }else{
        
        KindOfVoucherViewController * voucherVC = [[KindOfVoucherViewController alloc] init];
        voucherVC.payType = 1;
        voucherVC.billIDString = self.billIDString;
        voucherVC.money = [NSString stringWithFormat:@"%.1f", self.totalMoney];
        [self.navigationController pushViewController:voucherVC animated:YES];
    }
    
    
}

    
//tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.checkArray.count;
    }else if (section == 1){
        return 1;
    }else {
        return self.historyArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE_SCALE_IPHONE6(5);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CheckModel * model = self.checkArray[indexPath.row];
        
        kindOfPayTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_pay" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.kindLabel.text = model.FeeItem;
        cell.costLabel.text = [NSString stringWithFormat:@"费用：%.1f元", [model.Amount doubleValue]];
        //选择
        [cell.checkButton addTarget:self action:@selector(selectAction:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.checkButton.BillID = model.BillID;
        cell.checkButton.FeeItem = model.FeeItem;
        cell.checkButton.Amount = model.Amount;
//        cell.checkButton.tag = 0;
        
        return cell;

    }else if (indexPath.section == 1){
        PayTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_jiaofei" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell.payButton addTarget:self action:@selector(payAction) forControlEvents:(UIControlEventTouchUpInside)];
        cell.totalLabel.text = [NSString stringWithFormat:@"总费用：%.1f", self.totalMoney];
        
        return cell;
        
    }else {
        
        PayHistoryTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_history" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        CheckModel * model = self.historyArray[indexPath.row];
        cell.timeLabel.text = model.BusiDate;
        cell.costLabel.text = [NSString stringWithFormat:@"总缴费：%.1f", [model.TotalFee doubleValue]];
        return cell;
        
    }
    
}

//选择按钮
-(void)selectAction:(HeadButton *)sender {
    
    if (sender.tag == 0) {
        [sender setImage:[UIImage imageNamed:@"961"] forState:normal];
        [self.billArray addObject:sender.BillID];
        self.totalMoney += [sender.Amount doubleValue];
        
        [self.tableView reloadData];
//        self.totalLabel.text = [NSString stringWithFormat:@"%d", self.totalMoney];
        sender.tag = 1;
        
    }else if (sender.tag == 1){
        [sender setImage:[UIImage imageNamed:@"960"] forState:normal];
        NSLog(@"%@", sender.BillID);
        
        self.totalMoney -= [sender.Amount doubleValue];
//        self.totalLabel.text = [NSString stringWithFormat:@"%d", self.totalMoney];
    
        for (int i = 0; i < self.billArray.count; i++) {
            if (sender.BillID == self.billArray[i]) {
                [self.billArray removeObject:sender.BillID];
            }else{
                NSLog(@"不匹配");
            }
        }
        
        [self.tableView reloadData];
        sender.tag = 0;
        
    }else{
        [sender setImage:[UIImage imageNamed:@"961"] forState:normal];
        [self.billArray addObject:sender.BillID];
        self.totalMoney += [sender.Amount doubleValue];
        
        [self.tableView reloadData];
        //        self.totalLabel.text = [NSString stringWithFormat:@"%d", self.totalMoney];
        sender.tag = 1;
    }
    
    NSLog(@"%@", self.billArray);
//    [self.tableView reloadData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        CheckModel * model = self.checkArray[indexPath.row];

        kindOfPayTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.checkButton.tag == 0) {
            [cell.checkButton setImage:[UIImage imageNamed:@"961"] forState:normal];
            [self.billArray addObject:model.BillID];
            self.totalMoney += [model.Amount doubleValue];
            
            [self.tableView reloadData];
            //        self.totalLabel.text = [NSString stringWithFormat:@"%d", self.totalMoney];
            cell.checkButton.tag = 1;
            
        }else if (cell.checkButton.tag == 1){
            [cell.checkButton setImage:[UIImage imageNamed:@"960"] forState:normal];
            NSLog(@"%@", model.BillID);
            
            self.totalMoney -= [model.Amount doubleValue];
            //        self.totalLabel.text = [NSString stringWithFormat:@"%d", self.totalMoney];
            
            for (int i = 0; i < self.billArray.count; i++) {
                if (model.BillID == self.billArray[i]) {
                    [self.billArray removeObject:model.BillID];
                }else{
                    NSLog(@"不匹配");
                }
            }
            
            [self.tableView reloadData];
            cell.checkButton.tag = 0;
            
        }else{
            [cell.checkButton setImage:[UIImage imageNamed:@"961"] forState:normal];
            [self.billArray addObject:model.BillID];
            self.totalMoney += [model.Amount doubleValue];
            
            [self.tableView reloadData];
            //        self.totalLabel.text = [NSString stringWithFormat:@"%d", self.totalMoney];
            cell.checkButton.tag = 1;
        }
        
        NSLog(@"%@", self.billArray);
        //    [self.tableView reloadData];
    }
    
    if (indexPath.section == 2) {
        PayDetailViewController * payVC = [[PayDetailViewController alloc] init];
        CheckModel * model = self.historyArray[indexPath.row];
        
        payVC.BusinessFlow = model.BusinessFlow;
        
        [self.navigationController pushViewController:payVC animated:YES];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(50);
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
