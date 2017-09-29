//
//  BaseDevice.m
//  CYPA
//
//  Created by 张雨 on 2017/5/4.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import "BaseDevice.h"
#import "WebsocketChannel.h"

@implementation BaseDevice

-(void)setDeviceState:(BOOL)isOn
{
    
}

-(BOOL)getDeviceStatus
{
    return NO;
}

-(void)sendWebsocketWithDictionary:(NSDictionary *)dic
{
    NSString *string = [self dictionaryToJson:dic];
    [[WebsocketChannel shareWebsocketChannel] sendString:string];
}


-(void)receiveDataWithDictionary:(NSDictionary *)dic
{
    NSLog(@"receive dictionary:%@",dic);
}

-(NSTimeInterval)GetCurrentTimestamp
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timestamp=[date timeIntervalSince1970];
    return timestamp;
}

/**字典转json*/
-(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
