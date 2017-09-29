//
//  SetDeviceInfoCell.m
//  CYPA
//
//  Created by 张雨 on 2017/5/12.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import "SetDeviceInfoCell.h"
#import "Header.h"


@implementation SetDeviceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    self.mIconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"设置_icon"]];
    [self.contentView addSubview:self.mIconImg];
    
    self.mTitleLabel = [[UILabel alloc] init];
    self.mTitleLabel.text =  @"设置";
    self.mTitleLabel.font = [UIFont boldSystemFontOfSize:20.f];
    [self.contentView addSubview:self.mTitleLabel];
    
    //
    self.mSetDeviceIdTitleLab = [[UILabel alloc] init];
    self.mSetDeviceIdTitleLab.text =  @"设置设备编号";
    self.mSetDeviceIdTitleLab.font = [UIFont boldSystemFontOfSize:13.f];
    self.mSetDeviceIdTitleLab.textColor = UIColorHEX(0x494949);
    [self.contentView addSubview:self.mSetDeviceIdTitleLab];
    
    self.mSetDeviceIdTypeText = [[UITextField alloc] init];
    self.mSetDeviceIdTypeText.placeholder = @"type";
    self.mSetDeviceIdTypeText.layer.cornerRadius = 5.f;
    self.mSetDeviceIdTypeText.clipsToBounds = YES;
    self.mSetDeviceIdTypeText.textAlignment = NSTextAlignmentCenter;
    self.mSetDeviceIdTypeText.backgroundColor = UIColorHEX(0xf3f3f3);
    [self.contentView addSubview:self.mSetDeviceIdTypeText];
    
    self.mSetDeviceIdNumberText = [[UITextField alloc] init];
    self.mSetDeviceIdNumberText.placeholder = @"number";
    self.mSetDeviceIdNumberText.layer.cornerRadius = 5.f;
    self.mSetDeviceIdNumberText.clipsToBounds = YES;
    self.mSetDeviceIdNumberText.textAlignment = NSTextAlignmentCenter;
    self.mSetDeviceIdNumberText.backgroundColor = UIColorHEX(0xf3f3f3);
    [self.contentView addSubview:self.mSetDeviceIdNumberText];
    
    //pr
    self.mSetPriceTitleLab = [[UILabel alloc] init];
    self.mSetPriceTitleLab.text =  @"修改单价";
    self.mSetPriceTitleLab.font = [UIFont boldSystemFontOfSize:13.f];
    self.mSetPriceTitleLab.textColor = UIColorHEX(0x494949);
    [self.contentView addSubview:self.mSetPriceTitleLab];
    
    self.mSetPriceText = [[UITextField alloc] init];
    self.mSetPriceText.placeholder = @"设置价格";
    self.mSetPriceText.layer.cornerRadius = 5.f;
    self.mSetPriceText.clipsToBounds = YES;
    self.mSetPriceText.textAlignment = NSTextAlignmentLeft;
    self.mSetPriceText.backgroundColor = UIColorHEX(0xf3f3f3);
    [self.contentView addSubview:self.mSetPriceText];
    
    //
    self.mFluxSumTitleLab = [[UILabel alloc] init];
    self.mFluxSumTitleLab.text =  @"修改脉冲计数价";
    self.mFluxSumTitleLab.font = [UIFont boldSystemFontOfSize:13.f];
    self.mFluxSumTitleLab.textColor = UIColorHEX(0x494949);
    [self.contentView addSubview:self.mFluxSumTitleLab];
    
    self.mFluxSumText = [[UITextField alloc] init];
    self.mFluxSumText.placeholder = @"设置价格";
    self.mFluxSumText.layer.cornerRadius = 5.f;
    self.mFluxSumText.clipsToBounds = YES;
    self.mFluxSumText.textAlignment = NSTextAlignmentLeft;
    self.mFluxSumText.backgroundColor = UIColorHEX(0xf3f3f3);
    [self.contentView addSubview:self.mFluxSumText];
    
    self.mDownBtn = [[UIButton alloc] init];
    [self.mDownBtn setTitleColor:UIColorHEX(0xea5404) forState:UIControlStateNormal];
    [self.mDownBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.mDownBtn addTarget:self action:@selector(downBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.mDownBtn];
}

-(void)layoutSubviews
{
    CGFloat topSpace1 = 10;
    CGFloat topSpace2 = 8;
    CGFloat leftSpace1 = 20;
    CGFloat textHight = 33;
    
    [self.mIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(topSpace1));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(leftSpace1));
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.mTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mIconImg.mas_centerY);
        make.left.mas_equalTo(self.mIconImg.mas_right).with.offset(SIZE_SCALE_IPHONE6(leftSpace1));
    }];
    
    [self.mSetDeviceIdTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(self.mIconImg.mas_bottom).with.offset(SIZE_SCALE_IPHONE6(topSpace1));
    }];
    
    [self.mSetDeviceIdTypeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mSetDeviceIdTitleLab.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.mSetDeviceIdTitleLab.mas_left);
        make.height.mas_equalTo(textHight);
    }];
    [self.mSetDeviceIdNumberText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mSetDeviceIdTypeText.mas_right).with.offset(SIZE_SCALE_IPHONE6(leftSpace1));
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(textHight);
        make.centerY.mas_equalTo(self.mSetDeviceIdTypeText.mas_centerY);
        make.width.mas_equalTo(self.mSetDeviceIdTypeText.mas_width);
    }];
    //
    [self.mSetPriceTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mSetDeviceIdTitleLab.mas_left);
        make.top.mas_equalTo(self.mSetDeviceIdTypeText.mas_bottom).with.offset(SIZE_SCALE_IPHONE6(topSpace2));
    }];
    
    [self.mSetPriceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mSetPriceTitleLab.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.mSetPriceTitleLab.mas_left);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(textHight);
    }];
    
    //
    [self.mFluxSumTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mSetDeviceIdTitleLab.mas_left);
        make.top.mas_equalTo(self.mSetPriceText.mas_bottom).with.offset(SIZE_SCALE_IPHONE6(topSpace2));
    }];
    
    [self.mFluxSumText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mFluxSumTitleLab.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.mFluxSumTitleLab.mas_left);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(textHight);
    }];
    
    [self.mDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mFluxSumText.mas_bottom);
        make.right.mas_equalTo(-leftSpace1);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(60);
    }];
    
}

-(void)downBtn:(UIButton *)sender
{
    if (!strIsEmpty(self.mSetDeviceIdTypeText.text) && !strIsEmpty(self.mSetDeviceIdNumberText.text)) {
        if ([_mDelegate respondsToSelector:@selector(changeDeviceIdWithType:number:)]) {
            [_mDelegate changeDeviceIdWithType:self.mSetDeviceIdTypeText.text number:self.mSetDeviceIdNumberText.text];
        }
    }
    if (!strIsEmpty(self.mSetPriceText.text)) {
        if ([_mDelegate respondsToSelector:@selector(changePriceWithPrice:)]) {
            [_mDelegate changePriceWithPrice:self.mSetPriceText.text];
        }
    }
    if (!strIsEmpty(self.mFluxSumText.text)) {
        if ([_mDelegate respondsToSelector:@selector(changeFluxSumWithPrice:)]) {
            [_mDelegate changeFluxSumWithPrice:self.mFluxSumText.text];
        }
    }
}


@end
