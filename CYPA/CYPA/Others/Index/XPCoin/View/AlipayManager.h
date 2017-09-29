//
//  AlipayManager.h
//  CYPA
//
//  Created by HDD on 16/8/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlipayManager : NSObject

+(void)sendAlipayWithServerWithMoney:(NSString *)money;

@end
