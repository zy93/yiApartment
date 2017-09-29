//
//  PayTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PayTableViewCell.h"
#import "Header.h"

@implementation PayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    
    return self;
}

-(void)setupViews {
    
    self.totalLabel = [[UILabel alloc] init];
    self.totalLabel.text = @"总费用： 0";
    self.totalLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.totalLabel];
    
    //缴费
    self.payButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.payButton.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    self.payButton.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    self.payButton.layer.masksToBounds = YES;
    self.payButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.payButton setTitle:@"缴费" forState:(UIControlStateNormal)];
    [self.contentView addSubview:self.payButton];
    
    
}

-(void)layoutSubviews{
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.centerY.mas_equalTo(self.totalLabel.mas_centerY);
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
