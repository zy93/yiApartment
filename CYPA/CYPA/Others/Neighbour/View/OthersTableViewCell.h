//
//  OthersTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/1/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadButton.h"
@interface OthersTableViewCell : UITableViewCell


@property(nonatomic, strong)HeadButton * headBT;
@property(nonatomic, strong)UIImageView * headImv;
@property(nonatomic, strong)UILabel * contentLabel;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UIImageView * genderImv;




@end
