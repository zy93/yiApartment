//
//  PasswordSettingViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PasswordSettingViewController.h"
#import "Header.h"
@interface PasswordSettingViewController ()
@property(nonatomic, strong)UITextField * passwordTF;
@property(nonatomic, strong)UILabel * passwordLabel;

@end

@implementation PasswordSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViews];

}

-(void)setupViews{
    self.passwordLabel = [[UILabel alloc] init];
    self.passwordLabel.text = @"设置6位支付密码";
    [self.view addSubview:self.passwordLabel];
    
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.passwordTF = [[UITextField alloc] init];
    self.passwordTF.layer.borderWidth = 0.5;
    self.passwordTF.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(40)];
    self.passwordTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(60));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(250), SIZE_SCALE_IPHONE6(40)));
    }];
    
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
