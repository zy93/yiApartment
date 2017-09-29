//
//  IndexViewController.h
//  CYPA
//
//  Created by 黄冬冬 on 16/1/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "XPCitizen.h"

typedef void(^passValueOfLabel)(NSString *value); //传lable的值

@interface IndexViewController : BaseViewController
@property(nonatomic, strong)XPCitizen * citizenModel;
@property(nonatomic, strong)passValueOfLabel passValue;



@end
