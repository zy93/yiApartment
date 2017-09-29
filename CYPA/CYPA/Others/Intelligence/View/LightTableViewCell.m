//
//  LightTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "LightTableViewCell.h"

#import "PowerTableViewCell.h"
#import "Header.h"
@interface LightTableViewCell ()
@property(nonatomic, strong)UILabel * openLabel;
//@property(nonatomic, strong)UISwitch * conditionSwitch;
//
//@property(nonatomic, strong)UILabel * onLabel;
//@property(nonatomic, strong)UILabel * offLabel;

@end

@implementation LightTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    //灯光
    self.openLabel = [[UILabel alloc] init];
    self.openLabel.text = @"   灯光管理";
//    self.openLabel.textAlignment = NSTextAlignmentCenter;
    self.openLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(18)];
    [self.contentView addSubview:self.openLabel];
    
//    //电源开关
//    self.conditionSwitch = [[UISwitch alloc] init];
//    //    self.conditionSwitch.backgroundColor = [UIColor yellowColor];
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
    
    
    //空调开关
    self.changeBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    [self.changeBT setImage:[UIImage imageNamed:@"组-989"] forState:UIControlStateNormal];
    [self addSubview:self.changeBT];
    
}

-(void)layoutSubviews {
    
    self.openLabel.frame = self.bounds;
    
    [self.changeBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(7));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(95), SIZE_SCALE_IPHONE6(27)));
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
