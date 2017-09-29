//
//  KnockTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/1/18.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^passID)();

@interface KnockTableViewCell : UITableViewCell

@property(nonatomic,strong)passID passId;

@end
