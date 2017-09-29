//
//  PayHistoryTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/3.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PayHistoryTableViewCell.h"
#import "Header.h"

@interface PayHistoryTableViewCell ()
@property(nonatomic, strong)UIView * topView;
@property(nonatomic, strong)UIView * bottomView;

@end

@implementation PayHistoryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    //上横线
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.contentView addSubview:self.topView];
    
    //下横线
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.contentView addSubview:self.bottomView];
    
    
    //时间
    self.timeLabel = [[UILabel alloc] init];
//    self.timeLabel.backgroundColor = [UIColor yellowColor];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
    self.timeLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLabel];
    
    //花费
    self.costLabel = [[UILabel alloc] init];
//    self.costLabel.backgroundColor = [UIColor orangeColor];
    self.costLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.costLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    self.costLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.costLabel];

    
}

-(void)layoutSubviews {
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(17.5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [self.costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(0.5));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(0.5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(0.5));
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
