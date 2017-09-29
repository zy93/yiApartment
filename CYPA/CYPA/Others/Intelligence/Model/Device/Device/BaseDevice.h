//
//  BaseDevice.h
//  CYPA
//
//  Created by 张雨 on 2017/5/4.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface BaseDevice : Jastor

@property(nonatomic,strong) NSString *thingId;
@property(nonatomic,strong) NSString *templateId;
@property(nonatomic,strong) NSString *thingName;
@property(nonatomic,strong) NSString *harborIp;
@property(nonatomic,strong) NSString *picUrl;
@property(nonatomic,strong) NSNumber *state;
@property(nonatomic,strong) NSNumber *permission;

-(NSTimeInterval)GetCurrentTimestamp;


/**
 开关控制

 @param isOn 开or关
 */
-(void)setDeviceState:(BOOL)isOn;
-(BOOL)getDeviceStatus;

-(void)sendWebsocketWithDictionary:(NSDictionary *)dic;
-(void)receiveDataWithDictionary:(NSDictionary *)dic;

@end
