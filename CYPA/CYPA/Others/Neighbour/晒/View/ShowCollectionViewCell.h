//
//  ShowCollectionViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/6.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopLabel.h"
@interface ShowCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView * headImv;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel * knockLabel;
@property(nonatomic, strong)UILabel * knockedLabel;
@property (nonatomic,strong)TopLabel * introduceLabel;




@end
