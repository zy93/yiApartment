//
//  DeviceGroup.h
//  CYPA
//
//  Created by 张雨 on 2017/5/10.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface DeviceGroup : Jastor

@property (nonatomic, strong) NSNumber *groupId;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *locationDescription;
@property (nonatomic, strong) NSString *longitude;
@end
