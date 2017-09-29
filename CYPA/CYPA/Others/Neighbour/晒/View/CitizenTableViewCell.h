//
//  CitizenTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/7.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitizenTableViewCell : UITableViewCell

@property(strong, nonatomic)UIImageView * headImv;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * showContent;
@property(nonatomic, strong)UIImageView * genderImv;
@property(nonatomic, strong)UILabel * areaLabel;
@property(nonatomic, strong)NSString * imageString;

- (void)setCellImageWithArray:(NSArray *)array;

@end
