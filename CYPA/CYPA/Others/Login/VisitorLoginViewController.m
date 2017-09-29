//
//  VisitorLoginViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "VisitorLoginViewController.h"
#import "Header.h"

@interface VisitorLoginViewController ()<UITextFieldDelegate>
@property(nonatomic, strong)UIImageView *backgroudImv;
@property(nonatomic, strong)UIImageView *loginBackImv;
@property(nonatomic, strong)UITextField *userName;
@property(nonatomic, strong)UITextField *passWord;
@property(nonatomic, strong)UIButton *loginBT;
@property(nonatomic, strong)UIButton *codeBT;

//120后获取验证码
@property (nonatomic,assign) int seconds;
@property (nonatomic,strong) NSTimer *timerDown;

@end

@implementation VisitorLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景
    self.backgroudImv = [[UIImageView alloc] init];
    self.backgroudImv.frame = self.view.bounds;
    self.backgroudImv.image = [UIImage imageNamed:@"组-2"];
    [self.view addSubview:self.backgroudImv];

    //登陆背景
    self.loginBackImv = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE_SCALE_IPHONE6(35), kScreenHeight - SIZE_SCALE_IPHONE6(250), SIZE_SCALE_IPHONE6(307), SIZE_SCALE_IPHONE6(166))];
    self.loginBackImv.image = [UIImage imageNamed:@"圆角矩形-1"];
    [self.view addSubview:self.loginBackImv];
    
    //用户名
    self.userName = [[UITextField alloc] init];
    self.userName.placeholder = @"请输入您的手机号码";
    self.userName.delegate = self;
    self.userName.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.userName];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.loginBackImv.mas_top).offset(10);
        make.left.mas_equalTo(self.loginBackImv.mas_left).offset(34.5);
        make.size.mas_equalTo(CGSizeMake(244, 35));
    }];
    
    UIImageView * bottomLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE_SCALE_IPHONE6(34.5), SIZE_SCALE_IPHONE6(45), SIZE_SCALE_IPHONE6(244), 1)];
    bottomLine1.image = [UIImage imageNamed:@"形状-7"];
    [self.loginBackImv addSubview:bottomLine1];
    
    //返回
    UIButton * backBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBT setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:normal];
    [self.view addSubview:backBT];
    
    [backBT addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [backBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(20));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(10));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(43.5), SIZE_SCALE_IPHONE6(43.5)));
    }];
    
    //获取验证码
    self.codeBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.codeBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.codeBT setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.codeBT.titleLabel.font = [UIFont systemFontOfSize:14];
    self.codeBT.layer.cornerRadius = 3;
    [self.codeBT setTitle:@"    验证码    " forState:(UIControlStateNormal)];
    [self.view addSubview:self.codeBT];
    
    //获取验证码
    [self.codeBT addTarget:self action:@selector(getCodeAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.codeBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.userName.mas_centerY);
        make.right.mas_equalTo(self.loginBackImv.mas_right).offset(SIZE_SCALE_IPHONE6(-12.5));
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(63), SIZE_SCALE_IPHONE6(20)));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
        
    }];
    
    //验证码
    self.passWord = [[UITextField alloc] init];
    self.passWord.placeholder = @"请输入验证码";
    self.passWord.delegate = self;
    [self.view addSubview:self.passWord];
    
    [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.userName.mas_bottom).offset(0);
        make.left.mas_equalTo(self.userName.mas_left);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(244), SIZE_SCALE_IPHONE6(35)));
    }];
    
    UIImageView * bottomLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE_SCALE_IPHONE6(34.5), SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(244), 1)];
    bottomLine2.image = [UIImage imageNamed:@"形状-7"];
    [self.loginBackImv addSubview:bottomLine2];
    
    //登陆
    self.loginBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [self.loginBT setTitle:@"登录" forState:(UIControlStateNormal)];
    [self.loginBT setTintColor:[UIColor whiteColor]];
    //    [self.loginBT setImage:[UIImage imageNamed:@"圆角矩形-2-拷贝"] forState:UIControlStateNormal];
    self.loginBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    self.loginBT.layer.cornerRadius = 3;
    [self.view addSubview:self.loginBT];
    
    [self.loginBT addTarget:self action:@selector(loginAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.loginBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWord.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.centerX.mas_equalTo(self.loginBackImv);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(100),SIZE_SCALE_IPHONE6(30)));
    }];
    
    //注：
    UILabel * promptLabel = [[UILabel alloc] init];
    promptLabel.text = @"注：访客进入页面可体验享受部分功能!";
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.font = [UIFont systemFontOfSize:14.5];
    promptLabel.textColor = [UIColor grayColor];
    [self.view addSubview:promptLabel];
    
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.loginBackImv).offset(SIZE_SCALE_IPHONE6(-5));
        make.centerX.mas_equalTo(self.loginBackImv);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
        make.width.mas_equalTo(self.loginBackImv);
        
    }];
    
    
}

-(void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//获取验证码
-(void)getCodeAction {
    
    if ([self.userName.text length] == 0) {
        [self showAlertWithString:@"手机号不能为空"];
    } else {
        self.codeBT.userInteractionEnabled = NO;
        self.codeBT.backgroundColor = [UIColor colorWithHexString:@"777777"];
        self.seconds = 120;
        //120s后重新获取
        self.timerDown = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getcodeOKAction:) userInfo:nil repeats:YES];
        
        NSMutableDictionary * dictory = [[NSMutableDictionary alloc] init];
        
        [dictory setValue:self.userName.text forKey:@"phone"];
        
        [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/common/getCode" success:^(NSMutableDictionary * dict) {
//            NSLog(@"%@", dict);
            XPCertificate * model = [[XPCertificate alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            if ([model.code isEqualToString:@"0"]) {
                
                [self showAlertWithString:model.message];
            }else{
                [self showAlertWithString:model.message];
            }
            
        } failed:^{
            
            [self showAlertWithString:@"未知错误"];
        }];
    }
}

-(void)getcodeOKAction:(id)sender{
    
    self.seconds --;
    self.codeBT.titleLabel.text = [NSString stringWithFormat:@"%d后获取",self.seconds];
    
    if (self.seconds == 0) {
        [self.timerDown invalidate];
        self.codeBT.titleLabel.text = @"获取验证码";
        self.codeBT.userInteractionEnabled = YES;
        self.codeBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    }
}


//登陆
-(void)loginAction {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:self.userName.text forKey:@"phone"];
    [dictory setValue:self.passWord.text forKey:@"password"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/visitor/authenticate" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            RootTabBarController * rootVC = [[RootTabBarController alloc] init];
            
            [[NSUserDefaults standardUserDefaults] setObject:self.userName.text forKey:@"phone"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"state"];
            
            [self.navigationController pushViewController:rootVC animated:YES];
        }else{
            [self showAlertWithString:@"验证码验证失败"];
        }
    } failed:^{
        
        [self showAlertWithString:@"参数错误"];
        
    }];
    
}

//texField delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect frame = self.view.frame;
    frame.origin.y = -180;
    self.view.frame = frame;
    
    return YES;
}

//点击空白回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
    [self.view endEditing:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
