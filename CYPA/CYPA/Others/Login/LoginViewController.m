//
//  LoginViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "LoginViewController.h"
#import "Header.h"
#import "ReadAgreeViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic, strong)UIImageView *backgroudImv;
@property(nonatomic, strong)UIImageView *loginBackImv;
@property(nonatomic, strong)UITextField *userName;
@property(nonatomic, strong)UITextField *passWord;
@property(nonatomic, strong)UIImageView *selectImv;
@property(nonatomic, assign)NSInteger select1;
@property(nonatomic, assign)NSInteger select2;
@property(nonatomic, strong)UIButton *forgetBT;
@property(nonatomic, strong)UIImageView *agreenImv;
@property(nonatomic, strong)UIButton *loginBT;
@property(nonatomic, strong)XPCitizen * citizenModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //若选择记住密码，则保存密码
    self.userName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    self.passWord.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    
    //背景
    self.backgroudImv = [[UIImageView alloc] init];
    self.backgroudImv.frame = self.view.bounds;
    self.backgroudImv.image = [UIImage imageNamed:@"组-2"];
    [self.view addSubview:self.backgroudImv];
    

    //登陆背景
    self.loginBackImv = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE_SCALE_IPHONE6(35), kScreenHeight - SIZE_SCALE_IPHONE6(250), SIZE_SCALE_IPHONE6(307), SIZE_SCALE_IPHONE6(183))];
    self.loginBackImv.image = [UIImage imageNamed:@"圆角矩形-1"];
    [self.view addSubview:self.loginBackImv];
    
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
    
    //用户名
    self.userName = [[UITextField alloc] init];
    self.userName.placeholder = @"请输入您的手机号码";
    self.userName.keyboardType = UIKeyboardTypeNumberPad;
    self.userName.delegate = self;
    self.userName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    [self.view addSubview:self.userName];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.loginBackImv.mas_top).offset(10);
        make.left.mas_equalTo(self.loginBackImv.mas_left).offset(34.5);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(244), SIZE_SCALE_IPHONE6(35)));
    }];
    
    UIImageView * bottomLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE_SCALE_IPHONE6(34.5), SIZE_SCALE_IPHONE6(45), SIZE_SCALE_IPHONE6(244), 1)];
        bottomLine1.image = [UIImage imageNamed:@"形状-7"];
    [self.loginBackImv addSubview:bottomLine1];

    //密码
    self.passWord = [[UITextField alloc] init];
    self.passWord.placeholder = @"请输入密码";
    self.passWord.delegate = self;
    self.passWord.secureTextEntry = YES;
