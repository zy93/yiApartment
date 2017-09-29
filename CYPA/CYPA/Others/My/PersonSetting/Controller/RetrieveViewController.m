//
//  RetrieveViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "RetrieveViewController.h"
#import "Header.h"
@interface RetrieveViewController ()

@property(nonatomic, strong)UITextField * oldTF;
@property(nonatomic, strong)UITextField * firstTF;
@property(nonatomic, strong)UITextField * secondTF;
@property(nonatomic, strong)UIButton * sureBT;

@end

@implementation RetrieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
    
}

-(void)setupViews {
    
    UILabel * label0 = [[UILabel alloc] init];
    label0.text = @"输入新密码：";
    label0.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label0];
    
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //原密码
    self.oldTF = [[UITextField alloc] init];
    self.oldTF.font = [UIFont systemFontOfSize:15];
    self.oldTF.textAlignment = NSTextAlignmentCenter;
    //    self.firstTF.keyboardType = UIKeyboardTypeNumberPad;
    self.oldTF.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.oldTF.textColor = [UIColor colorWithHexString:@"666666"];
    [self.view addSubview:self.oldTF];
    
    [self.oldTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label0.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(67.5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(35));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-60));
    }];
    
    
    UILabel * label1 = [[UILabel alloc] init];
    label1.text = @"输入旧密码：";
    label1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oldTF.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //第一次密码
    self.firstTF = [[UITextField alloc] init];
    self.firstTF.font = [UIFont systemFontOfSize:15];
    self.firstTF.textAlignment = NSTextAlignmentCenter;
    //    self.firstTF.keyboardType = UIKeyboardTypeNumberPad;
    self.firstTF.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.firstTF.textColor = [UIColor colorWithHexString:@"666666"];
    [self.view addSubview:self.firstTF];
    
    [self.firstTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(67.5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(35));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-60));
    }];
    
    
    UILabel * label2 = [[UILabel alloc] init];
    label2.text = @"再次输入密码：";
    label2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.firstTF.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //再次密码
    self.secondTF = [[UITextField alloc] init];
    self.secondTF.font = [UIFont systemFontOfSize:15];
    self.secondTF.textAlignment = NSTextAlignmentCenter;
    //    self.firstTF.keyboardType = UIKeyboardTypeNumberPad;
    self.secondTF.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.secondTF.textColor = [UIColor colorWithHexString:@"666666"];
    [self.view addSubview:self.secondTF];
    
    [self.secondTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label2.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(67.5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(35));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-60));
    }];
    
    //确定
    self.sureBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.sureBT setTitle:@"确定" forState:(UIControlStateNormal)];
    self.sureBT.tintColor = [UIColor whiteColor];
    self.sureBT.layer.cornerRadius = 3;
    self.sureBT.layer.masksToBounds = YES;
    self.sureBT.titleLabel.font = [UIFont systemFontOfSize:15];
    self.sureBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.view addSubview:self.sureBT];
    
    //验证两次密码及上传密码
    [self.sureBT addTarget:self action:@selector(sureAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.sureBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.secondTF.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
    
    
    
}

//验证两次密码是否相同并修改密码
-(void)sureAction{
    if ([self.firstTF.text isEqualToString:self.secondTF.text]) {
        NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
        [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] forKey:@"phone"];
        [dictory setValue:self.oldTF.text forKey:@"oldpwd"];
        [dictory setValue:self.firstTF.text forKey:@"newpwd"];
        
        [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/mpwd" success:^(NSMutableDictionary * dict) {
            if ([dict[@"code"] isEqualToString:@"0"]) {
                
                ChooseLoginViewController * chooseVC = [[ChooseLoginViewController alloc] init];
                
                [self.navigationController pushViewController:chooseVC animated:YES];
                
            }else{
                [self showAlertWithString:@"修改密码失败"];
            }
        } failed:^{
            NSLog(@"未知错误");
        }];
        
    } else {
        [self showAlertWithString:@"两次密码不一致"];
    }
    
    
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
