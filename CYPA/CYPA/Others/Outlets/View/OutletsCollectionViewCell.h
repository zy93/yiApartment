//
//  OutletsCollectionViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadButton.h"
@interface OutletsCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView * productImv;
@property(nonatomic, strong)UILabel * proNameLabel;
@property(nonatomic, strong)UILabel * realPriceLabel;
@property(nonatomic, strong)UILabel * UnitLabel;
@property(nonatomic, strong)UILabel * pricelabel;
@property(nonatomic, strong)HeadButton * shopBT;
@property(nonatomic, strong)UIImageView * hotImv;
@property(nonatomic, strong)UILabel * lineLable;

@end
