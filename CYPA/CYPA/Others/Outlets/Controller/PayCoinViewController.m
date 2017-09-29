//
//  PayCoinViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PayCoinViewController.h"
#import "Header.h"
#import "WXApi.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "APAuthV2Info.h"
#import "AlipayManager.h"

@interface PayCoinViewController ()
@property(nonatomic, strong)UIImageView * coinImv;
//@property(nonatomic, strong)UIView * coinView;
//@property(nonatomic, assign)NSInteger checkNum;
//@property(nonatomic, strong)UIButton *sureBT;
@property(nonatomic, strong)UIButton * voucherBT;
@property(nonatomic, strong)NSMutableString * productString;
//@property(nonatomic, assign)double blanceNum;

@property(nonatomic, strong)UIImageView * checkWeChatImv;
@property(nonatomic, strong)UIImageView * checkAlipayImv;
@property(nonatomic, strong)UIImageView * checkCoinImv;

@property(nonatomic, strong)UIView * alipayView; //支付宝
@property(nonatomic, strong)UIView * weChatView; //微信
@property(nonatomic, strong)UIView * coinView; //新派币

@property(nonatomic, assign)NSInteger checkNum;
@property(nonatomic, strong)UIButton *sureBT;
@property(nonatomic, assign)double blanceNum; //新派币余额



@end

@implementation PayCoinViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self getBalanceNum];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    
    [self setupViews];
}

-(void)getBalanceNum{
    //获取用户的余额
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    //    NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/rmb/balance" success:^(NSMutableDictionary * dict) {
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.blanceNum =  [dict[@"data"][@"Balance"] doubleValue];
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
    } failed:^{
        NSLog(@"获取余额失败");
    }];
}


//商品购买只可以是用新派币
-(void)setupViews {
    //上部View
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    //充值金额
    UILabel * moneyLabel = [[UILabel alloc] init];
    moneyLabel.text = [NSString stringWithFormat:@"￥ %.1f", self.sumMoney];
    moneyLabel.font = [UIFont systemFontOfSize:23];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:moneyLabel];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(topView);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(25));
    }];
    
    //coin View
    UIView * coinView = [[UIView alloc] init];
    coinView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:coinView];
    
    [coinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    //新派币
    UIImageView * coinImv = [[UIImageView alloc] init];
    coinImv.image = [UIImage imageNamed:@"未标题-11"];
    [self.view addSubview:coinImv];
    
    [coinImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(coinView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(40), SIZE_SCALE_IPHONE6(33)));
    }];
    
    UILabel * coinLabel = [[UILabel alloc] init];
    coinLabel.text = @"新派币";
    coinLabel.font = [UIFont systemFontOfSize:15];
    coinLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.view addSubview:coinLabel];
    
    [coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(coinView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(110));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    //金额
    UILabel * coinCountLabel = [[UILabel alloc] init];
    coinCountLabel.text = [NSString stringWithFormat:@"￥ %.1f", self.sumMoney];
    coinCountLabel.font = [UIFont systemFontOfSize:15];
    coinCountLabel.textAlignment = NSTextAlignmentLeft;
    coinCountLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.view addSubview:coinCountLabel];
    
    [coinCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(coinView.mas_centerY);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
//    
//    //充值
//    self.voucherBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [self.voucherBT setTitle:@"充值" forState:(UIControlStateNormal)];
//    self.voucherBT.tintColor = [UIColor whiteColor];
//    self.voucherBT.layer.cornerRadius = 3;
//    self.voucherBT.layer.masksToBounds = YES;
//    self.voucherBT.titleLabel.font = [UIFont systemFontOfSize:18.f];
//    self.voucherBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
//    [self.view addSubview:self.voucherBT];
//    
//    //充值按钮
//    [self.voucherBT addTarget:self action:@selector(voucherAction) forControlEvents:(UIControlEventTouchUpInside)];
//    
//    [self.voucherBT mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
//        make.centerY.mas_equalTo(coinView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(65), SIZE_SCALE_IPHONE6(25)));
//    }];
//    
    //下部View
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(coinView.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    //确认支付
    self.sureBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.sureBT setTitle:@"确认支付" forState:(UIControlStateNormal)];
    self.sureBT.tintColor = [UIColor whiteColor];
    self.sureBT.layer.cornerRadius = 3;
    self.sureBT.layer.masksToBounds = YES;
    self.sureBT.titleLabel.font = [UIFont systemFontOfSize:18];
    self.sureBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.view addSubview:self.sureBT];
    
    //充值按钮
    [self.sureBT addTarget:self action:@selector(sureAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.sureBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(100), SIZE_SCALE_IPHONE6(25)));
    }];
    
}

