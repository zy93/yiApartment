//
//  LockTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "LockTableViewCell.h"
#import "Header.h"

@interface LockTableViewCell ()
@property(nonatomic, strong)UIButton * hourseBT;
//@property(nonatomic, strong)UISlider * slider;


@end

@implementation LockTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    //房间门
    self.hourseBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.hourseBT setImage:[UIImage imageNamed:@"组-48"] forState:normal];
    [self addSubview:self.hourseBT];
    
    //开门
    _openLabel = [[UILabel alloc] init];
    _openLabel.text = @"门开了";
    _openLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    _openLabel.font = [UIFont systemFontOfSize:12.f];
    _openLabel.textAlignment = NSTextAlignmentCenter;
    _openLabel.hidden = YES;
    [self addSubview:_openLabel];
    
    
    //滑动按钮
    self.slider = [[UISlider alloc] init];
    //    self.slider.backgroundColor = [UIColor cyanColor];
    [self addSubview:_slider];
    self.slider.maximumValue = 1.0;
    self.slider.minimumValue = 0.0;
    [self.slider setThumbImage:[UIImage imageNamed:@"111="] forState:(UIControlStateNormal)];
    
    UIImage * clearImage = [self clearPixel];
    [_slider setMaximumTrackImage:clearImage forState:UIControlStateNormal];
    [_slider setMinimumTrackImage:clearImage forState:UIControlStateNormal];
    
    
    //公寓门
    self.apartmentBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.apartmentBT setImage:[UIImage imageNamed:@"组-50"] forState:normal];
    [self addSubview:self.apartmentBT];
    
    //历史
    self.lastLabel = [[UILabel alloc] init];
    self.lastLabel.text = @"上次开锁时间：XXXXXXXXX";
    self.lastLabel.textAlignment = NSTextAlignmentCenter;
    [self.lastLabel setTextColor:[UIColor grayColor]];
    self.lastLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.lastLabel];
    
    
}

-(void)layoutSubviews{
    [self.hourseBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(22.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(161), SIZE_SCALE_IPHONE6(113)));
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hourseBT.mas_left).offset(SIZE_SCALE_IPHONE6(20));
        make.top.mas_equalTo(self.hourseBT.mas_top).offset(SIZE_SCALE_IPHONE6(23));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(122), SIZE_SCALE_IPHONE6(40)));
    }];
    
    [self.openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.slider.mas_left);
        make.right.mas_equalTo(self.slider.mas_right);
        make.top.mas_equalTo(self.slider.mas_top);
        make.bottom.mas_equalTo(self.slider.mas_bottom);
    }];
    
    
    [self.apartmentBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(10));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-22.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(161), SIZE_SCALE_IPHONE6(113)));
    }];
    
    [self.lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hourseBT.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-10));
    }];
    
    
}

//设置slider的滑动颜色
- (UIImage *) clearPixel {
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
