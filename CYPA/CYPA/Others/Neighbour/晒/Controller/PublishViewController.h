//
//  PublishViewController.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/8.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPCitizen.h"
#import "BaseViewController.h"
@interface PublishViewController : BaseViewController

@property (nonatomic,strong)UIImageView * headImv;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UIImageView * genderImv;
@property (nonatomic,strong)XPCitizen * citizenModel;

@end
