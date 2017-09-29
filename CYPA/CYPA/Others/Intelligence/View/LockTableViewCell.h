//
//  LockTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/2/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LockTableViewCell : UITableViewCell
@property(nonatomic, strong)UISlider * slider;
@property(nonatomic, strong)UIButton * apartmentBT;
@property(nonatomic, strong)UILabel * lastLabel; //上次开锁时间
@property(nonatomic, strong)UILabel *openLabel; //门开了

@end
