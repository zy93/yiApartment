//
//  CoinOldPassWordViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "CoinOldPassWordViewController.h"
#import "InputView.h"
#import "Header.h"

@interface CoinOldPassWordViewController ()

@property (nonatomic, strong) InputView *lastInputView;
@property (nonatomic, copy) NSString *lastInput;

@end

@implementation CoinOldPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.lastInputView];
    
    
    [self.lastInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.lastInputView becomeFirstResponder];
    
    //返回
    self.backBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBT setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:normal];
    [self.view addSubview:self.backBT];
    
    [self.backBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleImv);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(43.5), SIZE_SCALE_IPHONE6(43.5)));
        
    }];
    
    [self.backBT addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
- (void)check
{
    __weak typeof(self)weakself = self;
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dictory setValue:self.lastInput forKey:@"Pwd"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/checkPayPwd" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            [weakself.view endEditing:YES];
            
            CoinNewPassWordViewController * newVC = [[CoinNewPassWordViewController alloc] init];
            newVC.oldPassWord = self.lastInput;
            [weakself.navigationController pushViewController:newVC animated:YES];
            
            
        }else{
            
            UIAlertAction *actionRetry = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakself switchToLastInputMode];
            }];
            
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakself.view endEditing:YES];
                [weakself.navigationController popViewControllerAnimated:YES];
            }];
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证失败" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:actionCancel];
            [alertVC addAction:actionRetry];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    } failed:^{
        NSLog(@"未知错误");
    }];

    
}

- (void)switchToLastInputMode
{
    [self.lastInputView clear];
    self.lastInputView.hidden = NO;
    [self.lastInputView becomeFirstResponder];
}

- (InputView *)lastInputView
{
    if (!_lastInputView) {
        _lastInputView = [[InputView alloc] init];
        _lastInputView.tip = @"请输入密码";
        
        __weak typeof(self) weakself = self;
        _lastInputView.textChangeBlock = ^(NSString *text){
            weakself.lastInput = text;
        };
    }
    return _lastInputView;
}

- (void)setLastInput:(NSString *)lastInput
{
    _lastInput = lastInput;
    if (lastInput.length == 6) {
        [self check];
        
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
