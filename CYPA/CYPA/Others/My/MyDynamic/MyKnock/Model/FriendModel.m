//
//  FriendModel.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/18.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self = [super init])
    {
        _Ftype = [[dic objectForKey:@"Ftype"] intValue];
        _State = [[dic objectForKey:@"State"] intValue];
        _UID = [[dic objectForKey:@"UID"] intValue];
    }
    return self;
}

@end
