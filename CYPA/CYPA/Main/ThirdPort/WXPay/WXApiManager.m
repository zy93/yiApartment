//
//  WXApiManager.m
//  WXPayForIOS
//
//  Created by ssiwo02 on 15/12/29.
//  Copyright © 2015年 疯狂的地垄沟. All rights reserved.
//


#import "WXApiManager.h"
#import "GXNetWorkManager.h"

@implementation WXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

- (void)dealloc {
    self.delegate = nil;
    
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    
    NSMutableDictionary * dic0 = [NSMutableDictionary dictionary];
    [dic0 setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"OUT_TRADE_NO"] forKey:@"OUT_TRADE_NO"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dic0 path:@"/rmb/checkPayed" success:^(NSMutableDictionary *respon) {
        
        NSLog(@"支付结果%@", respon);
        
        
        
    } failed:^{
        [MBProgressHUD showSuccess:@"支付失败"];
    }];
    
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvMessageResponse:)]) {
            SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
            [_delegate managerDidRecvMessageResponse:messageResp];
        }
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)]) {
            SendAuthResp *authResp = (SendAuthResp *)resp;
            [_delegate managerDidRecvAuthResponse:authResp];
        }
    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAddCardResponse:)]) {
            AddCardToWXCardPackageResp *addCardResp = (AddCardToWXCardPackageResp *)resp;
            [_delegate managerDidRecvAddCardResponse:addCardResp];
        }
    }else if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg = nil,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                //                WXSuccess           = 0,    /**< 成功    */
                //                WXErrCodeCommon     = -1,   /**< 普通错误类型    */
                //                WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
                //                WXErrCodeSentFail   = -3,   /**< 发送失败    */
                //                WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
                //                WXErrCodeUnsupport  = -5,
            case WXErrCodeCommon:
                NSLog(@"支付:retcode = %d, restr = %@",resp.errCode, resp.errStr);
                break;
            case WXErrCodeSentFail:
                NSLog(@"支付:retcode = %d, restr = %@",resp.errCode, resp.errStr);
                break;
            case WXErrCodeAuthDeny:
                NSLog(@"支付:retcode = %d, restr = %@",resp.errCode, resp.errStr);
                break;
            case WXErrCodeUnsupport:
                NSLog(@"支付:retcode = %d, restr = %@",resp.errCode, resp.errStr);
                break;
            default:
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                strMsg = [NSString stringWithFormat:@"支付结果：失败！"];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}

- (void)onReq:(BaseReq *)req {
    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvGetMessageReq:)]) {
            GetMessageFromWXReq *getMessageReq = (GetMessageFromWXReq *)req;
            [_delegate managerDidRecvGetMessageReq:getMessageReq];
        }
    } else if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageReq:)]) {
            ShowMessageFromWXReq *showMessageReq = (ShowMessageFromWXReq *)req;
            [_delegate managerDidRecvShowMessageReq:showMessageReq];
        }
    } else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvLaunchFromWXReq:)]) {
            LaunchFromWXReq *launchReq = (LaunchFromWXReq *)req;
            [_delegate managerDidRecvLaunchFromWXReq:launchReq];
        }
    }
}

@end
