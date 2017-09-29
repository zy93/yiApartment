//
//  Airconditioner.h
//  ruienDemo
//
//  Created by 张雨 on 2017/4/26.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "BaseDevice.h"


typedef NS_ENUM(NSInteger, AIRCONDITIONER_MODEL) {
    AIRCONDITIONER_MODEL_Arefaction = 0,//除湿
    AIRCONDITIONER_MODEL_Blower,        //送风
    AIRCONDITIONER_MODEL_Refrigeration, //制冷
    AIRCONDITIONER_MODEL_Heating,       //制热
};

typedef NS_ENUM(NSInteger, AIRCONDITIONER_WIND) {
    AIRCONDITIONER_WIND_Low = 0,        //低速
    AIRCONDITIONER_WIND_Intermediate,   //中速
    AIRCONDITIONER_WIND_High,           //高速
};

@interface Airconditioner : BaseDevice

@property (nonatomic, assign) BOOL mSwitch;
@property (nonatomic, assign) AIRCONDITIONER_MODEL mModel;
@property (nonatomic, assign) AIRCONDITIONER_WIND mWind;
@property (nonatomic, assign) NSInteger mTemp;

-(void)setAirconditionerSwitch:(BOOL)swit;
-(void)setAirconditionerModel:(AIRCONDITIONER_MODEL)model;
-(void)setAirconditionerWind:(AIRCONDITIONER_WIND)wind;
-(void)setAirconditionerTemp:(NSInteger)temp;

@end
