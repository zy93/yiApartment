//
//  AITCurtain.h
//  CYPA
//
//  Created by 张雨 on 2017/5/16.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import "BaseDevice.h"

typedef NS_ENUM(NSInteger, AITCURTAIN_TYPE) {
    AITCURTAIN_TYPE_On = 1,
    AITCURTAIN_TYPE_Stop  ,
    AITCURTAIN_TYPE_Off   ,
};

typedef void(^AITCurtainResponse)(NSDictionary *dic);


@interface AITCurtain : BaseDevice

@property (nonatomic, assign) AITCURTAIN_TYPE mCurtainState;
@property (nonatomic, strong) AITCurtainResponse controlResponse;

-(void)setControlWithValue:(AITCURTAIN_TYPE)value response:(AITCurtainResponse)block;

@end
