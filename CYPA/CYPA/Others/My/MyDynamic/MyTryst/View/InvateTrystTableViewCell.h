//
//  InvateTrystTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/18.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadButton.h"
@interface InvateTrystTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView * trystImv;
@property(nonatomic, strong)UIImageView * headImv;
@property(nonatomic, strong)UILabel * activeLabel;
@property(nonatomic, strong)UILabel * nameLabel;
@property (nonatomic,strong)UIImageView * genderImv;
@property(nonatomic, strong)UILabel * aLabel;
@property(nonatomic, strong)UILabel * numberLabel;
@property(nonatomic, strong)UILabel * timeLabel;
@property (nonatomic,strong)UILabel * placeLabel;
@property (nonatomic,strong)HeadButton * stateBT;
//@property(nonatomic, strong)HeadButton * evaluateBT;
@property(nonatomic, strong)HeadButton * acceptBT;
@property(nonatomic, strong)HeadButton * refuseBT;


@end
