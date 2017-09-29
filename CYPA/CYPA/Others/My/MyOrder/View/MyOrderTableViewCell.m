//
//  MyOrderTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "Header.h"
@implementation MyOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    //收货人
    self.nameLabel = [[UILabel alloc] init];
    //    self.timeLabel.backgroundColor = [UIColor yellowColor];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
//    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    
    //花费
    self.costLabel = [[UILabel alloc] init];
    //    self.costLabel.backgroundColor = [UIColor orangeColor];
    self.costLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.costLabel.font = [UIFont systemFontOfSize:15];
//    self.costLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.costLabel];
    
    //下单时间
    self.createLabel = [[UILabel alloc] init];
    //    self.costLabel.backgroundColor = [UIColor orangeColor];
    self.createLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.createLabel.font = [UIFont systemFontOfSize:15];
//    self.costLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.createLabel];

}


-(void)layoutSubviews{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(20));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [self.costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(20));
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [self.createLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.costLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(20));
        make.left.mas_equalTo(self.costLabel.mas_left);
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
