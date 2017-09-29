//
//  LockRecordTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "LockRecordTableViewCell.h"
#import "Header.h"

@interface LockRecordTableViewCell ()

@end


@implementation LockRecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    //日期
    self.dataLabel = [[UILabel alloc] init];
    self.dataLabel.font = [UIFont systemFontOfSize:13];
    self.dataLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    self.openLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.dataLabel];
    
    
    //时间
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLabel];
    
    //房间
    self.roomLabel = [[UILabel alloc] init];
    self.roomLabel.font = [UIFont systemFontOfSize:13];
    self.roomLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.roomLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.roomLabel];
    

    
}

-(void)layoutSubviews{
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(50));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(90), SIZE_SCALE_IPHONE6(20)));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dataLabel.mas_top);
        make.left.mas_equalTo(self.dataLabel.mas_right).offset(SIZE_SCALE_IPHONE6(30));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    [self.roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dataLabel.mas_top);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-50));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
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
