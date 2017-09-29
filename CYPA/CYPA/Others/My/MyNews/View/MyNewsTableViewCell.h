//
//  MyNewsTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/20.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopLabel.h"
#import "HeadButton.h"

@interface MyNewsTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel * contentLabel;
@property(nonatomic, strong)UIImageView * hornImv;
@property(nonatomic, strong)UIButton *expandButton; //展开按钮


@end
