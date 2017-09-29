//
//  ForgetPassWordViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ForgetPassWordViewController.h"
#import "Header.h"

@interface ForgetPassWordViewController ()
@property(nonatomic, strong)UITextField *codeTF;
@property(nonatomic, strong)UIButton *testBT;
@property(nonatomic, strong)UIButton * getCodeBT;
@property(nonatomic, strong)NSString * code;
@property(nonatomic, strong)UITextField * phoneTextField;
@property(nonatomic, strong)NSString * phoneString; //要修改的手机号

//120后获取验证码
@property (nonatomic,assign) int seconds;
@property (nonatomic,strong) NSTimer *timerDown;

@end

@implementation ForgetPassWordViewController


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
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(123));
    }];
    
    UILabel * phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"绑定手机验证：";
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [topView addSubview:phoneLabel];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(SIZE_SCALE_IPHONE6(17.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //手机号
    UILabel * phoneLabel1 = [[UILabel alloc] init];
    phoneLabel1.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    phoneLabel1.font = [UIFont systemFontOfSize:15];
    [topView addSubview:phoneLabel1];
    [phoneLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(112));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-120));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];

    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]) {
        phoneLabel1.hidden = YES;
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.placeholder = @"请输入要修改的手机号";
        _phoneTextField.font = [UIFont systemFontOfSize:14];
//        _phoneTextField.textAlignment = NSTextAlignmentCenter;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        _phoneTextField.textColor = [UIColor colorWithHexString:@"666666"];
        [topView addSubview:_phoneTextField];
        [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phoneLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
            make.left.mas_equalTo(SIZE_SCALE_IPHONE6(112));
            make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-120));
            make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
        }];
        
    } else {
        phoneLabel1.hidden = NO;
    }
    
    //获取验证码
    self.getCodeBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.getCodeBT setTitle:@"发送验证码" forState:(UIControlStateNormal)];
    self.getCodeBT.tintColor = [UIColor whiteColor];
    self.getCodeBT.layer.cornerRadius = 3;
    self.getCodeBT.layer.masksToBounds = YES;
    self.getCodeBT.titleLabel.font = [UIFont systemFontOfSize:13];
    self.getCodeBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.view addSubview:self.getCodeBT];
    
    //获取验证码
    [self.getCodeBT addTarget:self action:@selector(getCodeAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.getCodeBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-30));
        make.centerY.mas_equalTo(phoneLabel1.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(30)));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];
    
    //验证验证码
    self.codeTF = [[UITextField alloc] init];
    self.codeTF.placeholder = @"请输入验证码";
    self.codeTF.font = [UIFont systemFontOfSize:14];
//    self.codeTF.textAlignment = NSTextAlignmentCenter;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.codeTF.textColor = [UIColor colorWithHexString:@"666666"];
    [self.view addSubview:self.codeTF];
    
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel1.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(phoneLabel1.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
        make.right.mas_equalTo(phoneLabel1.mas_right);
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
    [self.testBT setTitle:@"确定" forState:(UIControlStateNormal)];
    self.testBT.tintColor = [UIColor whiteColor];
    self.testBT.layer.cornerRadius = 3;
    self.testBT.layer.masksToBounds = YES;
    self.testBT.titleLabel.font = [UIFont systemFontOfSize:13];
    self.testBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.view addSubview:self.testBT];
    
    //验证验证码
    [self.testBT addTarget:self action:@selector(testCodeAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.testBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(30)));
    }];
    
    
    
}

//获取验证码
-(void)getCodeAction{
    if ([_phoneTextField.text length] == 0) {
        [self showAlertWithString:@"手机号不能为空"];
    } else {
        self.getCodeBT.userInteractionEnabled = NO;
        self.getCodeBT.backgroundColor = [UIColor colorWithHexString:@"777777"];
        self.seconds = 120;
        //120s后重新获取
        self.timerDown = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getcodeOKAction:) userInfo:nil repeats:YES];
        
        NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
        
        _phoneString = [NSString string];
        //登录时
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]) {
            _phoneString = self.phoneTextField.text;
        }
        //没登录时
        else {
            _phoneString = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
        }
        [dictory setValue:_phoneString forKey:@"phone"];
        
        [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/common/getCode" success:^(NSMutableDictionary * dict) {
            if ([dict[@"code"] isEqualToString:@"0"]) {
                
                self.code = dict[@"data"][@"code"];
            }else{
                [self showAlertWithString:@"获取验证码失败"];
            }
        } failed:^{
            NSLog(@"未知错误");
        }];

    }
    
    
}

-(void)getcodeOKAction:(id)sender{
    
    self.seconds --;
    self.getCodeBT.titleLabel.text = [NSString stringWithFormat:@"%d后获取",self.seconds];
    
    if (self.seconds == 0) {
        [self.timerDown invalidate];
        self.getCodeBT.titleLabel.text = @"获取验证码";
        self.getCodeBT.userInteractionEnabled = YES;
        self.getCodeBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    }
}

//验证验证码
-(void)testCodeAction{
    
    if ([self.code isEqualToString:self.codeTF.text]) {
        
        ResertPassWordViewController * passwordVC = [[ResertPassWordViewController alloc] init];
        
        passwordVC.code = self.code;
        passwordVC.phoneString = self.phoneString;
        [self.navigationController pushViewController:passwordVC animated:YES];
        
    }else{
        [self showAlertWithString:@"验证码错误"];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    self.timerDown = nil;
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
