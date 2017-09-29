//
//  AITCurtain.m
//  CYPA
//
//  Created by 张雨 on 2017/5/16.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import "AITCurtain.h"

@implementation AITCurtain

-(void)setControlWithValue:(AITCURTAIN_TYPE)value response:(AITCurtainResponse)block
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"curtain_switch",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"value":value==AITCURTAIN_TYPE_On?@"1":
                                         value==AITCURTAIN_TYPE_Off?@"0":@"STOP"
                                     
                                     }
                          };
    self.controlResponse = block;
    [self sendWebsocketWithDictionary:dic];
}

@end
