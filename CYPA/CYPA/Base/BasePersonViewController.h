//
//  BasePersonViewController.h
//  CYPA
//
//  Created by 黄冬冬 on 16/2/15.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>

@interface BasePersonViewController : BaseViewController

@property(nonatomic, strong)UIImageView *headImv;
@property(nonatomic, strong)UIImageView *titleImv;
@property(nonatomic, strong)UIImageView *backgroundImv;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *ageLabel;
@property (nonatomic,strong)UIImageView *genderImv;
@property(nonatomic, strong)UIButton *backBT;
@property(nonatomic, strong)UIButton *knockBT;

@end
