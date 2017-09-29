//
//  ProductModel.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self = [super init])
    {
        _Price = [[dic objectForKey:@"Price"] doubleValue];
        _RealPrice = [[dic objectForKey:@"RealPrice"] doubleValue];
        _Count = [[dic objectForKey:@"Count"] intValue];
        _Number = [[dic objectForKey:@"Number"] intValue];
        _ProductID = [[dic objectForKey:@"ProductID"] intValue];
    }
    return self;
}



@end
