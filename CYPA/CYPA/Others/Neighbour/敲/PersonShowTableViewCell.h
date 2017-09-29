//
//  PersonShowTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/9.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopLabel.h"
@interface PersonShowTableViewCell : UITableViewCell

//@property(nonatomic, strong)NSString * imageString;
@property(nonatomic, strong)TopLabel * showContent;
@property (nonatomic,strong)UILabel * timeLabel;


- (void)setCellImageWithArray:(NSArray *)array;

- (void)cellAutoLayoutHeight:(NSString *)str;



@end
