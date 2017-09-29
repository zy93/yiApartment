//
//  NeighbourTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/5.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NeighbourTableViewCell : UITableViewCell

@property(strong, nonatomic)UIImageView * headImv;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * ageLabel;
//星座
@property(nonatomic, strong)UILabel * constellationLabel;
@property(nonatomic, strong)UILabel * areaLabel;
@property(nonatomic, strong)UIButton * knockBT;

@end
