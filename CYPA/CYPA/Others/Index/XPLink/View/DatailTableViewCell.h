//
//  DatailTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/2/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopLabel.h"
@interface DatailTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView * showImv;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)TopLabel * introduceLabel;
@property(nonatomic, strong)UILabel * numLabel;


@end
