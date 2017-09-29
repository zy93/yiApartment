//
//  FriendTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/11.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "FriendTableViewCell.h"
#import "Header.h"
@implementation FriendTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    //头像
    _headImv = [[UIImageView alloc] init];
    _headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(32.5);
    _headImv.layer.masksToBounds = YES;
    //    _headImv.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.headImv];
    
    //名字
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.text = @"测试";
    _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    _nameLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_nameLabel];
    
    //年龄
    _ageLabel = [[UILabel alloc] init];
    _ageLabel.font = [UIFont systemFontOfSize:15];
    _ageLabel.textColor = [UIColor colorWithHexString:@"666666"];
    //    _ageLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_ageLabel];
    
    //星座
    _constellationLabel = [[UILabel alloc] init];
    _constellationLabel.font = [UIFont systemFontOfSize:15];
    _constellationLabel.textColor = [UIColor colorWithHexString:@"666666"];
    //    _constellationLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_constellationLabel];
    
    //地点
    _areaLabel = [[UILabel alloc] init];
    _areaLabel.font = [UIFont systemFontOfSize:15];
    _areaLabel.textColor = [UIColor colorWithHexString:@"666666"];
    //    _areaLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_areaLabel];
    
    //邀请
    _inviteBT = [[HeadButton alloc] init];
    //    _knockBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _inviteBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _inviteBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _inviteBT.layer.masksToBounds = YES;
    [_inviteBT setTitle:@"邀请" forState:(UIControlStateNormal)];
    [self.contentView addSubview:_inviteBT];
    
}

-(void)layoutSubviews{
    [_headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(65), SIZE_SCALE_IPHONE6(65)));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(11));
        make.left.mas_equalTo(self.headImv.mas_right).offset(SIZE_SCALE_IPHONE6(20));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(11));
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(40), SIZE_SCALE_IPHONE6(13)));
    }];
    
    [_constellationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ageLabel.mas_top);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(SIZE_SCALE_IPHONE6(10));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(13));
    }];
    
    [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ageLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(11));
        make.left.mas_equalTo(self.ageLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(13));
    }];
    
    [_inviteBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
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
