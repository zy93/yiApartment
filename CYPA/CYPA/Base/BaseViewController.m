//
//  BaseViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/19.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BaseViewController.h"
#import "Header.h"
@interface BaseViewController ()

@property(nonatomic,strong)UIAlertController * alert;
@property(nonatomic,strong)NetWorkView * view1;
@property(nonatomic, strong)Reachability * r;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
}
//
//提示框
-(void)showAlert:(NSString *)aString{
    
    self.alert = [UIAlertController alertControllerWithTitle:aString message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    
    [self presentViewController:self.alert animated:YES completion:nil];
    
    dispatch_after(1, dispatch_get_global_queue(0, 0), ^{
        [self.alert dismissViewControllerAnimated:NO completion:nil];
    });
    
    
}

//Reachaability检测网络状态
-(void)checkNetWork {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    
    self.r = [Reachability reachabilityForInternetConnection];
    
    [self.r startNotifier];
    
}

-(void)networkStateChange {
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        [self.view1 removeFromSuperview];
        NSLog(@"有wifi");
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        [self.view1 removeFromSuperview];
        NSLog(@"使用手机自带网络进行上网");
    } else { // 没有网络
        _view1 = [[NetWorkView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - SIZE_SCALE_IPHONE6(40))];
        _view1.backgroundColor = [UIColor whiteColor];
        
        [_view1.backBT addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.view addSubview:self.view1];

        NSLog(@"没有网络");
    }
}

//afn检测网络状态
//-(void)afn
//{
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    
//    //1.创建网络状态监测管理者
//    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
//    
//    //2.监听改变
//    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        /*
//         AFNetworkReachabilityStatusUnknown          = -1,
//         AFNetworkReachabilityStatusNotReachable     = 0,
//         AFNetworkReachabilityStatusReachableViaWWAN = 1,
//         AFNetworkReachabilityStatusReachableViaWiFi = 2,
//         */
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:{
//                [self.view1 removeFromSuperview];
//                NSLog(@"未知网络");
//                break;
//            }
//            case AFNetworkReachabilityStatusNotReachable:{
//                
//                _view1 = [[NetWorkView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - SIZE_SCALE_IPHONE6(40))];
//                _view1.backgroundColor = [UIColor whiteColor];
//                
//                [_view1.backBT addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
//                
//                [self.view addSubview:self.view1];
//                NSLog(@"没有网络");
//                break;
//            }
//            case AFNetworkReachabilityStatusReachableViaWWAN:{
//                [self.view1 removeFromSuperview];
//                NSLog(@"3G|4G");
//                break;
//            }
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//            {
//                [self.view1 removeFromSuperview];
//                
//                NSLog(@"WiFi");
//                break;
//            }
//            default:
//                break;
//        }
//    }];
//    
//    [self performSelector:@selector(checkAction) withObject:nil afterDelay:2];
//
////    [manger startMonitoring];
//    
//}
//
//-(void)checkAction{
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    
//}
//
//
//- (void)dealloc
//{
//    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
//}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.r stopNotifier];
}


-(void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertController *promptAlert = (UIAlertController*)[theTimer userInfo];
    [promptAlert dismissViewControllerAnimated:NO completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    promptAlert =NULL;
    
//    [self dismissViewControllerAnimated:NO completion:^{
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
    
}


- (void)showAlertAndBackWithString:(NSString *) _message{//时间
    UIAlertController *promptAlert = [UIAlertController alertControllerWithTitle:nil message:_message preferredStyle:(UIAlertControllerStyleAlert)];
    self.view.exclusiveTouch = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:1.5f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [self presentViewController:promptAlert animated:NO completion:nil];
}


- (void)timerFireMethodOut:(NSTimer*)theTimer//弹出框
{
    UIAlertController *promptAlert = (UIAlertController*)[theTimer userInfo];
    [promptAlert dismissViewControllerAnimated:NO completion:^{
    }];
    promptAlert =NULL;
    
    //    [self dismissViewControllerAnimated:NO completion:^{
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }];
    
}


- (void)showAlertWithString:(NSString *) _message{//时间
    UIAlertController *promptAlert = [UIAlertController alertControllerWithTitle:nil message:_message preferredStyle:(UIAlertControllerStyleAlert)];
    self.view.exclusiveTouch = YES;
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(timerFireMethodOut:) userInfo:promptAlert repeats:YES];
    [self presentViewController:promptAlert animated:NO completion:nil];
}





//点击空白回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
