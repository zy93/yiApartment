//
//  DeviceManager.m
//  ruienDemo
//
//  Created by 张雨 on 2017/4/26.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "DeviceManager.h"
#import "DrinkingWater.h"
#import "Airconditioner.h"
#import "AITTwoSwitch.h"
#import "AITCurtain.h"


//userId : 40  13812345678
//userId : 87  18888888888
#define UserID @"87"

@interface DeviceManager()



@end


@implementation DeviceManager

+(DeviceManager *)shareDeviceManager
{
    static DeviceManager *mDeviceManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mDeviceManager = [[DeviceManager alloc] init];
    });
    return mDeviceManager;
}

-(void)addDevice:(BaseDevice *)device
{
    ///
}

-(NSDictionary *)getAllDevice
{
    NSDictionary *allDev = [_mAllDevice copy];
    return allDev;
}

-(BaseDevice *)getDeviceByThingId:(NSString *)thingId
{
    
    for (NSArray *groupList in _mAllDevice) {
        for (BaseDevice *device in groupList) {
            if ([device.thingId isEqualToString:thingId]) {
                return device;
            }
        }
    }
    
    
    NSAssert(NO, @"必须包含设备");
    return nil;
}

#pragma mark - websocket(device harbour)

-(void)receiveWebsocketWithString:(NSString *)json
{
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    [self receiveWebsocketWithData:data];
}

-(void)receiveWebsocketWithData:(NSData *)data
{
    NSError *error;
    
    NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([receiveStr containsString:@"{"]) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers |NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:&error];
        NSAssert(dic, @"必须有值");
        //读取设备
        NSLog(@"+++rece :%@", dic);
        BaseDevice *device = [self getDeviceByThingId:dic[@"thingID"]];
        [device receiveDataWithDictionary:dic];
    }
    else {
        NSLog(@"--------------%@", receiveStr);
//        NSAssert(!receiveStr, @"必须有值");

    }
    
}


#pragma mark - http(user backstage)
-(void)sendRequestToGetAllGroupResponse:(ResponseArrayBlock)block
{
    __weak  DeviceManager *weakSelf = self;
    
    [[GXNetWorkManager shareInstance] GETWOTRequestWithParam:@{@"userId":UserID} path:@"Service_Platform/group/all.do" success:^(NSMutableDictionary *responseDic) {
        NSMutableArray *mutArr = [NSMutableArray new];
        NSArray *arr = responseDic[@"data"];
        for (NSDictionary *dic in arr) {
            DeviceGroup *group = [[DeviceGroup alloc] initWithDictionary:dic];
            [mutArr addObject:group];
            [weakSelf sendRequestToGetAllDeviceWithGroupId:group.groupId Response:^(NSArray *dic) {
                block(_mAllDevice);
            }];
        }
        _mAllGroup = [mutArr copy];
    } failed:^{
        
    }];
    
}

-(void)sendRequestToGetAllDeviceWithGroupId:(NSNumber *)groupId Response:(ResponseArrayBlock)block
{
    
    [[GXNetWorkManager shareInstance] GETWOTRequestWithParam:@{@"userId":UserID, @"groupId":groupId} path:@"Service_Platform/group/deviceList.do" success:^(NSMutableDictionary *responseDic) {
        NSMutableArray *devList = [NSMutableArray new];
        NSArray *arr = responseDic[@"data"];
        for (NSDictionary *dic in arr) {
            BaseDevice *device = nil;
            if ([dic[@"templateId"] containsString:@"净水机"]) {
                device = [[DrinkingWater alloc] initWithDictionary:dic];
            }
            else if ([dic[@"templateId"] containsString:@"空调"]) {
                device = [[Airconditioner alloc] initWithDictionary:dic];
            }
            else if ([dic[@"templateId"] containsString:@"开关"]) {
                if ([dic[@"templateId"] containsString:@"艾特智能"]) {
                    device = [[AITTwoSwitch alloc] initWithDictionary:dic];
                    if ([dic[@"templateId"] containsString:@"三"]) {
                        ((AITTwoSwitch *)device).mSwitchType = AITSWITCH_TYPE_Three;
                    }else if ([dic[@"templateId"] containsString:@"两"]) {
                        ((AITTwoSwitch *)device).mSwitchType = AITSWITCH_TYPE_Two;
                    }else {
                        ((AITTwoSwitch *)device).mSwitchType = AITSWITCH_TYPE_One;
                    }
                }
                else {
                    continue;
                }
                
            }
            else if ([dic[@"templateId"] containsString:@"窗帘"]) {
                device = [[AITCurtain alloc] initWithDictionary:dic];
            }
            else{
                continue;
            }
            
            [devList addObject:device];

        }
        if (!_mAllDevice) {
            _mAllDevice = [NSMutableArray new];
        }
//        [_mAllDevice setValue:devList forKey:[NSString stringWithFormat:@"%@",groupId]];
        [_mAllDevice addObject:devList];
        block(_mAllDevice);
        NSLog(@"--%@", arr);
    } failed:^{
        
    }];
    
}

@end
