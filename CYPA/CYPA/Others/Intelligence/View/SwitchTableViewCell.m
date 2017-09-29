//
//  SwitchTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/4/1.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "SwitchTableViewCell.h"
#import "Header.h"
@implementation SwitchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    self.mIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"饮水机-1"]];
    [self.contentView addSubview:self.mIconView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:15.f];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"3333333"];
    [self.contentView addSubview:self.nameLabel];
    
    self.mSwitch = [[UISwitch alloc] init];
//    [self.mSwitch setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:self.mSwitch];
    
}

-(void)layoutSubviews{
    
    [self.mIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(27), SIZE_SCALE_IPHONE6(27)));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mIconView.mas_right).with.offset(10);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
//    [self.onLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-10));
//        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
//        make.centerY.mas_equalTo(self.mas_centerY);
//    }];
    
    [self.mSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
//    [self.offLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.switchBT.mas_left);
//        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
//        make.centerY.mas_equalTo(self.mas_centerY);
//    }];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
