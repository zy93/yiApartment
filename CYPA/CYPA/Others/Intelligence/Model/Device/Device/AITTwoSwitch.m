//
//  AITTwoSwitch.m
//  CYPA
//
//  Created by 张雨 on 2017/5/16.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import "AITTwoSwitch.h"

@implementation AITTwoSwitch

-(BOOL)getDeviceStatus
{
    return YES;
}

-(void)setControlWithValue:(BOOL)value lightId:(NSInteger)lightId response:(AITTwoSwitchResponse)block
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"switch",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"value":value?@"ON":@"OFF",
                                     @"id":@(lightId)
                                     }
                          };
    self.controlResponse = block;
    [self sendWebsocketWithDictionary:dic];
}

@end
