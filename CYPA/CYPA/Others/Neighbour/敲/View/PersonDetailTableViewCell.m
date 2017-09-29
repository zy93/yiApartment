//
//  PersonDetailTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/18.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PersonDetailTableViewCell.h"
#import "Header.h"

@implementation PersonDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    self.introLabel = [[UILabel alloc] init];
    self.introLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.introLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    _detailLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.detailLabel];
    
    
}

-(void)layoutSubviews{
    
    [self.introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
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
