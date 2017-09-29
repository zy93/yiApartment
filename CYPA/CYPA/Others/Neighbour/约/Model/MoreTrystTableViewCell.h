//
//  MoreTrystTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/10.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopLabel.h"
@interface MoreTrystTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView * headImv;
@property(nonatomic, strong)UILabel *activeLabel;
@property(nonatomic, strong)UIImageView * placeImv;
@property(nonatomic, strong)UILabel * placeLabel;
@property(nonatomic, strong)UIImageView * timeImv;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)TopLabel * introLabel;
@property(nonatomic, strong)UILabel * numLabel;


@end
