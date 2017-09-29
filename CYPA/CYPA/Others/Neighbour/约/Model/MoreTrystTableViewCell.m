//
//  MoreTrystTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/10.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MoreTrystTableViewCell.h"
#import "Header.h"
#import "TopLabel.h"
@implementation MoreTrystTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    
    return self;
}

-(void)setupViews {
    //头像
    _headImv = [[UIImageView alloc] init];
        _headImv.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.headImv];
    
    //活动名
    _activeLabel = [[UILabel alloc] init];
    _activeLabel.font = [UIFont systemFontOfSize:18];
    _activeLabel.textColor = [UIColor colorWithHexString:@"333333"];
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
    
    //活动简介
    _introLabel = [[TopLabel alloc] init];
    _introLabel.font = [UIFont systemFontOfSize:13];
    _introLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _introLabel.numberOfLines = 0;
//    [_introLabel setContentMode:(UIViewContentModeTop)];
    [_introLabel setVerticalAlignment:VerticalAlignmentTop];
//        _introLabel.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_introLabel];
    
    //报名人数
    _numLabel = [[UILabel alloc] init];
    _numLabel.font = [UIFont systemFontOfSize:13];
    _numLabel.textColor = [UIColor colorWithHexString:@"666666"];
    //    _numLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_numLabel];
    
    
}

-(void)layoutSubviews{
    [_headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(45));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-31));
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-10));
        make.width.mas_equalTo(SIZE_SCALE_IPHONE6(122));
    }];
    
    [_activeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(7.5));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    [_placeImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(40));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(12), SIZE_SCALE_IPHONE6(12)));
    }];
    
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.placeImv.mas_centerY);
        make.left.mas_equalTo(self.placeImv.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(13));
    }];
    
    [_timeImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_placeLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(_placeImv.mas_left);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(12), SIZE_SCALE_IPHONE6(12)));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeImv.mas_centerY);
        make.left.mas_equalTo(self.timeImv.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(13));
    }];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(self.timeImv.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(13));
    }];
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(self.numLabel.mas_left);
//        make.size.mas_equalTo(size);
        make.bottom.mas_equalTo(self.headImv.mas_bottom);
        make.right.mas_equalTo(self.headImv.mas_left).offset(SIZE_SCALE_IPHONE6(-30));
    }];
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
