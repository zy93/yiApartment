//
//  QueryDeviceCell.m
//  CYPA
//
//  Created by 张雨 on 2017/5/12.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import "QueryDeviceCell.h"
#import "Header.h"

@implementation QueryDeviceCell

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

-(void)setupView {
    self.mIconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"编号_icon"]];
    [self.contentView addSubview:self.mIconImg];
    
    self.mTitleLab = [[UILabel alloc] init];
    [self.mTitleLab setText:@"查询设备编号"];
    [self.contentView addSubview:self.mTitleLab];
    
    self.mNumberLab = [[UILabel alloc] init];
    [self.mNumberLab setBackgroundColor:UIColorHEX(0xf3f3f3)];
    self.mNumberLab.layer.cornerRadius = 5.f;
    self.mNumberLab.clipsToBounds = YES;
    self.mNumberLab.textAlignment = NSTextAlignmentCenter;
    self.mNumberLab.text = @"3.14159265354182";
    [self.contentView addSubview:self.mNumberLab];
}

-(void)layoutSubviews
{
    [self.mIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
    }];
    [self.mTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.mIconImg.mas_right).with.offset(15);
        make.height.mas_equalTo(30);
    }];
    [self.mNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mIconImg.mas_bottom).with.offset(10);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(32);
    }];
}

-(void)setNumber:(NSString *)number
{
    _number = number;
    [self.mNumberLab setText:number];
}


@end
