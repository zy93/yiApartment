//
//  OutletsProductTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadButton.h"
@interface OutletsProductTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView * productImv;
@property(nonatomic, strong)UILabel * proNameLabel;
@property(nonatomic, strong)UILabel * realPriceLabel;
@property(nonatomic, strong)UILabel * UnitLabel;
@property(nonatomic, strong)HeadButton * addBT;
@property(nonatomic, strong)UITextField * numberTF;
@property(nonatomic, strong)HeadButton * reduceBT;
@property(nonatomic, strong)UILabel * totalLabel;



@end
