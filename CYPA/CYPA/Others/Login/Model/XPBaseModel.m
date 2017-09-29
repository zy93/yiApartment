//
//  XPBaseModel.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/27.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "XPBaseModel.h"

@implementation XPBaseModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self = [super init])
    {
        _number = [[dic objectForKey:@"number"] intValue];
    }
    return self;
}

@end