//确认付款
-(void)sureAction{
    
    //跳转到支付密码界面
    TestPassWordViewController * testVC = [[TestPassWordViewController alloc] init];
    
    testVC.sumMoney = self.sumMoney;
    testVC.addArray = self.addArray;
    testVC.showArray = self.showArray;
    testVC.FID = self.FID;
    
    [self.navigationController pushViewController:testVC animated:YES];
}



/*
//商品购买可使用新派币,微信和支付宝
//
 -(void)setupViews {
 
 //上部View
 UIView * topView = [[UIView alloc] init];
 topView.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:topView];
 
 [topView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
 }];
 
 //支付金额
 UILabel * moneyLabel = [[UILabel alloc] init];
 moneyLabel.text = [NSString stringWithFormat:@"￥ %.1f", self.sumMoney];
 moneyLabel.font = [UIFont systemFontOfSize:23];
 moneyLabel.textAlignment = NSTextAlignmentCenter;
 moneyLabel.textColor = [UIColor colorWithHexString:@"333333"];
 [topView addSubview:moneyLabel];
 
 [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.center.mas_equalTo(topView);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(25));
 }];
 
 //中部View
 UIView * middleView = [[UIView alloc] init];
 middleView.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:middleView];
 
 //新派币
 self.coinView = [[UIView alloc] init];
 self.coinView.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:self.coinView];
 
 UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkCoinAction)];
 [self.coinView addGestureRecognizer:tap3];
 
 UIImageView * coinImv = [[UIImageView alloc] init];
 coinImv.image = [UIImage imageNamed:@"未标题-11"];
 [self.coinView addSubview:coinImv];
 
 [coinImv mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(self.coinView.mas_centerY);
 make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
 make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(40), SIZE_SCALE_IPHONE6(33)));
 }];
 
 UILabel * coinLabel = [[UILabel alloc] init];
 coinLabel.text = @"新派币";
 coinLabel.font = [UIFont systemFontOfSize:15];
 coinLabel.textColor = [UIColor colorWithHexString:@"333333"];
 [self.coinView addSubview:coinLabel];
 
 [coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(self.coinView.mas_centerY);
 make.left.mas_equalTo(SIZE_SCALE_IPHONE6(110));
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
 }];
 
 //选择
 self.checkCoinImv = [[UIImageView alloc] init];
 self.checkCoinImv.image = [UIImage imageNamed:@"correct"];
 //    self.checkCoinImv.hidden = YES;
 [self.view addSubview:self.checkCoinImv];
 
 [self.checkCoinImv mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(self.coinView.mas_centerY);
 make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
 make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
 }];
 
 //中线
 UIView * middleLine1 = [[UIView alloc] init];
 middleLine1.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
 [middleView addSubview:middleLine1];
 
 //微信
 self.weChatView = [[UIView alloc] init];
 self.weChatView.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:self.weChatView];
 
 UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkWeChatAction)];
 [self.weChatView addGestureRecognizer:tap1];
 
 
 UIImageView * wechatImv = [[UIImageView alloc] init];
 wechatImv.image = [UIImage imageNamed:@"图层-1-拷贝"];
 [self.weChatView addSubview:wechatImv];
 
 [wechatImv mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(self.weChatView.mas_centerY);
 make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
 make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(40), SIZE_SCALE_IPHONE6(33)));
 }];
 
 UILabel * weChatLabel = [[UILabel alloc] init];
 weChatLabel.text = @"微信";
 weChatLabel.font = [UIFont systemFontOfSize:15];
 weChatLabel.textColor = [UIColor colorWithHexString:@"333333"];
 [self.weChatView addSubview:weChatLabel];
 
 [weChatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(self.weChatView.mas_centerY);
 make.left.mas_equalTo(SIZE_SCALE_IPHONE6(110));
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
 }];
 
 //选择
 self.checkWeChatImv = [[UIImageView alloc] init];
 self.checkWeChatImv.image = [UIImage imageNamed:@"correct"];
 //    self.checkNum = 100;
 [self.view addSubview:self.checkWeChatImv];
 
 [self.checkWeChatImv mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(self.weChatView.mas_centerY);
 make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
 make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
 }];
 
 self.checkCoinImv.hidden = NO;
 self.checkAlipayImv.hidden = YES;
 self.checkWeChatImv.hidden = YES;
 self.checkNum = 103;
 
 if ([WXApi isWXAppInstalled]) {
 [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(150));
 }];
 
 [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(middleView.mas_top);
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
 }];
 
 [middleLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.coinView.mas_bottom);
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(1));
 }];
 
 [self.weChatView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(middleLine1.mas_top);
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
 }];
 
 //中线
 UIView * middleLine = [[UIView alloc] init];
 middleLine.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
 [middleView addSubview:middleLine];
 
 [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.weChatView.mas_bottom);
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(1));
 }];
 
 } else {
 
 [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(100));
 }];
 
 [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(middleView.mas_top);
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
 }];
 
 [middleLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.coinView.mas_bottom);
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(1));
 }];
 
 self.weChatView.hidden = YES;
 
 //中线
 UIView * middleLine = [[UIView alloc] init];
 middleLine.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
 [middleView addSubview:middleLine];
 
 [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.coinView.mas_bottom);
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(1));
 }];
 
 }
 
 //支付宝
 self.alipayView = [[UIView alloc] init];
 self.alipayView.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:self.alipayView];
 
 [self.alipayView mas_makeConstraints:^(MASConstraintMaker *make) {
 //        make.top.mas_equalTo(middleLine.mas_bottom);
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(49));
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.bottom.mas_equalTo(middleView);
 }];
 
 UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkAlipayAction)];
 [self.alipayView addGestureRecognizer:tap2];
 
 
 UIImageView * alipayImv = [[UIImageView alloc] init];
 alipayImv.image = [UIImage imageNamed:@"图层-1"];
 [self.view addSubview:alipayImv];
 
 [alipayImv mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(self.alipayView.mas_centerY);
 make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
 make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(59), SIZE_SCALE_IPHONE6(19)));
 }];
 
 UILabel * alipayLabel = [[UILabel alloc] init];
 alipayLabel.text = @"支付宝";
 alipayLabel.font = [UIFont systemFontOfSize:15];
 alipayLabel.textAlignment = NSTextAlignmentLeft;
 alipayLabel.textColor = [UIColor colorWithHexString:@"333333"];
 [self.alipayView addSubview:alipayLabel];
 
 [alipayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(self.alipayView.mas_centerY);
 make.left.mas_equalTo(SIZE_SCALE_IPHONE6(110));
 make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
 }];
 
 //选择
 self.checkAlipayImv = [[UIImageView alloc] init];
 self.checkAlipayImv.image = [UIImage imageNamed:@"correct"];
 self.checkAlipayImv.hidden = YES;
 [self.view addSubview:self.checkAlipayImv];
 
 [self.checkAlipayImv mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(self.alipayView.mas_centerY);
 make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
 make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
 }];
 
 //下部View
 UIView * bottomView = [[UIView alloc] init];
 bottomView.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:bottomView];
 
 [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(middleView.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
 make.left.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.bottom.mas_equalTo(0);
 }];
 
 //确认支付
 self.sureBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
 [self.sureBT setTitle:@"确认支付" forState:(UIControlStateNormal)];
 self.sureBT.tintColor = [UIColor whiteColor];
 self.sureBT.layer.cornerRadius = 3;
 self.sureBT.layer.masksToBounds = YES;
 self.sureBT.titleLabel.font = [UIFont systemFontOfSize:18];
 self.sureBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
 [self.view addSubview:self.sureBT];
 
 [self.sureBT addTarget:self action:@selector(sureAction) forControlEvents:(UIControlEventTouchUpInside)];
 
 [self.sureBT mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(25));
 make.centerX.mas_equalTo(self.view.mas_centerX);
 make.size.mas_equalTo(CGSizeMake(80, SIZE_SCALE_IPHONE6(25)));
 }];
 
 }
 
 //选择微信
 -(void)checkWeChatAction {
 self.checkAlipayImv.hidden = YES;
 self.checkWeChatImv.hidden = NO;
 self.checkCoinImv.hidden = YES;
 
 //跳转到微信
 self.checkNum = 100;
 }
 
 //选择支付宝
 -(void)checkAlipayAction {
 self.checkAlipayImv.hidden = NO;
 self.checkWeChatImv.hidden = YES;
 self.checkCoinImv.hidden = YES;
 
 //跳转到支付宝
 self.checkNum = 101;
 }
 
 //选择新派币
 -(void)checkCoinAction {
 self.checkAlipayImv.hidden = YES;
 self.checkWeChatImv.hidden = YES;
 self.checkCoinImv.hidden = NO;
 //跳转到新派币
 self.checkNum = 103;
 }
 
 //确认付款
-(void)sureAction{
    
    if(self.checkNum != 103){
        self.productString = [NSMutableString string];
        NSLog(@"%@", self.addArray);
        for (ProductModel * model in self.showArray) {
            
            NSInteger count = 0;
            for (ProductModel * model1 in self.addArray) {
                if (model.ProductID == model1.ProductID) {
                    count++;
                }
            }
            
            self.productString = [self.productString stringByAppendingString:[NSString stringWithFormat:@",%d-%ld-%.1f-%.1f", model.ProductID, count, model.RealPrice, model.Price]];
            
        }
        
        NSString * aString = [self.productString substringWithRange:NSMakeRange(1, self.productString.length - 1)];
        NSLog(@"####%@", aString);
        
        NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
        [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
        if (self.FID == NULL) {
            [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"FID"];
        }else{
            [dictory setValue:[NSString stringWithFormat:@"%@", self.FID] forKey:@"FID"];
            //        self.backBT.hidden = NO;
        }
        [dictory setValue:aString forKey:@"Product"];
        [dictory setValue:[NSString stringWithFormat:@"%.1f",self.sumMoney] forKey:@"TotalFee"];
        
        if (self.checkNum == 100) {
            //微信
            [dictory setValue:@"03_003_2" forKey:@"PayMode"];
            
        } else if (self.checkNum == 101){
            //支付宝
            [dictory setValue:@"03_003_3" forKey:@"PayMode"];
        }
        
        [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/order/order" success:^(NSMutableDictionary * dict) {
            
            NSLog(@"+++++%@", dict);
            if ([dict[@"code"] isEqualToString:@"0"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:dict[@"data"][@"OUT_TRADE_NO"] forKey:@"OUT_TRADE_NO"];
                if (self.checkNum == 100) {
                    //跳转微信支付
                    NSLog(@"微信支付");
                    //前端集成
                    [WXApiRequestHandler sendWXpayWithServerWithMoney:[NSString stringWithFormat:@"%f", _sumMoney]];
                    
                }else if (self.checkNum == 101){
                    //跳转支付宝支付
                    NSLog(@"支付宝支付");
                    
                    NSString * money = [NSString stringWithFormat:@"%.1f", _sumMoney];
                    
                    [AlipayManager sendAlipayWithServerWithMoney:money];
                }
                
            }else{
                [self showAlertWithString:@"提交订单失败"];
            }
            
        } failed:^{
            
            [self showAlert:@"提交订单失败"];
        }];

    }else{
        //新派币支付
        //判断用户余额是否足以支付
        if (self.sumMoney > self.blanceNum) {
            [self showAlertWithString:@"您的新派币余额不足"];
        } else {
            //跳转到支付密码界面
            TestPassWordViewController * testVC = [[TestPassWordViewController alloc] init];
            
            testVC.sumMoney = self.sumMoney;
            testVC.showArray = self.showArray;
            testVC.FID = self.FID;
            testVC.addArray = self.addArray;
            
            [self.navigationController pushViewController:testVC animated:YES];
        }

    }
}

//

*/

//充值
-(void)voucherAction{
    
    VoucherViewController * vourcherVC = [[VoucherViewController alloc] init];
    [self.navigationController pushViewController:vourcherVC animated:YES];
    
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
