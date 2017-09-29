//
//  KnockCollectionViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "KnockCollectionViewCell.h"
#import "Header.h"

@implementation KnockCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

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
    _headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(22);
    _headImv.layer.masksToBounds = YES;
//    _headImv.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.headImv];
    
    //名字
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _nameLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_nameLabel];
    
    
    //性别
    _genderImv = [[UIImageView alloc] init];
//    _genderImv.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_genderImv];
    
    //签名
    _introducelabel = [[UILabel alloc] init];
    _introducelabel.font = [UIFont systemFontOfSize:15];
    _introducelabel.textColor = [UIColor colorWithHexString:@"666666"];
    _introducelabel.numberOfLines = 2;
//    _introducelabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_introducelabel];
    
    //敲门
    _knockBT = [[HeadButton alloc] init];
//    _knockBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _knockBT.backgroundColor = [UIColor colorWithRed:242/255.0 green:88/255.0 blue:34/255.0 alpha:1];
    _knockBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _knockBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _knockBT.layer.masksToBounds = YES;
    [_knockBT setTitle:@"敲门" forState:(UIControlStateNormal)];
    [self.contentView addSubview:_knockBT];
    
}

-(void)layoutSubviews{
    [_headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(8));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(44), SIZE_SCALE_IPHONE6(44)));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(self.headImv.mas_right).offset(SIZE_SCALE_IPHONE6(11));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(65), SIZE_SCALE_IPHONE6(15)));
    }];
    
    [_genderImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_top);
        make.left.mas_equalTo(_nameLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
    }];

    [_introducelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(0));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];
    
    [_knockBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.introducelabel.mas_bottom);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(62), SIZE_SCALE_IPHONE6(20)));
    }];
    
    
}


@end
