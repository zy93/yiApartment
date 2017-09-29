//
//  ServiceHistoryTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/27.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ServiceHistoryTableViewCell.h"
#import "Header.h"
@implementation ServiceHistoryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    //服务图片
    self.kindImv = [[UIImageView alloc] init];
//    self.kindImv.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.kindImv];
    
    //服务类型
    self.kindLabel = [[UILabel alloc] init];
//    self.kindLabel.backgroundColor = [UIColor yellowColor];
    self.kindLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.kindLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.kindLabel];
    
    //时间
    self.timeLabel = [[UILabel alloc] init];
//    self.timeLabel.backgroundColor = [UIColor orangeColor];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.timeLabel]
    ;
    
    //状态
    self.statusLabel = [[UILabel alloc] init];
//    self.statusLabel.backgroundColor = [UIColor grayColor];
    self.statusLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.statusLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.statusLabel];
    
    //评价
    self.evaluateBT = [ServiceButton buttonWithType:(UIButtonTypeCustom)];
//    self.evaluateBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
//    [self.evaluateBT setTitle:@"评价" forState:(UIControlStateNormal)];
    self.evaluateBT.titleLabel.font = [UIFont systemFontOfSize:15];
    self.evaluateBT.layer.cornerRadius = 3;
    self.evaluateBT.layer.masksToBounds = YES;
    [self.contentView addSubview:self.evaluateBT];
}

-(void)layoutSubviews {
    
    [self.kindImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(18), SIZE_SCALE_IPHONE6(18)));
    }];
    
    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.kindImv.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.kindLabel.mas_right).offset(SIZE_SCALE_IPHONE6(20));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.timeLabel.mas_right).offset(SIZE_SCALE_IPHONE6(20));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    [self.evaluateBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(50), SIZE_SCALE_IPHONE6(20)));
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
