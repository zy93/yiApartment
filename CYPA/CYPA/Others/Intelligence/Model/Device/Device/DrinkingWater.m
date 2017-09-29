//
//  DrinkingWater.m
//  CYPA
//
//  Created by 张雨 on 2017/5/4.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import "DrinkingWater.h"

@implementation DrinkingWater

-(void)rechargeWithMoney:(CGFloat)money withResponse:(DrinkingResponse)block
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"charge",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"money":[NSString stringWithFormat:@"%.2f",money],
                                     }
                          };
    self.moneyBlock = block;
    [self sendWebsocketWithDictionary:dic];
}

-(void)getBalance
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"getBalance",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{}
                          };
    [self sendWebsocketWithDictionary:dic];
}

-(void)controlWith:(BOOL)isOn withResponse:(DrinkingResponse)block
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"control",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"control":[NSString stringWithFormat:@"%d",isOn==YES?1:0]
                                     }
                          };
    self.controlBlock = block;
    [self sendWebsocketWithDictionary:dic];
}

-(void)getTDS
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"getTDS",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{}
                          };
    [self sendWebsocketWithDictionary:dic];
}

-(void)setDeviceIDWithType:(NSString *)type number:(NSString *)number withResponse:(DrinkingResponse)block
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"setDeviceID",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"type":type,
                                     @"number":number
                                     }
                          };
    self.deviceIdBlock = block;
    [self sendWebsocketWithDictionary:dic];
}


-(void)getDeviceID
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"getDeviceID",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{}
                          };
    [self sendWebsocketWithDictionary:dic];
}

-(void)setPriceWithPrice:(NSString *)price withResponse:(DrinkingResponse)block
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"setPrice",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"flux":price}
                          };
    self.priceBlock = block;
    [self sendWebsocketWithDictionary:dic];
}

-(void)getPrice
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"getPrice",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{}
                          };
    [self sendWebsocketWithDictionary:dic];
}

-(void)setFluxPulseWithPulse:(NSString *)pulse withResponse:(DrinkingResponse)block
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"setFluxPulse",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{@"pulse":pulse}
                          };
    self.pulseBlock = block;
    [self sendWebsocketWithDictionary:dic];
}

-(void)getFluxPulse
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"getFluxPulse",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{}
                          };
    [self sendWebsocketWithDictionary:dic];
}

-(void)getFluxSum
{
    NSDictionary *dic = @{@"thingId":self.thingId,
                          @"serviceId":@"getFluxSum",
                          @"seq":@([self GetCurrentTimestamp]),
                          @"param":@{}
                          };
    [self sendWebsocketWithDictionary:dic];
}


-(void)receiveDataWithDictionary:(NSDictionary *)dic
{
    NSString *serviceId = dic[@"serviceID"];
    if ([serviceId isEqualToString:@"charge"]) {
        //充值
        self.moneyBlock(dic);
    }
    else if ([serviceId isEqualToString:@"getBalance"]) {
        //查询余额
        self.balance = dic[@"data"][@"money"];
    }
    else if ([serviceId isEqualToString:@"control"]) {
        //控制
        self.controlBlock(dic);
    }
    else if ([serviceId isEqualToString:@"getTDS"]) {
        //获取TDS数值
        self.TDS =  dic[@"data"][@"number"];
    }
    else if ([serviceId isEqualToString:@"setDeviceID"]) {
        //设置设备id
        self.deviceIdBlock(dic);
    }
    else if ([serviceId isEqualToString:@"getDeviceID"]) {
        //查询设备id
        self.type = dic[@"data"][@"type"];
        self.number = dic[@"data"][@"number"];
    }
    else if ([serviceId isEqualToString:@"setPrice"]) {
        //设置售价
        self.priceBlock(dic);
    }
    else if ([serviceId isEqualToString:@"getPrice"]) {
        //查询售价
        self.price = dic[@"data"][@"flux"];
    }
    else if ([serviceId isEqualToString:@"setFluxPulse"]) {
        //设置流量计数值
        self.pulseBlock(dic);
    }
    else if ([serviceId isEqualToString:@"getFluxPulse"]) {
        //查询流量计数值
        self.fluxPulse = dic[@"data"][@"pulse"];
    }
    else if ([serviceId isEqualToString:@"getFluxSum"]) {
        //查询售水总量
        self.fluxSum = dic[@"data"][@"sum"];
    }
    else {
        NSLog(@"drinkingWater response error, receive data :%@",dic);
    }
    
}

@end
