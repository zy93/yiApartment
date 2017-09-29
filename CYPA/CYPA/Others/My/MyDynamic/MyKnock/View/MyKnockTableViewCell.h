//
//  MyKnockTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/18.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadButton.h"

@interface MyKnockTableViewCell : UITableViewCell

@property(strong, nonatomic)UIImageView * headImv;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * ageLabel;
//星座
@property(nonatomic, strong)UILabel * constellationLabel;
@property(nonatomic, strong)UILabel * areaLabel;
//状态
@property(nonatomic, strong)UILabel *stateLabel;

@property (nonatomic,strong)HeadButton * openDoorBT;
@property(nonatomic, strong)HeadButton * refuseBT;




@end
