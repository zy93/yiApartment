//
//  KindOfVoucherViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/4.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "KindOfVoucherViewController.h"
#import "Header.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "APAuthV2Info.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WXApi.h"
#import "AlipayManager.h"

@interface KindOfVoucherViewController ()<WXApiManagerDelegate>
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

@implementation KindOfVoucherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    
    [self setupViews];
    
    //获取新派币余额
    [self getBalanceNum];
}

-(void)getBalanceNum{
    //获取用户的余额
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    //    NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/rmb/balance" success:^(NSMutableDictionary * dict) {
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.blanceNum = [dict[@"data"][@"Balance"] doubleValue];
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
    } failed:^{
        NSLog(@"获取余额失败");
    }];
}

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
    moneyLabel.text = [NSString stringWithFormat:@"￥ %@", self.money];
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
    
    //有新派币
    if (self.payType == 1) {
    
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
        
    }
    
    
//    else {
//        
//        self.checkCoinImv.hidden = YES;
//        self.checkAlipayImv.hidden = YES;
//        self.checkWeChatImv.hidden = NO;
//        self.checkNum = 100;
//
//        
//        [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
//            make.left.mas_equalTo(0);
//            make.right.mas_equalTo(0);
//            make.height.mas_equalTo(SIZE_SCALE_IPHONE6(100));
//        }];
//        
//        self.coinView.hidden = YES;
//        
//        
////        [self.weChatView mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.top.mas_equalTo(middleView.mas_top);
////            make.left.mas_equalTo(0);
////            make.right.mas_equalTo(0);
////            make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
////        }];
//        
//        [middleLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.coinView.mas_bottom);
//            make.left.mas_equalTo(0);
//            make.right.mas_equalTo(0);
//            make.height.mas_equalTo(SIZE_SCALE_IPHONE6(1));
//        }];
//        
//    }
    

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

//确认支付
-(void)sureAction {
    //生成订单号
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    [params setValue:self.money forKey:@"Amount"];
    
    //缴费
    if (self.payType == 1) {
        [params setValue:@"pay" forKey:@"Type"];
        [params setValue:self.billIDString forKey:@"BillID"];
    }
    //充值
    else {
        [params setValue:@"recharge" forKey:@"Type"];
    }
    
    NSLog(@"%@", params);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:params path:@"/rmb/order" success:^(NSMutableDictionary * dict) {
        
        [[NSUserDefaults standardUserDefaults] setObject:dict[@"OUT_TRADE_NO"] forKey:@"OUT_TRADE_NO"];
        
        if (self.checkNum == 100) {
            //跳转微信支付
            NSLog(@"微信支付");
            [self WXPayAction];
    
        }else if (self.checkNum == 101){
            //跳转支付宝支付
            NSLog(@"支付宝支付");
            [self AliPayAction];
            
        }else if (self.checkNum == 103) {
            
            if ([self.money doubleValue] > self.blanceNum) {
                [self showAlertWithString:@"新派币余额不足"];
            } else {
                CheckPasswordViewController * checkVC = [[CheckPasswordViewController alloc] init];
                checkVC.billIDString = self.billIDString;
                checkVC.totalMoney = [self.money intValue];
                [self.navigationController pushViewController:checkVC animated:YES];
            }
            
        }
        
        else{
            [self showAlertWithString:@"请选择支付方式"];
        }
        
    } failed:^{
        [MBProgressHUD showSuccess:@"支付失败"];
    }];
    
}

//跳转到微信支付
-(void)WXPayAction {
    
    //后台集成
//    [WXApiRequestHandler sendWXpay];

    //前端集成
    [WXApiRequestHandler sendWXpayWithServerWithMoney:_money];

    
}


//跳转到支付宝支付
-(void)AliPayAction {
    [AlipayManager sendAlipayWithServerWithMoney:_money];
    
}


#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    
    NSLog(@"订单号：%@",resultStr);
    
    return resultStr;
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