//    self.passWord.text = @"123456";
    [self.view addSubview:self.passWord];
    
    [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.userName.mas_bottom).offset(0);
        make.left.mas_equalTo(self.userName.mas_left);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(244), SIZE_SCALE_IPHONE6(35)));
    }];
    
    UIImageView * bottomLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE_SCALE_IPHONE6(34.5), SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(244), 1)];
    bottomLine2.image = [UIImage imageNamed:@"形状-7"];
    [self.loginBackImv addSubview:bottomLine2];


    //记住密码
    self.selectImv = [[UIImageView alloc] init];
    self.selectImv.image = [UIImage imageNamed:@"圆角矩形-3"];
    self.select1 = 0;
    self.selectImv.userInteractionEnabled = YES;
    [self.view addSubview:self.selectImv];
    
    [self.selectImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWord.mas_bottom).offset(3);
        make.left.mas_equalTo(self.passWord.mas_left);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UILabel *rememberLabel = [[UILabel alloc] init];
    rememberLabel.text = @"记住密码";
    rememberLabel.font = [UIFont systemFontOfSize:14.f];
    [rememberLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:rememberLabel];
    
    [rememberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.selectImv.mas_centerY);
        make.left.mas_equalTo(self.selectImv.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80),SIZE_SCALE_IPHONE6(20)));
    }];
    
    UIButton * b1 = [UIButton buttonWithType:UIButtonTypeCustom];
    b1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:b1];
    
    [b1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectImv.mas_left);
        make.right.mas_equalTo(rememberLabel.mas_right);
        make.top.mas_equalTo(rememberLabel.mas_top);
        make.bottom.mas_equalTo(rememberLabel.mas_bottom);
    }];
    
    [b1 addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    //忘记密码
    self.forgetBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.forgetBT setTitle:@"忘记密码" forState:(UIControlStateNormal)];
    [self.forgetBT setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    self.forgetBT.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:self.forgetBT];
    
    [self.forgetBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(rememberLabel.mas_centerY);
        make.right.mas_equalTo(self.passWord.mas_right);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80),20));
    }];
    
    //忘记密码
    [self.forgetBT addTarget:self action:@selector(forgetAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //同意协议
    self.agreenImv = [[UIImageView alloc] init];
    self.agreenImv.image = [UIImage imageNamed:@"形状-8-拷贝"];
    self.select2 = 0;
    self.agreenImv.userInteractionEnabled = YES;
    [self.view addSubview:self.agreenImv];
    
    [self.agreenImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rememberLabel.mas_bottom).offset(11);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(105));
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    UIButton *readButton = [UIButton buttonTitle:@"阅读并同意服务条款" setBackground:nil andImage:nil titleColor:[UIColor grayColor] titleFont:13.f];
    [self.view addSubview:readButton];
    [readButton addTarget:self action:@selector(readAgreeAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [readButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_agreenImv.mas_centerY);
        make.left.mas_equalTo(_agreenImv.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(10));
    }];
    
    UIButton * b2 = [UIButton buttonWithType:UIButtonTypeCustom];
    b2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:b2];
    
    [b2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.agreenImv.mas_left).offset(-5);
        make.right.mas_equalTo(self.agreenImv.mas_right).offset(5);
        make.top.mas_equalTo(self.agreenImv.mas_top).offset(-5);
        make.bottom.mas_equalTo(self.agreenImv.mas_bottom).offset(5);
    }];
    
    [b2 addTarget:self action:@selector(tapAction2) forControlEvents:UIControlEventTouchUpInside];

    self.loginBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [self.loginBT setTitle:@"登录" forState:(UIControlStateNormal)];
    [self.loginBT setTintColor:[UIColor whiteColor]];
//    [self.loginBT setImage:[UIImage imageNamed:@"圆角矩形-2-拷贝"] forState:UIControlStateNormal];
    self.loginBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    self.loginBT.layer.cornerRadius = 3;
    [self.view addSubview:self.loginBT];
    
    [self.loginBT addTarget:self action:@selector(loginAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.loginBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(readButton.mas_bottom).offset(SIZE_SCALE_IPHONE6(20));
        make.centerX.mas_equalTo(self.loginBackImv);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(100),SIZE_SCALE_IPHONE6(30)));
    }];

}
//返回
-(void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}


