//
//  OutletsProductTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "OutletsProductTableViewCell.h"
#import "Header.h"
@implementation OutletsProductTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
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
    
    //现价
    _realPriceLabel = [[UILabel alloc] init];
    _realPriceLabel.font = [UIFont systemFontOfSize:15];
    _realPriceLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    //    _pricelabel = [UIColor yellowColor];
    [self.contentView addSubview:_realPriceLabel];
    
    //单位
    _UnitLabel = [[UILabel alloc] init];
    _UnitLabel.font = [UIFont systemFontOfSize:15];
//    _UnitLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    //    _UnitLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_UnitLabel];

    //-
    _reduceBT = [[HeadButton alloc] init];
    [_reduceBT setTitle:@"-" forState:normal];
    _reduceBT.backgroundColor = [UIColor colorWithHexString:@"BBBBBB"];
    [self.contentView addSubview:self.reduceBT];
    
    _numberTF = [[UITextField alloc] init];
    _numberTF.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    _numberTF.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_numberTF];
    
    //+
    _addBT = [[HeadButton alloc] init];
    [_addBT setTitle:@"+" forState:normal];
    _addBT.backgroundColor = [UIColor colorWithHexString:@"BBBBBB"];
    [self.contentView addSubview:self.addBT];
    
    //合计
    _totalLabel = [[UILabel alloc] init];
    _totalLabel.font = [UIFont systemFontOfSize:15];
    _totalLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    //    _UnitLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_totalLabel];
    
    
}

-(void)layoutSubviews{
    [_productImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(70), SIZE_SCALE_IPHONE6(65)));
    }];
    
    [_proNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.productImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.centerX.mas_equalTo(self.productImv.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_realPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(120));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_UnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.realPriceLabel.mas_top);
        make.left.mas_equalTo(self.realPriceLabel.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_reduceBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(200));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(20), SIZE_SCALE_IPHONE6(20)));
    }];
    
    [_numberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.reduceBT.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(40), SIZE_SCALE_IPHONE6(20)));
    }];
    

    [_addBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.numberTF.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(20), SIZE_SCALE_IPHONE6(20)));
    }];
    
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-20));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
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
