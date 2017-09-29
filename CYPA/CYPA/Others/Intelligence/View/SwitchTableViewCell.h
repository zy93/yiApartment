//
//  SwitchTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/4/1.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadButton.h"
#import "BaseDevice.h"

@interface SwitchTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UISwitch * mSwitch;
@property(nonatomic, strong)UIImageView * mIconView;

@property(nonatomic, strong) BaseDevice *mDevice;

@end
