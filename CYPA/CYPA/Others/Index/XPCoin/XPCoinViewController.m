//
//  XPCoinViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "XPCoinViewController.h"
#import "Header.h"
#import "GetCodeViewController.h"



@interface XPCoinViewController ()

@property(nonatomic, strong)UILabel * CoinCountLabel;
@property(nonatomic, strong)UIButton * voucherBT;
@property(nonatomic, strong)UIButton * payBT;


@end

@implementation XPCoinViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self makeData];
}


-(void)makeData {
    //获取用户的余额
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
//    NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/rmb/balance" success:^(NSMutableDictionary * dict) {
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.CoinCountLabel.text = [NSString stringWithFormat:@"￥ %@", dict[@"data"][@"Balance"]];
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        
    } failed:^{
        NSLog(@"获取用户信息失败");
    }];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    [self setupViews];
    
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UPassWord"]);
    
    //判断用户是否设置了支付密码,没有的话跳转到设置支付密码
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"UPassWord"] intValue] == 0) {
        [self showAlertWithString:@"首次输入您的支付密码,需要验证您的手机号"];

        GetCodeViewController * getCodeVC = [[GetCodeViewController alloc] init];
        [self.navigationController pushViewController:getCodeVC animated:YES];
    }
    
    
//    [self afn];


}

