//
//  ConditionTitleTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ConditionTitleTableViewCell.h"
#import "Header.h"

@interface ConditionTitleTableViewCell ()
@property(nonatomic, strong)UILabel * openLabel;
@property(nonatomic, strong)UILabel * currtTempLab;
@property(nonatomic, strong)UIImageView *iconIV;

//@property(nonatomic, strong)UISwitch * conditionSwitch;
//@property(nonatomic, strong)UILabel * onLabel;
//@property(nonatomic, strong)UILabel * offLabel;




@property(nonatomic, strong)UIView * bottomView;
@end

@implementation ConditionTitleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    self.iconIV = [[UIImageView alloc] init];
    [self.iconIV setImage:[UIImage imageNamed:@"空调"]];
    [self.contentView addSubview:self.iconIV];
    
    
    //智能空调
    self.openLabel = [[UILabel alloc] init];
    self.openLabel.text = @"空调";
    self.openLabel.textAlignment = NSTextAlignmentLeft;
    self.openLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.openLabel];
    
    self.currtTempLab = [[UILabel alloc] init];
    self.currtTempLab.text = @"室内温度：32°C";
    self.currtTempLab.textAlignment = NSTextAlignmentCenter;
    self.currtTempLab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.currtTempLab];
    
//    //空调开关
//    self.conditionSwitch = [[UISwitch alloc] init];
//    self.conditionSwitch.backgroundColor = [UIColor yellowColor];
//    [self.contentView addSubview:self.conditionSwitch];
//    
//    //on
//    self.onLabel = [[UILabel alloc] init];
//    self.onLabel.text = @"on";
//    self.onLabel.textAlignment = NSTextAlignmentRight;
//    self.onLabel.font = [UIFont systemFontOfSize:14];
//    self.onLabel.textColor = [UIColor grayColor];
//    [self.contentView addSubview:self.onLabel];
//    
//    //off
//    self.offLabel = [[UILabel alloc] init];
//    self.offLabel.text = @"off";
//    self.offLabel.textAlignment = NSTextAlignmentLeft;
//    self.offLabel.font = [UIFont systemFontOfSize:14];
//    self.offLabel.textColor = [UIColor grayColor];
//    [self.contentView addSubview:self.offLabel];
//
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.contentView addSubview:self.bottomView];
    
    //空调开关
    self.mSwitch = [[UISwitch alloc] init];
    [self addSubview:self.mSwitch];
    
}


-(void)layoutSubviews{
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo();
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
//    self.openLabel.frame = self.bounds;
    [self.openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconIV.mas_right).with.offset(SIZE_SCALE_IPHONE6(10));
        make.centerY.mas_equalTo(self.contentView);
    }];
    self.currtTempLab.frame = self.bounds;

    [self.mSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(7));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
    }];
    
//    [self.offLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self);
//        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(20), SIZE_SCALE_IPHONE6(30)));
//    }];
//    
//    [self.conditionSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self);
//        make.right.mas_equalTo(self.offLabel.mas_left).offset(SIZE_SCALE_IPHONE6(-5));
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(40), SIZE_SCALE_IPHONE6(25)));
//    }];
//    [self.onLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self);
//        make.right.mas_equalTo(self.conditionSwitch.mas_left).offset(SIZE_SCALE_IPHONE6(-5));
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(20), SIZE_SCALE_IPHONE6(30)));
//    }];
    
    self.bottomView.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
