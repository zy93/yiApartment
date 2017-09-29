//
//  AITTwoSwitch.h
//  CYPA
//
//  Created by 张雨 on 2017/5/16.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import "BaseDevice.h"


typedef NS_ENUM(NSInteger, AITSWITCH_TYPE) {
    AITSWITCH_TYPE_One = 1,
    AITSWITCH_TYPE_Two    ,
    AITSWITCH_TYPE_Three  ,
};


typedef void(^AITTwoSwitchResponse)(NSDictionary *dic);



@interface AITTwoSwitch : BaseDevice

@property (nonatomic, assign) AITSWITCH_TYPE mSwitchType;

@property (nonatomic, readonly, getter=isOneSwitch) BOOL oneSwitch;
@property (nonatomic, readonly, getter=isTwoSwitch) BOOL twoSwitch;
@property (nonatomic, readonly, getter=isThreeSwitch) BOOL threeSwitch;

@property (nonatomic, strong) AITTwoSwitchResponse controlResponse;

-(void)setControlWithValue:(BOOL)value lightId:(NSInteger)lightId response:(AITTwoSwitchResponse)block;


@end
