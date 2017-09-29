//
//  KindOfPayViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/15.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "KindOfPayViewController.h"
#import "Header.h"
#import "KindOfVoucherViewController.h"

@interface KindOfPayViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSMutableArray * checkArray;

@property(nonatomic, strong)UILabel * totalLabel;
//待缴费数组
@property(nonatomic, strong)NSMutableArray * billArray;
@property(nonatomic, strong)NSMutableString * billIDString;

@property(nonatomic, assign)double totalMoney;

@end

@implementation KindOfPayViewController

-(void)viewWillAppear:(BOOL)animated {
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
    
    //获取缴费列表
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    //    NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/rmb/listUnPay" success:^(NSMutableDictionary * dict) {
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
    

    
}

-(void)setupViews {
    self.billArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[kindOfPayTableViewCell class] forCellReuseIdentifier:@"CELL_pay"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(0));
    }];
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, SIZE_SCALE_IPHONE6(68), self.view.frame.size.width, SIZE_SCALE_IPHONE6(40));
    
    self.tableView.tableFooterView = bottomView;
    
    //总费用
    self.totalLabel = [[UILabel alloc] init];
    self.totalLabel.text = @"总费用： 0";
    self.totalLabel.font = [UIFont systemFontOfSize:15];
    self.totalLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [bottomView addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //缴费
    UIButton * payButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    payButton.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    payButton.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    payButton.layer.masksToBounds = YES;
    payButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [payButton setTitle:@"缴费" forState:(UIControlStateNormal)];
    [bottomView addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.centerY.mas_equalTo(self.totalLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
    
    [payButton addTarget:self action:@selector(payAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

//缴费
-(void)payAction {
    //验证密码
    
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
        
//        CheckPasswordViewController * checkVC = [[CheckPasswordViewController alloc] init];
//        checkVC.billIDString = self.billIDString;
//        checkVC.totalMoney = self.totalMoney;
//        [self.navigationController pushViewController:checkVC animated:YES];
    }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.checkArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CheckModel * model = self.checkArray[indexPath.row];
    kindOfPayTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_pay" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.kindLabel.text = model.FeeItem;
    cell.costLabel.text = [NSString stringWithFormat:@"费用：%@元", model.Amount];
    //选择
    [cell.checkButton addTarget:self action:@selector(selectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.checkButton.BillID = model.BillID;
    cell.checkButton.FeeItem = model.FeeItem;
    cell.checkButton.Amount = model.Amount;
    cell.checkButton.tag = 0;
    
    return cell;
}

//选择按钮
-(void)selectAction:(HeadButton *)sender {
  
    if (sender.tag == 0) {
        [sender setImage:[UIImage imageNamed:@"961"] forState:normal];
        sender.tag = 1;
        [self.billArray addObject:sender.BillID];
        self.totalMoney += [sender.Amount intValue];
        self.totalLabel.text = [NSString stringWithFormat:@"总金额：%.1f", self.totalMoney];
        
    }else {
        [sender setImage:[UIImage imageNamed:@"960"] forState:normal];
        sender.tag = 0;
        NSLog(@"%@", sender.BillID);
        self.totalMoney -= [sender.Amount doubleValue];
        self.totalLabel.text = [NSString stringWithFormat:@"总金额：%.1f", self.totalMoney];
        for (int i = 0; i < self.billArray.count; i++) {
            
            if (sender.BillID == self.billArray[i]) {
                [self.billArray removeObject:sender.BillID];
            }else{
                NSLog(@"不匹配");
            }
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(50);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kindOfPayTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (cell.checkButton.tag == 0) {
        [cell.checkButton setImage:[UIImage imageNamed:@"961"] forState:normal];
        cell.checkButton.tag = 1;
        
        [self.billArray addObject:cell.checkButton.BillID];
        
        self.totalMoney += [cell.checkButton.Amount intValue];
        
        self.totalLabel.text = [NSString stringWithFormat:@"总金额：%.1f", self.totalMoney];
        
    }else {
        [cell.checkButton setImage:[UIImage imageNamed:@"960"] forState:normal];
        cell.checkButton.tag = 0;
        NSLog(@"%@", cell.checkButton.BillID);
        
        self.totalMoney -= [cell.checkButton.Amount intValue];
        
        self.totalLabel.text = [NSString stringWithFormat:@"总金额：%.1f", self.totalMoney];

        for (int i = 0; i < self.billArray.count; i++) {
            
            if (cell.checkButton.BillID == self.billArray[i]) {
                [self.billArray removeObject:cell.checkButton.BillID];
            }else{
                NSLog(@"不匹配");
            }
        }
    }
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
