//
//  NetWorkView.m
//  CYPA
//
//  Created by 李艳庆 on 16/3/26.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "NetWorkView.h"

#import "Header.h"
@implementation NetWorkView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
    
}

-(void)setupViews{
    
    UILabel * label = [[UILabel alloc] init];
    label.text = @"当前没网哦~";
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(300));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //标题栏
    self.titleImv = [[UIImageView alloc] init];
    self.titleImv.image = [UIImage imageNamed:@"矩形-5-拷贝-2"];
    [self addSubview:self.titleImv];
    
    [self.titleImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        //        make.height.equalTo(weakSelf).offset(SIZE_SCALE_IPHONE6(87));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(43.5));
    }];
    
    
    //返回
    self.backBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBT setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:normal];
    [self addSubview:self.backBT];
    
    [self.backBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleImv);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(43.5), SIZE_SCALE_IPHONE6(43.5)));
        
    }];
    
}




@end