//忘记密码
-(void)forgetAction {
    
    ForgetPassWordViewController * forgetVC = [[ForgetPassWordViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
    
}

//阅读协议
-(void)readAgreeAction {
    ReadAgreeViewController * readVC = [[ReadAgreeViewController alloc] init];
    [self.navigationController pushViewController:readVC animated:YES];
    
}

//记住密码选择
-(void)tapAction {
    
    if (self.select1 == 0) {
        self.selectImv.image = [UIImage imageNamed:@"形状-8-拷贝"];
        self.select1 = 1;
        
    }else {
        self.selectImv.image = [UIImage imageNamed:@"圆角矩形-3"];
        self.select1 = 0;
    }
}

//同意条款选择
-(void)tapAction2 {
    
    if (self.select2 == 0) {
        self.agreenImv.image = [UIImage imageNamed:@"圆角矩形-3"];
        self.select2 = 1;
    }else {
        self.agreenImv.image = [UIImage imageNamed:@"形状-8-拷贝"];
        self.select2 = 0;
    }
}

//登陆
-(void)loginAction {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:self.userName.text forKey:@"phone"];
    [dictory setValue:self.passWord.text forKey:@"password"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/authenticate" success:^(NSMutableDictionary * dict1) {
        
        XPCertificate * model = [XPCertificate new];
        [model setValuesForKeysWithDictionary:dict1];
        
        if ([model.code isEqualToString:@"0"]) {
            
            NSMutableDictionary * dictory = [[NSMutableDictionary alloc] init];
            [dictory setValue:self.userName.text forKey:@"phone"];
            
            [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/getuserinfo" success:^(NSMutableDictionary * dict) {
//                             NSLog(@"%@", dict);
                self.citizenModel = [XPCitizen new];
                [self.citizenModel setValuesForKeysWithDictionary:dict[@"data"]];
                
                if (self.citizenModel.UConstellation.length == 0) {
                    PersonSettingViewController * personVC = [[PersonSettingViewController alloc] init];
                    personVC.phone = self.userName.text;
                    
                    personVC.UID = self.citizenModel.UID;
                    
//                    NSLog(@"%@", self.citizenModel.CustID);
                    //将数据写入NSUserDefaults
                    NSUserDefaults * personDefaults = [NSUserDefaults standardUserDefaults];
                    [personDefaults setValue:self.citizenModel.UID forKey:@"UID"];
                    [personDefaults setValue:self.userName.text forKey:@"phone"];
                    [personDefaults setObject:self.citizenModel.RoomNo forKey:@"RoomNo"];
                    [personDefaults setObject:self.citizenModel.CustID forKey:@"CustID"];
                    [personDefaults setValue:self.citizenModel.apartmentName forKey:@"apartmentName"];
                    [personDefaults synchronize];
                    
                    [self.navigationController pushViewController:personVC animated:YES];
                }else{
                    //将数据写入NSUserDefaults
                    NSUserDefaults * personDefaults = [NSUserDefaults standardUserDefaults];
                    [personDefaults setValue:self.citizenModel.UState forKey:@"state"];
                    [personDefaults setObject:self.userName.text forKey:@"phone"];
                    [personDefaults setObject:self.citizenModel.UID forKey:@"UID"];
                    [personDefaults setObject:self.citizenModel.CustID forKey:@"CustID"];
                    [personDefaults setObject:self.citizenModel.RoomNo forKey:@"RoomNo"];
//                    NSLog(@"%@", self.citizenModel.RoomNo);

                    [personDefaults setObject:self.citizenModel.RoomID forKey:@"RoomID"];
                    [personDefaults setObject:self.citizenModel.ApartmentID forKey:@"ApartmentID"];
                    [personDefaults setValue:self.citizenModel.apartmentName forKey:@"apartmentName"];
                    [personDefaults setObject:self.citizenModel.UHeadPortrait forKey:@"UHeadPortrait"];
                    [personDefaults setObject:self.citizenModel.UNickName forKey:@"UNickName"];
                    [personDefaults setObject:self.citizenModel.UPassWord forKey:@"UPassWord"]; //用户是否设置了支付密码
                    
                    if (self.select1 == 1) {
                        [personDefaults setObject:self.citizenModel.ULoginID forKey:@"loginID"];
                    }
                    
                    //把数据写入硬盘
                    [personDefaults synchronize];
                    
                    
                    NeighbourViewController * neighbourVC = [[NeighbourViewController alloc] init];
                    neighbourVC.citizenModel = self.citizenModel;
                    
                    RootTabBarController * rootVC = [[RootTabBarController alloc] init];
                    rootVC.citizenModel = self.citizenModel;
                    
                    [self.navigationController pushViewController:rootVC animated:YES];
                }
            } failed:^{
                [self showAlertWithString:model.message];
            }];
            
        }else {
            
            NSString * errorsString = model.message;
            [self showAlertWithString:errorsString];
        }
        
    } failed:^{
        
        [self showAlertWithString:@"登录错误"];
    }];

}



//texField delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect frame = self.view.frame;
    frame.origin.y = -180;
    self.view.frame = frame;
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
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
