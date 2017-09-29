//
//  ConditionTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ConditionTableViewCell.h"

#import "Header.h"


@interface ConditionTableViewCell ()
//@property(nonatomic, strong)UIButton * heatBT;
//@property(nonatomic, strong)UIButton * coldBT;

@end

@implementation ConditionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    //温度
//    self.tempNum = 24;
//    self.temperature = [[UILabel alloc] init];
////    self.temperature.backgroundColor = [UIColor cyanColor];
//    self.temperature.text = [NSString stringWithFormat:@" %ldº", (long)self.tempNum];
//    self.temperature.textAlignment = NSTextAlignmentCenter;
//    self.temperature.font = [UIFont systemFontOfSize:76];
//    [self.contentView addSubview:self.temperature];
//    //加热
//    self.heatBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.heatBT setImage:[UIImage imageNamed:@"组-993"] forState:(UIControlStateNormal)];
//    [self.contentView addSubview:self.heatBT];
//    
//    //制冷
//    self.coldBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.coldBT setImage:[UIImage imageNamed:@"组-992"] forState:(UIControlStateNormal)];
//    [self.contentView addSubview:self.coldBT];
//    //温度+
//    self.addBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.addBT setImage:[UIImage imageNamed:@"+"] forState:(UIControlStateNormal)];
//    [self.contentView addSubview:self.addBT];
//    
//    //温度—
//    self.decreaseBT = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.decreaseBT setImage:[UIImage imageNamed:@"-0"] forState:(UIControlStateNormal)];
//    [self.contentView addSubview:self.decreaseBT];
    
    self.mBGView = [[UIView alloc] init];
    [self.mBGView setBackgroundColor:UIColorHEX(0xf2f2f3)];
    [self.contentView addSubview:self.mBGView];
    
    self.mLowBtn = [[UIButton alloc] init];
    [self.mLowBtn setTitle:@"低" forState:UIControlStateNormal];
    [self.mLowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.mLowBtn setImage:[UIImage imageNamed:@"低"] forState:UIControlStateNormal];
//    [self.mLowBtn setImage:[UIImage imageWithColor:UIColorHEX(0x52d666)] forState:UIControlStateNormal];
//    [self.mLowBtn setBackgroundColor:[UIColor redColor]];
    [self.mBGView addSubview:self.mLowBtn];
    
    self.mIntermediateBtn = [[UIButton alloc] init];
    [self.mIntermediateBtn setTitle:@"中" forState:UIControlStateNormal];
    [self.mIntermediateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.mIntermediateBtn setImage:[UIImage imageNamed:@"中"] forState:UIControlStateNormal];
//    [self.mIntermediateBtn setBackgroundColor:[UIColor redColor]];
    [self.mBGView addSubview:self.mIntermediateBtn];
    
    self.mHighBtn = [[UIButton alloc] init];
    [self.mHighBtn setTitle:@"高" forState:UIControlStateNormal];
    [self.mHighBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.mHighBtn setImage:[UIImage imageNamed:@"高"] forState:UIControlStateNormal];
    [self.mHighBtn setTintColor:UIColorHEX(0x52d666)];
    [self.mHighBtn setImage:[[UIImage imageNamed:@"高"] imageWithColor:UIColorHEX(0x52d666)] forState:UIControlStateNormal];

    [self.mBGView addSubview:self.mHighBtn];
    
    self.mSlider = [[UISlider alloc] init];
    [self.mSlider setMaximumValue:32];
    [self.mSlider setMinimumValue:16];
    [self.mBGView addSubview:self.mSlider];
    
    
    self.mCoolBtn = [[UIButton alloc] init];
    [self.mCoolBtn setImage:[UIImage imageNamed:@"制冷_icon"] forState:UIControlStateNormal];
    [self.mBGView addSubview:self.mCoolBtn];
    
    self.mHotBtn = [[UIButton alloc] init];
    [self.mHotBtn setImage:[UIImage imageNamed:@"制热_icon"] forState:UIControlStateNormal];
    [self.mBGView addSubview:self.mHotBtn];
    
}


-(void)layoutSubviews{
    
    [self.mBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).with.offset(15);
        make.left.mas_equalTo(self.contentView).with.offset(15);
        make.bottom.mas_equalTo(self.contentView).with.offset(-15);
        make.right.mas_equalTo(self.contentView).with.offset(-15);

    }];
    

    [self.mIntermediateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(5));
        make.centerX.mas_equalTo(self.mBGView);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(50), SIZE_SCALE_IPHONE6(80)));
    }];
    [self setVeloctyCenter:self.mIntermediateBtn];
    
    
    [self.mLowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mIntermediateBtn.mas_top);
        make.right.mas_equalTo(self.mIntermediateBtn.mas_left).with.offset(-SIZE_SCALE_IPHONE6(45));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(50), SIZE_SCALE_IPHONE6(80)));
    }];
    [self setVeloctyCenter:self.mLowBtn];
    
    [self.mHighBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mIntermediateBtn.mas_top);
        make.left.mas_equalTo(self.mIntermediateBtn.mas_right).with.offset(SIZE_SCALE_IPHONE6(45));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(50), SIZE_SCALE_IPHONE6(80)));
    }];
    [self setVeloctyCenter:self.mHighBtn];
    
    [self.mSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mIntermediateBtn.mas_bottom).with.offset(30);
        make.centerX.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(220), 20));
    }];
    
    [self.mCoolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mSlider.mas_bottom).with.offset(30);
        make.centerX.mas_equalTo(self.mLowBtn.mas_centerX);
    }];
    
    [self.mHotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mCoolBtn);
        make.centerX.mas_equalTo(self.mHighBtn.mas_centerX);
    }];

//    [self.temperature mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(30));
//        make.centerX.mas_equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(180), SIZE_SCALE_IPHONE6(70)));
//    }];
//    
//    [self.heatBT mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-18.5));
//        make.right.mas_equalTo(self.mas_centerX).offset(SIZE_SCALE_IPHONE6(-10));
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(90), SIZE_SCALE_IPHONE6(45)));
//    }];
//    
//    [self.coldBT mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.heatBT.mas_top);
//        make.left.mas_equalTo(self.heatBT.mas_right).offset(SIZE_SCALE_IPHONE6(20));
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(90), SIZE_SCALE_IPHONE6(45)));
//    }];
//    
//    [self.addBT mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.temperature.mas_centerY);
//        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(50));
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(50), SIZE_SCALE_IPHONE6(50)));
//    }];
//    
//    [self.decreaseBT mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.temperature.mas_centerY);
//        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-50));
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(50), SIZE_SCALE_IPHONE6(50)));
//    }];

}


-(void)setVeloctyCenter:(UIButton *)btn
{
    CGSize imgViewSize,titleSize,btnSize;
    UIEdgeInsets imageViewEdge,titleEdge;
    
    //设置按钮内边距
    imgViewSize = CGSizeMake(btn.frame.size.width, btn.frame.size.width);//btn.imageView.bounds.size;
    titleSize = btn.titleLabel.bounds.size;
    btnSize = btn.bounds.size;
    imageViewEdge = UIEdgeInsetsMake(0,
                                     0,
                                     -imgViewSize.height/2,
                                     -imgViewSize.width/2+5);
    
    titleEdge = UIEdgeInsetsMake(-imgViewSize.height/2, -imgViewSize.width/2, 0,
                                 0);
    [btn setTitleEdgeInsets:titleEdge];
    [btn setImageEdgeInsets:imageViewEdge];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
