//
//  GetCodeViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "GetCodeViewController.h"
#import "Header.h"

@interface GetCodeViewController ()
@property(nonatomic, strong)UITextField *codeTF;
@property(nonatomic, strong)UIButton *testBT;
@property(nonatomic, strong)UIButton * getCodeBT;
@property(nonatomic, strong)NSString * code;

@property (nonatomic,assign) int seconds;
@property (nonatomic,strong) NSTimer *timerDown;

@end

@implementation GetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


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
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(90));
    }];
    
    //手机号
    UILabel * phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = [NSString stringWithFormat:@"手机账号：%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]];
    phoneLabel.textColor = [UIColor colorWithHexString:@"333333"];

    phoneLabel.font = [UIFont systemFontOfSize:15];
    [topView addSubview:phoneLabel];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(SIZE_SCALE_IPHONE6(17.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    
    
    //验证码
    UILabel * codeLabel = [[UILabel alloc] init];
    codeLabel.text = @"验证码：";
    codeLabel.font = [UIFont systemFontOfSize:15];
    codeLabel.textAlignment = NSTextAlignmentRight;
    codeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:codeLabel];
    
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(17.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    //获取验证码
    self.getCodeBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.getCodeBT setTitle:@" 验证码 " forState:(UIControlStateNormal)];
    self.getCodeBT.tintColor = [UIColor whiteColor];
    self.getCodeBT.layer.cornerRadius = 3;
    self.getCodeBT.layer.masksToBounds = YES;
    self.getCodeBT.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.getCodeBT.titleLabel.font = [UIFont systemFontOfSize:15];
    self.getCodeBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.view addSubview:self.getCodeBT];
    
    [self.getCodeBT addTarget:self action:@selector(getCodeAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.getCodeBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-22.5));
        make.centerY.mas_equalTo(phoneLabel.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(25)));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));

    }];

    
    
    //验证验证码
    self.codeTF = [[UITextField alloc] init];
    self.codeTF.placeholder = @"请输入验证码";
    self.codeTF.font = [UIFont systemFontOfSize:15];
//    self.codeTF.textAlignment = NSTextAlignmentCenter;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.codeTF.textColor = [UIColor colorWithHexString:@"666666"];
    [self.view addSubview:self.codeTF];
    
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(codeLabel.mas_centerY);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-67));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(25));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(80));
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
    
    
    //验证
    self.testBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.testBT setTitle:@"验证" forState:(UIControlStateNormal)];
    self.testBT.tintColor = [UIColor whiteColor];
    self.testBT.layer.cornerRadius = 3;
    self.testBT.layer.masksToBounds = YES;
    self.testBT.titleLabel.font = [UIFont systemFontOfSize:15];
    self.testBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.view addSubview:self.testBT];
    
    //验证验证码
    [self.testBT addTarget:self action:@selector(testCodeAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.testBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
    
    
    
}

//获取验证码
-(void)getCodeAction{
    
//    if ([self.codeTF.text length] == 0) {
//        [self showAlertWithString:@"手机号不能为空"];
//    } else {
        self.getCodeBT.userInteractionEnabled = NO;
        self.getCodeBT.backgroundColor = [UIColor colorWithHexString:@"777777"];
        
        self.seconds = 120;
        //120s后重新获取
        self.timerDown = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getcodeOKAction:) userInfo:nil repeats:YES];
        
        NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
        [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] forKey:@"phone"];
        [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/common/getCode" success:^(NSMutableDictionary * dict) {
            NSLog(@"%@", dict);
            if ([dict[@"code"] isEqualToString:@"0"]) {
                
                self.code = dict[@"data"][@"code"];
            }else{
                [self showAlertWithString:@"获取验证码失败"];
            }
        } failed:^{
            NSLog(@"未知错误");
        }];
//    }
}

-(void)getcodeOKAction:(id)sender{
    self.seconds --;
    self.getCodeBT.titleLabel.text = [NSString stringWithFormat:@"%dS",self.seconds];
    
    if (self.seconds == 0) {
        [self.timerDown invalidate];
        self.getCodeBT.titleLabel.text = @"获取验证码";
        self.getCodeBT.userInteractionEnabled = YES;
        self.getCodeBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    }
}

//验证验证码
-(void)testCodeAction{
    if ([self.codeTF.text isEqualToString:@""]) {
        [self showAlertWithString:@"验证码不能为空"];
    }

    if ([self.code isEqualToString:self.codeTF.text]) {
        PassWordViewController * passwordVC = [[PassWordViewController alloc] init];
        
        passwordVC.code = self.code;
        
        [self.navigationController pushViewController:passwordVC animated:YES];
    }else{
        [self showAlertWithString:@"验证码错误"];
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
