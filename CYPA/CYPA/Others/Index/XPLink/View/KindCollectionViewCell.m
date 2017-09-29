//
//  KindCollectionViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "KindCollectionViewCell.h"
#import "Header.h"

@interface KindCollectionViewCell ()

@end

@implementation KindCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    //图片
    self.kindImv = [[UIImageView alloc] init];
//    self.kindImv.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.kindImv];
    
    //文字
    self.nameLabel = [[UILabel alloc] init];
//    self.nameLabel.backgroundColor = [UIColor cyanColor];
    self.nameLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    
}

-(void)layoutSubviews{
    self.kindImv.frame = CGRectMake(SIZE_SCALE_IPHONE6(15), 0, SIZE_SCALE_IPHONE6(41), SIZE_SCALE_IPHONE6(41));
    self.nameLabel.frame = CGRectMake(0, SIZE_SCALE_IPHONE6(46), SIZE_SCALE_IPHONE6(72), SIZE_SCALE_IPHONE6(15));
}

@end
