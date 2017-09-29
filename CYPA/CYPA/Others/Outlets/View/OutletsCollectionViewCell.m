//
//  OutletsCollectionViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "OutletsCollectionViewCell.h"
#import "Header.h"
@implementation OutletsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    
    //图片
    _productImv = [[UIImageView alloc] init];
    //    _headImv.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.productImv];
    
    //商品名
    _proNameLabel = [[UILabel alloc] init];
    _proNameLabel.font = [UIFont systemFontOfSize:15];
    _proNameLabel.textAlignment = NSTextAlignmentCenter;
    _proNameLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _proNameLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_proNameLabel];
    
    //原价
    _pricelabel = [[UILabel alloc] init];
    _pricelabel.font = [UIFont systemFontOfSize:15];
    _pricelabel.textColor = [UIColor colorWithHexString:@"666666"];
    //    _pricelabel = [UIColor yellowColor];
    [self.contentView addSubview:_pricelabel];
    
    _lineLable = [[UILabel alloc] init];
    _lineLable.backgroundColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_lineLable];
    
    //现价
    _realPriceLabel = [[UILabel alloc] init];
    _realPriceLabel.font = [UIFont systemFontOfSize:15];
    _realPriceLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    //    _pricelabel = [UIColor yellowColor];
    [self.contentView addSubview:_realPriceLabel];

    //单位
    _UnitLabel = [[UILabel alloc] init];
    _UnitLabel.font = [UIFont systemFontOfSize:15];
    _UnitLabel.textColor = [UIColor redColor];
    //    _UnitLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_UnitLabel];
    
    //hot
    _hotImv = [[UIImageView alloc] init];
    _hotImv.image = [UIImage imageNamed:@"206356851804299183"];
    //    _headImv.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.hotImv];
    
    //加入购物车
    _shopBT = [[HeadButton alloc] init];
    [_shopBT setImage:[UIImage imageNamed:@"iconfont-gouwufangrugouwuche"] forState:normal];
    [self.contentView addSubview:self.shopBT];
    
    
}

-(void)layoutSubviews{
    [_productImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(102.5), SIZE_SCALE_IPHONE6(113)));
    }];
    
    [_proNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.productImv.mas_bottom);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    
    
    [_realPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.proNameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(7.5));
        make.left.mas_equalTo(self.productImv.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_UnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.realPriceLabel.mas_top);
        make.left.mas_equalTo(self.realPriceLabel.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.realPriceLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(7));
        make.left.mas_equalTo(self.realPriceLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.pricelabel.mas_centerY);
        make.right.mas_equalTo(self.pricelabel.mas_right);
        make.left.mas_equalTo(self.pricelabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(1));
    }];
    
    
    [_shopBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.productImv.mas_right);
        make.bottom.mas_equalTo(self.pricelabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(20), SIZE_SCALE_IPHONE6(20)));
    }];
    
    [_hotImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-6));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(20), SIZE_SCALE_IPHONE6(24)));
    }];
    
    
    
}



@end
