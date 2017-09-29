//
//  ConditionTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/2/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionTableViewCell : UITableViewCell

@property(nonatomic, strong) UIButton * mLowBtn; //低速
@property(nonatomic, strong) UIButton * mIntermediateBtn;//中速
@property(nonatomic, strong) UIButton * mHighBtn; //高速
@property(nonatomic, strong) UISlider * mSlider;
@property(nonatomic, strong) UIButton * mCoolBtn;
@property(nonatomic, strong) UIButton * mHotBtn;
@property(nonatomic, strong) UIView * mBGView;
//@property(nonatomic, assign) int tempNum;
//@property(nonatomic, strong) UILabel * temperature;//温度



@end
