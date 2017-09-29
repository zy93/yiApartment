//
//  TestPassWordViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "TestPassWordViewController.h"
#import "InputView.h"
#import "Header.h"

@interface TestPassWordViewController ()

@property (nonatomic, strong) InputView *lastInputView;
@property (nonatomic, copy) NSString *lastInput;
@property(nonatomic, strong)NSMutableString * productString;



@end

@implementation TestPassWordViewController

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
                self.productString = [NSMutableString string];
            NSLog(@"%@", self.addArray);
                for (ProductModel * model in self.showArray) {
            
                    NSInteger count = 0;
                    for (ProductModel * model1 in self.addArray) {
                        if (model.ProductID == model1.ProductID) {
                            count++;
                        }
                    }
                    
                    self.productString = [self.productString stringByAppendingString:[NSString stringWithFormat:@",%d-%ld-%.1f-%.1f", model.ProductID, count, model.RealPrice, model.Price]];
                    
                }
            
                NSString * aString = [self.productString substringWithRange:NSMakeRange(1, self.productString.length - 1)];
                NSLog(@"####%@", aString);
            
                NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
                [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
                if (self.FID == NULL) {
                    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"FID"];
                }else{
                    [dictory setValue:[NSString stringWithFormat:@"%@", self.FID] forKey:@"FID"];
            //        self.backBT.hidden = NO;
                }
                [dictory setValue:aString forKey:@"Product"];
                [dictory setValue:[NSString stringWithFormat:@"%.1f",self.sumMoney] forKey:@"TotalFee"];
                [dictory setValue:@"03_003_6" forKey:@"PayMode"];
    
                [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/order/order" success:^(NSMutableDictionary * dict) {
                    
                    if ([dict[@"code"] isEqualToString:@"0"]) {
                        
                        NSLog(@"-----%@", dict);
            
                        if (self.FID == NULL) {
                            
                            [self showAlertAndBackWithString:@"提交订单成功"];
                            NSArray *ctrlArray = self.navigationController.viewControllers;
                            
                            [weakself.navigationController popToViewController:[ctrlArray objectAtIndex:ctrlArray.count - 4] animated:YES];

                        }else{
                            [self showAlertAndBackWithString:@"送礼成功"];
                            NSArray *ctrlArray = self.navigationController.viewControllers;
                            
                            [weakself.navigationController popToViewController:[ctrlArray objectAtIndex:ctrlArray.count - 4] animated:YES];
                            
                        }
                        
                    }else{
                        [self showAlertWithString:@"提交订单失败"];
                        
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
                    
                    [self showAlert:@"提交订单失败"];
                }];
            
        }else{
            [self showAlert:@"密码验证失败"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
