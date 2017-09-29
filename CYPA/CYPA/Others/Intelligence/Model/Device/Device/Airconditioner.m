//
//  Airconditioner.m
//  ruienDemo
//
//  Created by 张雨 on 2017/4/26.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "Airconditioner.h"

@implementation Airconditioner

-(BOOL)getDeviceStatus
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"get_ac_status",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"line":@(1)}
                          };
    [self sendWebsocketWithDictionary:dic];
    return YES;
}

-(void)setAirconditionerSwitch:(BOOL)swit
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"ac_switch",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"line":@(1),
                                     @"switch":@(swit==YES?1:0)
                                     }
                          };
    [self sendWebsocketWithDictionary:dic];
}

-(void)setAirconditionerModel:(AIRCONDITIONER_MODEL)model
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"ac_mode",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"line":@(1),
                                     @"mode":@(model)
                                     }
                          };
    [self sendWebsocketWithDictionary:dic];
}

-(void)setAirconditionerWind:(AIRCONDITIONER_WIND)wind
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"ac_wind",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"line":@(1),
                                     @"wind":@(wind)
                                     }
                          };
    [self sendWebsocketWithDictionary:dic];
}

-(void)setAirconditionerTemp:(NSInteger)temp
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"ac_temp",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"line":@(1),
                                     @"wind":@(temp)
                                     }
                          };
    [self sendWebsocketWithDictionary:dic];
}

-(void)receiveDataWithDictionary:(NSDictionary *)dic
{
    
}

@end
