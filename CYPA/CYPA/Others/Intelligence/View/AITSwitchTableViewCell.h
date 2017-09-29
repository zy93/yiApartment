//
//  AITSwitchTableViewCell.h
//  CYPA
//
//  Created by 张雨 on 2017/5/15.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDevice.h"


typedef NS_ENUM(NSInteger, AIT_DEVICE_TYPE) {
    AIT_DEVICE_TYPE_CURTAIN =1,
    AIT_DEVICE_TYPE_SWITCH,
};




//艾特三键、两键开关。

typedef NS_ENUM(NSInteger, SWITCH_TYPE) {
    SWITCH_TYPE_TWO = 2,
    SWITCH_TYPE_THREE ,
};


@interface AITSwitchTableViewCell : UITableViewCell

@property (nonatomic, strong) BaseDevice *mDevice;
@property (nonatomic, assign) AIT_DEVICE_TYPE mDeviceType;
@property (nonatomic, assign) SWITCH_TYPE mSwitchType;

@end
