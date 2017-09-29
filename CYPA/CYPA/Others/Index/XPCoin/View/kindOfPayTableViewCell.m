//
//  kindOfPayTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/15.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "kindOfPayTableViewCell.h"
#import "Header.h"
@implementation kindOfPayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    //缴费种类
    self.kindLabel = [[UILabel alloc] init];
    //    self.timeLabel.backgroundColor = [UIColor yellowColor];
    self.kindLabel.textColor = [UIColor colorWithHexString:@"999999"];
    self.kindLabel.font = [UIFont systemFontOfSize:15];
    self.kindLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.kindLabel];
    
    //花费
    self.costLabel = [[UILabel alloc] init];
    //    self.costLabel.backgroundColor = [UIColor orangeColor];
    self.costLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.costLabel.font = [UIFont systemFontOfSize:15];
    self.costLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.costLabel];
    
    //选择
    self.checkButton = [[HeadButton alloc] init];
    [self.checkButton setImage:[UIImage imageNamed:@"960"] forState:normal];
    [self.contentView addSubview:self.checkButton];

    
    
}

-(void)layoutSubviews {
    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [self.costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
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
