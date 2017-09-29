//
//  KnockCollectionViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/1/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadButton.h"
@interface KnockCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView * headImv;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UIImageView * genderImv;
@property(nonatomic, strong)UILabel * introducelabel;
@property (nonatomic,strong)HeadButton * knockBT;

@end
