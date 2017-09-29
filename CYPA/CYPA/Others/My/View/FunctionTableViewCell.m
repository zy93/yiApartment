//
//  FunctionTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/17.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "FunctionTableViewCell.h"
#import "Header.h"
@implementation FunctionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    self.functionImv = [[UIImageView alloc] init];
    [self.contentView addSubview:self.functionImv];
    
    self.functionLabel = [[UILabel alloc] init];
    _functionLabel.font = [UIFont systemFontOfSize:15];
    _functionLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.contentView addSubview:self.functionLabel];
    
    
}

-(void)layoutSubviews{
    
    [self.functionImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(25));
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.functionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.functionImv.mas_right).offset(SIZE_SCALE_IPHONE6(32.5));
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
