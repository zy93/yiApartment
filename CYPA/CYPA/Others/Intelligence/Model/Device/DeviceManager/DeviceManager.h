//
//  DeviceManager.h
//  ruienDemo
//
//  Created by 张雨 on 2017/4/26.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDevice.h"
#import "GXNetWorkManager.h"
#import "DeviceGroup.h"


//typedef void (^DeviceGroupBlock)(NSArray *arr);
typedef void (^ResponseDictionaryBlock)(NSDictionary *dic);
typedef void (^ResponseArrayBlock)(NSArray *dic);


@interface DeviceManager : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *mAllDevice;//所有设备以组dic为单位放在这里，key为groupId，
@property (nonatomic, strong, readonly) NSArray *mAllGroup;//记录分组


+(DeviceManager *)shareDeviceManager;

-(void)addDevice:(BaseDevice *)device;
-(NSDictionary *)getAllDevice;
-(BaseDevice *)getDeviceByThingId:(NSString *)thingId;

#pragma mark - websocket(device harbour)
-(void)receiveWebsocketWithString:(NSString *)json;
-(void)receiveWebsocketWithData:(NSData *)data;


#pragma mark - http(user backstage)

/**
 获取用户所有分组

 @param groupBlock <#groupBlock description#>
 */
-(void)sendRequestToGetAllGroupResponse:(ResponseArrayBlock)block;

/**
 根据分组id获取分组内所有设备, >>>>不直接调用<<<<

 @param groupId <#groupId description#>
 @param deviceBlock <#deviceBlock description#>
 */
-(void)sendRequestToGetAllDeviceWithGroupId:(NSNumber*)groupId Response:(ResponseArrayBlock)block;


@end
