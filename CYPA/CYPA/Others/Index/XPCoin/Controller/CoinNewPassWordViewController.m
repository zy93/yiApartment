//
//  CoinNewPassWordViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "CoinNewPassWordViewController.h"
#import "InputView.h"
#import "Header.h"

@interface CoinNewPassWordViewController ()

@property (nonatomic, strong) InputView *fistInputView;
@property (nonatomic, strong) InputView *lastInputView;

@property (nonatomic, copy) NSString *fistInput;
@property (nonatomic, copy) NSString *lastInput;



@end

@implementation CoinNewPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.fistInputView];
    [self.view addSubview:self.lastInputView];
    
    [self.fistInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.lastInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.lastInputView.hidden = YES;
    [self.fistInputView becomeFirstResponder];
    
    
    [self.view addSubview:self.backBT];
    [self.backBT addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
- (void)check
{
    __weak typeof(self)weakself = self;
    if ([self.fistInput isEqualToString:self.lastInput]) {
        
        //此处上传密码
        NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
        [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] forKey:@"phone"];
        [dictory setValue:self.oldPassWord forKey:@"oldpwd"];
        [dictory setValue:self.lastInput forKey:@"newpwd"];
        [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/mpaypwd" success:^(NSMutableDictionary * dict) {
            if ([dict[@"code"] isEqualToString:@"0"]) {
                
//                [self showAlertWithString:dict[@"message"]];
                
                NSArray *ctrlArray = self.navigationController.viewControllers;
                
                [self.navigationController popToViewController:[ctrlArray objectAtIndex:ctrlArray.count - 3] animated:YES];
                
            }else{
                [self showAlertWithString:@"修改支付密码失败"];
            }
        } failed:^{
            NSLog(@"未知错误");
        }];
        
    } else {
        
        UIAlertAction *actionRetry = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself switchToFirstInputMode];
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
}






#pragma mark -
- (void)switchToFirstInputMode
{
    //clean
    [self.fistInputView clear];
    [self.lastInputView clear];
    
    
    self.lastInputView.hidden = YES;
    self.fistInputView.hidden = NO;
    [self.fistInputView becomeFirstResponder];
}

- (void)switchToLastInputMode
{
    self.fistInputView.hidden = YES;
    self.lastInputView.hidden = NO;
    [self.lastInputView becomeFirstResponder];
}

#pragma mark -
- (InputView *)fistInputView
{
    if (!_fistInputView) {
        _fistInputView = [[InputView alloc] init];
        _fistInputView.tip = @"请输入密码";
        __weak typeof(self) weakself = self;
        _fistInputView.textChangeBlock = ^(NSString *text){
            weakself.fistInput = text;
        };
    }
    return _fistInputView;
    
}

- (InputView *)lastInputView
{
    if (!_lastInputView) {
        _lastInputView = [[InputView alloc] init];
        _lastInputView.tip = @"请再次输入密码";
        
        __weak typeof(self) weakself = self;
        _lastInputView.textChangeBlock = ^(NSString *text){
            weakself.lastInput = text;
        };
    }
    return _lastInputView;
}

- (void)setFistInput:(NSString *)fistInput
{
    _fistInput = fistInput;
    if (fistInput.length == 6) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self switchToLastInputMode];
        });
    }
    
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
