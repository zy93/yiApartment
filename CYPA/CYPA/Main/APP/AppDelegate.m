//
//  AppDelegate.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/18.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiManager.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
@interface AppDelegate ()<UITabBarControllerDelegate>
@property(nonatomic, strong)BMKMapManager* mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:1.0];//设置启动页面时间
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //百度地图集成
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"vGMCVPPk2aMbENTMjqIvE0ih"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //微信支付
    [WXApi registerApp:APPID];
    
    // 极光推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound |UIUserNotificationTypeAlert)categories:nil];
    } else {
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeNone  | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:@"505806e0b02f6f83cded3799" channel:nil apsForProduction:NO];
    
    
    NSString * string = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginID"];
    if (string.length == 0) {
        ChooseLoginViewController * chooseVC = [[ChooseLoginViewController alloc] init];
        //创建导航控制器
        UINavigationController * rootNC = [[UINavigationController alloc]initWithRootViewController:chooseVC];
        
        self.window.rootViewController = rootNC;
        
    }else{
        RootTabBarController * rootVC = [[RootTabBarController alloc] init];
        
        //创建导航控制器
        UINavigationController * rootNC = [[UINavigationController alloc]initWithRootViewController:rootVC];
        
        rootNC.navigationBarHidden = YES;
        self.window.rootViewController = rootNC;
    }
   
    
//    /*********
//     //添加闪屏页的方法
//     ********/
//    
//    self.window.rootViewController.view.alpha = 0;
//    UIImageView *splashImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"闪屏页"]];
//    [self.window addSubview:splashImageView];
//    splashImageView.frame = [UIScreen mainScreen].bounds;
//    [UIView animateWithDuration:2 animations:^{
//        self.window.rootViewController.view.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        [splashImageView removeFromSuperview];
//        
//    }];

    
    return YES;
}


//required
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required -    DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:
(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:
(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult
                                                          ult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    if (completionHandler) {
        completionHandler(UIBackgroundFetchResultNewData);
    }
    
    // 应用正处理前台状态下，不会收到推送消息，因此在此处需要额外处理一下
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到推送消息" message:userInfo[@"aps"][@"alert"] delegate:nil cancelButtonTitle:@"取消"otherButtonTitles:@"确定",nil];
        [alert show];  
    }
    
    return;
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
    return;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [application setApplicationIconBadgeNumber:0];
    return;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error
          );
}

//在applicationWillEnterForeground方法（App即将进入前台）中将小红点清除
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"进入前台");
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

//支付宝支付
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }else{
        
        
        [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
        
    }
    return YES;
    
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }else{
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
 
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}




- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "DG.CYPA" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CYPA" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CYPA.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - 微信支付回调方法
- (void)onResp:(BaseResp*)resp
{
    
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    
    if([resp isKindOfClass:[PayResp class]])
    {
        // 支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
            {
                strMsg = @"支付结果：成功！";
//                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
//                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"success"];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
//                NSNotification *rechargeNoti = [NSNotification notificationWithName:RECHARGE_PAY_NOTIFICATION object:@"recharge_success"];
//                [[NSNotificationCenter defaultCenter] postNotification:rechargeNoti];
//                
                
                break;
            }
                
            default:
            {
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
//                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr]];
//                
//                NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:@"fail"];
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
//                NSNotification *rechargeNoti = [NSNotification notificationWithName:RECHARGE_PAY_NOTIFICATION object:@"fail"];
//                [[NSNotificationCenter defaultCenter] postNotification:rechargeNoti];
                
                break;
            }
        }
    }
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    //    [alert show];
}




@end
