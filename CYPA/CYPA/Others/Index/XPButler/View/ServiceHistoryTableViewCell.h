//
//  ServiceHistoryTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/2/27.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceButton.h"
@interface ServiceHistoryTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView * kindImv;
@property(nonatomic, strong)UILabel * kindLabel;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)UILabel * statusLabel;
@property(nonatomic, strong)UIButton * operateBT;
@property(nonatomic, strong)ServiceButton * evaluateBT;

@end
