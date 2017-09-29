//
//  InvateTrystTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/18.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "InvateTrystTableViewCell.h"
#import "Header.h"
@implementation InvateTrystTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    //活动图
    _trystImv = [[UIImageView alloc] init];
    //    _headImv.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.trystImv];
    
    //活动名
    _activeLabel = [[UILabel alloc] init];
    _activeLabel.font = [UIFont systemFontOfSize:15];
    _activeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    _activeLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_activeLabel];
    
    //头像
    _headImv = [[UIImageView alloc] init];
    _headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(20);
    _headImv.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImv];
    
    //姓名
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    _nameLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_nameLabel];
    
    //性别
    _genderImv = [[UIImageView alloc] init];
    //    _genderImv.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_genderImv];
    
    _aLabel = [[UILabel alloc] init];
//    _aLabel.text = @"发起了活动";
    _aLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_aLabel];

    //人数
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = [UIFont systemFontOfSize:13];
    _numberLabel.textColor = [UIColor colorWithHexString:@"666666"];
    //    _nameLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_numberLabel];
    
    //时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor colorWithHexString:@"666666"];
//        _timeLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_timeLabel];
    
    //地点
    _placeLabel = [[UILabel alloc] init];
    _placeLabel.font = [UIFont systemFontOfSize:13];
    _placeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    //    _placeLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_placeLabel];

    //状态
    _stateBT = [[HeadButton alloc] init];
    _stateBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _stateBT.titleLabel.font = [UIFont systemFontOfSize:13];
    _stateBT.backgroundColor = [UIColor grayColor];
    _stateBT.layer.masksToBounds = YES;
    [_stateBT setTintColor: [UIColor colorWithHexString:@"666666"]];
    
    [self.contentView addSubview:self.stateBT];
    
//    //评价
//    _evaluateBT = [[HeadButton alloc] init];
//    _evaluateBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
//    _evaluateBT.titleLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(13)];
//    _evaluateBT.layer.masksToBounds = YES;
//    _evaluateBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
//    [_evaluateBT setTitle:@"评价" forState:normal];
//    [self.contentView addSubview:self.evaluateBT];
//    
    //接受
    _acceptBT = [[HeadButton alloc] init];
    _acceptBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _acceptBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _acceptBT.titleLabel.font = [UIFont systemFontOfSize:13];
    _acceptBT.layer.masksToBounds = YES;
    [_acceptBT setTitle:@"接受" forState:(UIControlStateNormal)];
    _acceptBT.hidden = YES;
    [self.contentView addSubview:_acceptBT];
    
    //忽略
    _refuseBT = [[HeadButton alloc] init];
    _refuseBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _refuseBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _refuseBT.titleLabel.font = [UIFont systemFontOfSize:13];
    _refuseBT.layer.masksToBounds = YES;
    [_refuseBT setTitle:@"拒绝" forState:(UIControlStateNormal)];
    _refuseBT.hidden = YES;
    [self.contentView addSubview:_refuseBT];

    
    
}

-(void)layoutSubviews{
    [_trystImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.width.mas_equalTo(SIZE_SCALE_IPHONE6(115));
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-22.5));
    }];
    
    [_activeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.trystImv.mas_top);
        make.left.mas_equalTo(self.trystImv.mas_right).offset(SIZE_SCALE_IPHONE6(16));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.trystImv.mas_right).offset(SIZE_SCALE_IPHONE6(12.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(40), SIZE_SCALE_IPHONE6(40)));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImv.mas_centerY).offset(SIZE_SCALE_IPHONE6(-10));
        make.left.mas_equalTo(self.headImv.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(13));
    }];
    
    [_genderImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_top).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(_nameLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
    }];
    
    [_aLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImv.mas_centerY).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(13));
    }];
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(self.headImv.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(13));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numberLabel.mas_top);
        make.left.mas_equalTo(self.numberLabel.mas_right).offset(SIZE_SCALE_IPHONE6(10));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(13));
    }];
    
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numberLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(7.5));
        make.left.mas_equalTo(self.headImv.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(13));
    }];

    
    [_stateBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-20));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(70), SIZE_SCALE_IPHONE6(25)));
    }];
    
//    [_evaluateBT mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.stateBT.mas_top).offset(SIZE_SCALE_IPHONE6(-10));
//        make.right.mas_equalTo(self.stateBT.mas_right);
//        make.size.mas_equalTo(self.stateBT);
//    }];
    
    [_acceptBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-20));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(70), SIZE_SCALE_IPHONE6(25)));
    }];
    
    [_refuseBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.stateBT.mas_top).offset(SIZE_SCALE_IPHONE6(-10));
        make.right.mas_equalTo(self.stateBT.mas_right);
        make.size.mas_equalTo(self.stateBT);
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
