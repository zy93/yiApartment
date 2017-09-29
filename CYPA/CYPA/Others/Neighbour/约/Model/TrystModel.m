//
//  TrystModel.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/9.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "TrystModel.h"

@implementation TrystModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self = [super init])
    {
        _PersonNum = [[dic objectForKey:@"PersonNum"] intValue];
        _State = [[dic objectForKey:@"State"] intValue];
        _PersonCount = [[dic objectForKey:@"PersonCount"] intValue];
//        _GroupID = [[dic objectForKey:@"GroupID"] intValue];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}



@end
