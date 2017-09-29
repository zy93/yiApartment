//
//  DatailTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "DatailTableViewCell.h"
#import "KindTableViewCell.h"
#import "Header.h"

@interface DatailTableViewCell ()


@end

@implementation DatailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    //图片
    self.showImv = [[UIImageView alloc] init];
    self.showImv.image = [UIImage imageNamed:@"组-423"];
    [self.contentView addSubview:self.showImv];
    
    //商家名
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:18];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.contentView addSubview:self.nameLabel];
    
    //简介
    self.introduceLabel = [[TopLabel alloc] init];
    self.introduceLabel.font = [UIFont systemFontOfSize:15];
    self.introduceLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.introduceLabel.numberOfLines = 2;
    [self.contentView addSubview:self.introduceLabel];
    
    //销售量
    self.numLabel= [[UILabel alloc] init];
    self.numLabel.font = [UIFont systemFontOfSize:13];
    self.numLabel.textAlignment = NSTextAlignmentRight;
    self.numLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [self.contentView addSubview:self.numLabel];
    
}

-(void)layoutSubviews{
    
    [self.showImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(7.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(114), SIZE_SCALE_IPHONE6(93)));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showImv.mas_top);
        make.left.mas_equalTo(self.showImv.mas_right).offset(SIZE_SCALE_IPHONE6(25));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(200), SIZE_SCALE_IPHONE6(20)));
    }];
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
//        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-30));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-10));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(200), SIZE_SCALE_IPHONE6(20)));
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
