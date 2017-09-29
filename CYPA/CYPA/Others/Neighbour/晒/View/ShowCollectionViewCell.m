//
//  ShowCollectionViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/6.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ShowCollectionViewCell.h"
#import "Header.h"

@interface ShowCollectionViewCell ()

@end

@implementation ShowCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    
    //头像
    _headImv = [[UIImageView alloc] init];
    _headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(22);
    _headImv.layer.masksToBounds = YES;
    _headImv.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.headImv];
    
    //名字
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _nameLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_nameLabel];
    
    //敲门
    _knockLabel = [[UILabel alloc] init];
    _knockLabel.font = [UIFont systemFontOfSize:15];
    _knockLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _knockLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_knockLabel];
    
    //被敲门
    _knockedLabel = [[UILabel alloc] init];
    _knockedLabel.font = [UIFont systemFontOfSize:15];
    _knockedLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _knockedLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_knockedLabel];
    
    
    //签名
    _introduceLabel = [[TopLabel alloc] init];
    _introduceLabel.font = [UIFont systemFontOfSize:15];
    _introduceLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _introduceLabel.numberOfLines = 0;
//    _introduceLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_introduceLabel];
    

 

    
}

-(void)layoutSubviews{
    
    
    
    
    [_headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(44), SIZE_SCALE_IPHONE6(44)));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(6.5));
        make.centerX.mas_equalTo(self.headImv.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(70), SIZE_SCALE_IPHONE6(15)));
    }];
    
    [_knockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(self.headImv.mas_right).offset(SIZE_SCALE_IPHONE6(35));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(15)));
    }];
    
    [_knockedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.knockLabel.mas_top);
        make.left.mas_equalTo(self.knockLabel.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(75), SIZE_SCALE_IPHONE6(15)));
    }];
    
    
    [_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.knockLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(self.knockLabel.mas_left);
        make.right.mas_equalTo(self.knockedLabel.mas_right);
//        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(40));
        
    }];
    


    
    
}




- (void)awakeFromNib {
    // Initialization code
}

@end
