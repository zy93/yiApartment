//
//  OrderModel.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self = [super init])
    {
        _TotalFee = [[dic objectForKey:@"TotalFee"] doubleValue];
        _OrderID = [[dic objectForKey:@"OrderID"] intValue];
//        _OrderTime = [[dic objectForKey:@"OrderTime"] intValue];
        _RealPrice = [[dic objectForKey:@"RealPrice"] doubleValue];
        _Number = [[dic objectForKey:@"Number"] intValue];

    }
    return self;
}


@end
