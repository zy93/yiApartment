//
//  GiftCollectionViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "GiftCollectionViewCell.h"

@implementation GiftCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.text = @"红玫瑰      9元/朵";
    self.priceLabel.numberOfLines = 0;
    [self.priceLabel setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.priceLabel];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendButton setTitle:@"赠送" forState:(UIControlStateNormal)];
    self.sendButton.backgroundColor = [UIColor redColor];
    self.sendButton.layer.cornerRadius = 5;
    [self.contentView addSubview:self.sendButton];
    
    
}

-(void)layoutSubviews {
    
    self.priceLabel.frame = CGRectMake(self.frame.size.width - 100, self.frame.size.height - 100, 60, 50);
    self.sendButton.frame = CGRectMake(self.priceLabel.frame.origin.x, CGRectGetMaxY(self.priceLabel.frame) + 10, 60, 30);
    
}

@end
