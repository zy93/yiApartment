//
//  VoucherViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/3.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "VoucherViewController.h"
#import "Header.h"
@interface VoucherViewController ()<UITextFieldDelegate>

@end

@implementation VoucherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    
    [self setupViews];

}

-(void)setupViews{
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
    moneyLabel.text = @"金额：";
    moneyLabel.font = [UIFont systemFontOfSize:15];
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:moneyLabel];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];

    //充值金额数
    self.moneyTF = [[UITextField alloc] init];
//    moneyLabel.text = @"金额：";
    self.moneyTF.font = [UIFont systemFontOfSize:15];
    self.moneyTF.textAlignment = NSTextAlignmentCenter;
    self.moneyTF.keyboardType = UIKeyboardTypeNumberPad;
    self.moneyTF.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.moneyTF.textColor = [UIColor colorWithHexString:@"666666"];
    [self.view addSubview:self.moneyTF];
    
    [self.moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-67));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(25));
        make.width.mas_equalTo(SIZE_SCALE_IPHONE6(240));
    }];
    
    
    //下部View
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    //充值
    self.voucherBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.voucherBT setTitle:@"充值" forState:(UIControlStateNormal)];
    self.voucherBT.tintColor = [UIColor whiteColor];
    self.voucherBT.layer.cornerRadius = 3;
    self.voucherBT.layer.masksToBounds = YES;
    self.voucherBT.titleLabel.font = [UIFont systemFontOfSize:18.f];
    self.voucherBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.view addSubview:self.voucherBT];
    
    //充值按钮
    [self.voucherBT addTarget:self action:@selector(voucherAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.voucherBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];


    
}

//点击充值
-(void)voucherAction {
    
    if ([self.moneyTF.text isEqualToString:@""]) {
        [self showAlertWithString:@"请输入充值金额"];
    }else {
        KindOfVoucherViewController * kindVC = [[KindOfVoucherViewController alloc] init];
        kindVC.money = self.moneyTF.text;
        [self.navigationController pushViewController:kindVC animated:YES];
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
