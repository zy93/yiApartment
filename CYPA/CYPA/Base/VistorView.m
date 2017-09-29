//
//  VistorView.m
//  CYPA
//
//  Created by 李艳庆 on 16/3/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "VistorView.h"
#import "Header.h"
@implementation VistorView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
    
}

-(void)setupViews{
    
    UILabel * label = [[UILabel alloc] init];
    label.text = @"只有公民才有访问权限哦~";
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.center);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
}



@end
