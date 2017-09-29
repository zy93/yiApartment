//
//  RootTabBarController.h
//  CYPA
//
//  Created by 黄冬冬 on 16/2/15.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPCitizen.h"
@interface RootTabBarController : UITabBarController
@property(nonatomic, strong)XPCitizen * citizenModel;
@property(nonatomic, strong)NSString * UID;
@end
