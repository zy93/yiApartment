//
//  LockTitleTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "LockTitleTableViewCell.h"
#import "Header.h"
@interface LockTitleTableViewCell ()


@property(nonatomic, strong)UIView * bottomView;

@end

@implementation LockTitleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    //一键开门
    self.openLabel = [[UILabel alloc] init];
    self.openLabel.text = @"一键开锁";
    self.openLabel.font = [UIFont systemFontOfSize:18];
    self.openLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.openLabel];
    
    //开门历史
    self.historyBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.historyBT setTitle:@"开锁历史>>" forState:(UIControlStateNormal)];
    [self.historyBT setTitleColor:[UIColor grayColor] forState:normal];
    self.historyBT.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.historyBT];

    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.contentView addSubview:self.bottomView];
    
}

- (void)awakeFromNib {
    
    
}

-(void)layoutSubviews{
    
    self.openLabel.frame = self.bounds;
    
    self.historyBT.frame = CGRectMake(self.frame.size.width - 100, 0.5*self.frame.size.height, 100, 0.5*self.frame.size.height);
    
    self.bottomView.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