-(void)setupViews{
    //历史账单
    UIButton * historyBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [historyBT setTitle:@"历史账单" forState:(UIControlStateNormal)];
    historyBT.titleLabel.font = [UIFont systemFontOfSize:15];
    historyBT.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:historyBT];
    
    [historyBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_top);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(43.5)));
    }];
    
    [historyBT addTarget:self action:@selector(historyAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //上部View
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(180));
    }];
    
    //新派币余额
    UILabel * moneyLabel = [[UILabel alloc] init];
    moneyLabel.text = @"新派币余额";
    moneyLabel.font = [UIFont systemFontOfSize:15];
    moneyLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:moneyLabel];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(0));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(100), SIZE_SCALE_IPHONE6(25)));
    }];
    
    //新派币图标
    UIImageView * coinImv = [[UIImageView alloc] init];
    coinImv.image = [UIImage imageNamed:@"未标题-11"];
    [topView addSubview:coinImv];
    
    [coinImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(27.5));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(70), SIZE_SCALE_IPHONE6(70)));
    }];
    
    //新派币数量
    self.CoinCountLabel = [[UILabel alloc] init];
    self.CoinCountLabel.text = @"￥0   ";
    self.CoinCountLabel.textAlignment = NSTextAlignmentCenter;
    self.CoinCountLabel.font = [UIFont systemFontOfSize:18];
    self.CoinCountLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [topView addSubview:self.CoinCountLabel];
    
    [self.CoinCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(coinImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    //充值按钮
    self.voucherBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.voucherBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    self.voucherBT.layer.cornerRadius = 3;
    self.voucherBT.layer.masksToBounds = YES;
    [self.voucherBT setTitle:@"充值" forState:(UIControlStateNormal)];
    //暂时隐藏充值按钮
    self.voucherBT.hidden = YES;
    
    [self.view addSubview:self.voucherBT];
    
    [self.voucherBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.CoinCountLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
    
    //充值
    [self.voucherBT addTarget:self action:@selector(voucherAction) forControlEvents:(UIControlEventTouchUpInside)];

    //去缴费
    self.payBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.payBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    self.payBT.layer.cornerRadius = 3;
    self.payBT.layer.masksToBounds = YES;
    [self.payBT setTitle:@"去缴费" forState:(UIControlStateNormal)];
    self.payBT.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.payBT];
    
    [self.payBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(-11));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(22)));
    }];
    
    [self.payBT addTarget:self action:@selector(payAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    //下部View
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIView * view1 = [[UIView alloc] init];
    [bottomView addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(40));
    }];
    
    UIView * view1bottom = [[UIView alloc] init];
    view1bottom.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [bottomView addSubview:view1bottom];
    
    [view1bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(1));
    }];

    
    
    UIView * view2 = [[UIView alloc] init];
    [bottomView addSubview:view2];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(40));
    }];
    
    UIView * view2bottom = [[UIView alloc] init];
    view2bottom.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [bottomView addSubview:view2bottom];
    
    [view2bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(1));
    }];
    
    //密码设置
    UILabel * passWordSettingLabel = [[UILabel alloc] init];
    passWordSettingLabel.text = @"密码设置";
    passWordSettingLabel.font = [UIFont systemFontOfSize:15];
    [view1 addSubview:passWordSettingLabel];
    
    [passWordSettingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.bottom.mas_equalTo(0);
    }];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"iconfont-arrowdown"] forState:(UIControlStateNormal)];
    [self.view addSubview:button1];
    
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view1.mas_centerY);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-25));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(7), SIZE_SCALE_IPHONE6(16)));
    }];
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(passwordSettingAction)];
    [view1 addGestureRecognizer:tap1];
    
    
    //生活购物
    UILabel * shoppingLabel = [[UILabel alloc] init];
    shoppingLabel.text = @"生活购物";
    shoppingLabel.font = [UIFont systemFontOfSize:15];
    [view2 addSubview:shoppingLabel];
    
    [shoppingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.bottom.mas_equalTo(0);
    }];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:[UIImage imageNamed:@"iconfont-arrowdown"] forState:(UIControlStateNormal)];
    [self.view addSubview:button2];
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view2.mas_centerY);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-25));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(7), SIZE_SCALE_IPHONE6(16)));
    }];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shoppingAction)];
    [view2 addGestureRecognizer:tap2];
    
    
    //新派币使用说明
    UILabel * introduceLabel = [[UILabel alloc] init];
    introduceLabel.text = @"新派币使用说明：";
    introduceLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:introduceLabel];
    
    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_bottom).offset(5);
        make.left.mas_equalTo(passWordSettingLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    UILabel * explain1Label = [[UILabel alloc] init];
    explain1Label.text = @"● 新派币可以用于打折商品消费以及住房费用。";
    explain1Label.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [bottomView addSubview:explain1Label];
    
    [explain1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introduceLabel.mas_bottom).offset(7.5);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(32.5));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-20));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    UILabel * explain2Label = [[UILabel alloc] init];
    explain2Label.text = @"● 如需提现，请到前台办理。";
    explain2Label.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [bottomView addSubview:explain2Label];
    
    [explain2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(explain1Label.mas_bottom).offset(7.5);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(32.5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];

}


//点击充值
-(void)voucherAction {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UPassWord"] == false) {
        GetCodeViewController * codeVC = [[GetCodeViewController alloc] init];
        [self.navigationController pushViewController:codeVC animated:YES];
        
    }else{
        VoucherViewController * voucherVC = [[VoucherViewController alloc] init];
        [self.navigationController pushViewController:voucherVC animated:YES];
    }
}

//去缴费
-(void)payAction {
    
    KindOfPayViewController * payVC = [[KindOfPayViewController alloc] init];
    
    [self.navigationController pushViewController:payVC animated:YES];
    
}

//历史账单
-(void)historyAction {
    PayHistoryViewController * payHistoryVC = [[PayHistoryViewController alloc] init];
    
    [self.navigationController pushViewController:payHistoryVC animated:YES];
}

//密码设置
-(void)passwordSettingAction {
    
    CoinPassWordSettingViewController * passwordVC = [[CoinPassWordSettingViewController alloc] init];
    [self.navigationController pushViewController:passwordVC animated:YES];
    
}

//生活购物
-(void)shoppingAction {
    OutletsViewController * outletsVC = [[OutletsViewController alloc] init];
    outletsVC.justKind = 1;
    [self.navigationController pushViewController:outletsVC animated:YES];
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
