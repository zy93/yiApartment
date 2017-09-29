//
//  TrystCollectionViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/6.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "TrystCollectionViewCell.h"
#import "Header.h"
@implementation TrystCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    //头像
    _headImv = [[UIImageView alloc] init];
//    _headImv.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.headImv];
    
    //活动名
    _activeLabel = [[UILabel alloc] init];
    _activeLabel.font = [UIFont systemFontOfSize:13];
    //    _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _activeLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_activeLabel];
    
    
    //地点
    _placeImv = [[UIImageView alloc] init];
//    _placeImv.backgroundColor = [UIColor blackColor];
    _placeImv.image = [UIImage imageNamed:@"iconfont-zuobiao"];
    [self.contentView addSubview:_placeImv];
    
    //地点
    _placeLabel = [[UILabel alloc] init];
    _placeLabel.font = [UIFont systemFontOfSize:13];
    _placeLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    _placeLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_placeLabel];
    
    //时间
    _timeImv = [[UIImageView alloc] init];
//    _timeImv.backgroundColor = [UIColor blackColor];
    _timeImv.image = [UIImage imageNamed:@"iconfont-time"];
    [self.contentView addSubview:_timeImv];
    
    //时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    _timeLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    
    //发起人
    _holdLabel = [[UILabel alloc] init];
    _holdLabel.font = [UIFont systemFontOfSize:13];
    _holdLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    _holdLabel.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_holdLabel];
    
    //报名人数
    _numLabel = [[UILabel alloc] init];
    _numLabel.font = [UIFont systemFontOfSize:13];
    _numLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    _numLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_numLabel];
    
    //加入活动
    _joinBT = [[HeadButton alloc] init];
    _joinBT.backgroundColor = [UIColor colorWithRed:242/255.0 green:88/255.0 blue:34/255.0 alpha:1];

    _joinBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _joinBT.titleLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    _joinBT.layer.masksToBounds = YES;
    [_joinBT setTitle:@"加入活动" forState:(UIControlStateNormal)];
    [self.contentView addSubview:_joinBT];
    
}

-(void)layoutSubviews{
    [_headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(17.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(26.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(100), SIZE_SCALE_IPHONE6(100)));
    }];
    
    [_activeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImv.mas_top);
        make.left.mas_equalTo(self.headImv.mas_right).offset(SIZE_SCALE_IPHONE6(10));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    [_placeImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_activeLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(4));
        make.left.mas_equalTo(_activeLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(12), SIZE_SCALE_IPHONE6(12)));
    }];
    
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.activeLabel.mas_bottom);
        make.left.mas_equalTo(self.placeImv.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    [_timeImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_placeLabel.mas_bottom).offset(4);
        make.left.mas_equalTo(_activeLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(12), SIZE_SCALE_IPHONE6(12)));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.placeLabel.mas_bottom);
        make.left.mas_equalTo(self.timeImv.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    [_holdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom);
        make.left.mas_equalTo(self.timeImv.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.holdLabel.mas_bottom);
        make.left.mas_equalTo(self.timeImv.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    [_joinBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numLabel.mas_bottom);
        make.right.mas_equalTo(self.mas_right).offset(SIZE_SCALE_IPHONE6(-5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(62), SIZE_SCALE_IPHONE6(20)));
    }];
    
    
}





@end
