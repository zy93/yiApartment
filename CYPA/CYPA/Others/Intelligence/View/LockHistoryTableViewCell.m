//
//  LockHistoryTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "LockHistoryTableViewCell.h"
#import "Header.h"

@interface LockHistoryTableViewCell ()
@property(nonatomic, strong)UILabel * openLabel;

@property(nonatomic, strong)UIView * bottomView;


@end


@implementation LockHistoryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    //一键开门
    self.openLabel = [[UILabel alloc] init];
    self.openLabel.text = @"开锁历史";
    self.openLabel.font = [UIFont systemFontOfSize:18];
    self.openLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.openLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.openLabel];
    
    self.lastTime = @"最近还没开过锁哦";
    
    //开门历史
    self.openHistoryLabel = [[UILabel alloc] init];
    self.openHistoryLabel.text = [NSString stringWithFormat:@"上次开锁时间：%@", self.lastTime];
    self.openHistoryLabel.font = [UIFont systemFontOfSize:15];
    self.openHistoryLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.openHistoryLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.openHistoryLabel];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.contentView addSubview:self.bottomView];
    
}

-(void)layoutSubviews{
    [self.openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(12.5));
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(20)));
    }];
    
    [self.openHistoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-12.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(15)));
    }];
    
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
