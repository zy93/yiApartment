//
//  OutLetsPayViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "OutLetsPayViewController.h"
#import "Header.h"

@interface OutLetsPayViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UIView * introView;
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, assign)NSInteger different;
@property(nonatomic, strong)UILabel * sumLabel;
@property(nonatomic, assign)double sumMoney;
@property(nonatomic, strong)UIButton * payBT;

@property(nonatomic, strong)NSString * productString;

@end

@implementation OutLetsPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeData];
    [self setupViews];

}
-(void)makeData {
    
}

-(void)topView{
    //商品详情view
    _introView = [[UIView alloc] init];
    _introView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_introView];
    [_introView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(42.5));
    }];
    
    //商品名称
    UILabel * nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"商品名称";
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    _pricelabel = [UIColor yellowColor];
    [_introView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_introView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //价格
    UILabel * priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = [UIColor colorWithHexString:@"333333"];
    priceLabel.text = @"价格";
    //    _pricelabel = [UIColor yellowColor];
    [_introView addSubview:priceLabel];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_introView.mas_centerY);
        make.left.mas_equalTo(nameLabel.mas_right).offset(SIZE_SCALE_IPHONE6(50));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //数量
    UILabel * numberLabel = [[UILabel alloc] init];
    numberLabel.font = [UIFont systemFontOfSize:15];
    numberLabel.text = @"数量";
    numberLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    _pricelabel = [UIColor yellowColor];
    [_introView addSubview:numberLabel];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_introView.mas_centerY);
        make.left.mas_equalTo(priceLabel.mas_right).offset(SIZE_SCALE_IPHONE6(60));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //合计
    UILabel * totalLabel = [[UILabel alloc] init];
    totalLabel.font = [UIFont systemFontOfSize:15];
    totalLabel.textColor = [UIColor colorWithHexString:@"333333"];
    totalLabel.text = @"合计";
    //    _pricelabel = [UIColor yellowColor];
    [_introView addSubview:totalLabel];
    
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_introView.mas_centerY);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-30));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
}

-(void)setupViews{
    [self topView];
    
    
    [self.backBT addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.different = 0;
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[OutletsProductTableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_introView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, self.view.frame.size.width, SIZE_SCALE_IPHONE6(660));
    
    self.tableView.tableFooterView = bottomView;
    
    //总费用
    self.sumLabel = [[UILabel alloc] init];
    self.sumLabel.text = @"共计金额： 0元";
    self.sumLabel.font = [UIFont systemFontOfSize:18];
    [bottomView addSubview:self.sumLabel];
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(18));
    }];

    //共计金额
    for (ProductModel * model in self.addArray) {
        self.sumMoney += model.RealPrice;
    }
    
    self.sumLabel.text = [NSString stringWithFormat:@"共计金额  %.1f", self.sumMoney];
    
    //支付
    _payBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _payBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _payBT.titleLabel.font = [UIFont systemFontOfSize:18];
    _payBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _payBT.layer.masksToBounds = YES;
    [_payBT setTitle:@"支付" forState:(UIControlStateNormal)];
    [bottomView addSubview:self.payBT];
    
    [self.payBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.top.mas_equalTo(self.sumLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(20));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
    
    
    [self.payBT addTarget:self action:@selector(payAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)backAction{
    
    //        //在pop之前把值传走
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(passValue:dataArray:)]) {
        
        //使用协议方法传值
        [self.delegate passValue:self.showArray dataArray:self.addArray];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//支付
-(void)payAction{
    
    /**************
     //此处却判断是否第一次设置密码
     ***************/
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"UPassWord"] intValue] == 0) {
        
        GetCodeViewController * getCodeVC = [[GetCodeViewController alloc] init];
        
        [self.navigationController pushViewController:getCodeVC animated:YES];
        
        [self showAlertWithString:@"首次输入您的支付密码,需要验证您的手机号"];
    }
    else{
        PayCoinViewController * payVC = [[PayCoinViewController alloc] init];
        payVC.sumMoney = self.sumMoney;
        payVC.showArray = self.showArray;
        payVC.FID = self.FID;
        payVC.addArray = self.addArray;
        [self.navigationController pushViewController:payVC animated:YES];
    }
       
}


//tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.showArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    OutletsProductTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    ProductModel * model = self.showArray[indexPath.section];
    
    NSString * string = [NSString stringWithFormat:@"%@%@", BaseImageURL, model.PicPath];
    NSString * url = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [cell.productImv sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    cell.proNameLabel.text = model.ProName;
    cell.realPriceLabel.text = [NSString stringWithFormat:@"%.1f",model.RealPrice];
    cell.UnitLabel.text = model.Unit;
    
    cell.addBT.productModel = model;
    
    [cell.addBT addTarget:self action:@selector(addAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    NSInteger count = 0;
    
    for (ProductModel * model1 in self.addArray) {
        if (model1.ProductID == model.ProductID) {
            count += 1;
        }
    }
    
    cell.numberTF.text = [NSString stringWithFormat:@"%ld",count];
    
    cell.reduceBT.productModel = model;
    [cell.reduceBT addTarget:self action:@selector(reduceAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    cell.totalLabel.text = [NSString stringWithFormat:@"%@元",[NSString stringWithFormat:@"%.1f", model.RealPrice * count]];

    return cell;
    
}

//+
-(void)addAction:(HeadButton *)sender{
    
    [self.addArray addObject:sender.productModel];
    
    [self.tableView reloadData];
    
    self.sumMoney = 0;
    
    for (ProductModel * model in self.addArray) {
        self.sumMoney += model.RealPrice;
    }
    
    self.sumLabel.text = [NSString stringWithFormat:@"共计金额  %.1f", self.sumMoney];
    
}

//-  减到1之后删除这条数据
-(void)reduceAction:(HeadButton *)sender {
   
    [self.addArray removeObject:sender.productModel inRange:NSMakeRange([self.addArray indexOfObject:sender.productModel], 1)];

    for (ProductModel * model in self.addArray) {
        if (sender.productModel.ProductID == model.ProductID) {
            self.different = 1;
            break;
        }else{
            
        }
    }
    
    if (self.different == 0) {
        [self.showArray removeObject:sender.productModel];
    }else{
        
    }
    self.different = 0;
    
    [self.tableView reloadData];
    
    //实时计算价格
    self.sumMoney = 0;
    for (ProductModel * model in self.addArray) {
        self.sumMoney += model.RealPrice;
    }
    
    self.sumLabel.text = [NSString stringWithFormat:@"共计金额  %.1f", self.sumMoney];

}

//左划删除一行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModel * model = self.showArray[indexPath.section];
    
    [self.showArray removeObject:model];
    [self.addArray removeObject:model];
    
    [self.tableView reloadData];
    
    //删除商品后重新计算价格
    self.sumMoney = 0;
    for (ProductModel * model in self.addArray) {
        self.sumMoney += model.RealPrice;
    }
    self.sumLabel.text = [NSString stringWithFormat:@"共计金额  %.1f", self.sumMoney];
    
}

//删除的样式
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(90);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
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
