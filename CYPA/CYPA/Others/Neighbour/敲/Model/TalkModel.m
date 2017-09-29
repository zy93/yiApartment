//
//  TalkModel.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/9.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "TalkModel.h"

@implementation TalkModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if(self = [super init])
    {
        _msgFrom = [[dic objectForKey:@"msgForm"] intValue];
        _msgTo = [[dic objectForKey:@"msgTo"] intValue];
        _State = [[dic objectForKey:@"State"] intValue];
    }
    return self;
}


@end
