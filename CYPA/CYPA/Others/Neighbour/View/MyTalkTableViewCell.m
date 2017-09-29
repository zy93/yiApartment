//
//  MyTalkTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MyTalkTableViewCell.h"
#import "Header.h"
@implementation MyTalkTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    //点击头像区域的button
    _headBT = [[HeadButton alloc] init];
    //    _headBT.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.headBT];
    
    //头像
    _headImv = [[UIImageView alloc] init];
    _headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(15);
    _headImv.layer.masksToBounds = YES;
    //    _headImv.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.headImv];
    
    //名字
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    _nameLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_nameLabel];
    
    
    //性别
    _genderImv = [[UIImageView alloc] init];
    //    _genderImv.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_genderImv];
    
    //发布时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    //    _timeLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    
    //发布内容
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    //    _contentLabel.backgroundColor = [UIColor grayColor];
    _contentLabel.numberOfLines = 3;
    [self.contentView addSubview:_contentLabel];
    
    
}

-(void)layoutSubviews{
    [_headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(30), SIZE_SCALE_IPHONE6(30)));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headImv.mas_centerY);
        make.right.mas_equalTo(self.headImv.mas_left).offset(SIZE_SCALE_IPHONE6(-10));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_genderImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_top);
        make.right.mas_equalTo(_nameLabel.mas_left).offset(SIZE_SCALE_IPHONE6(-5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
    }];
    
    [_headBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImv.mas_top);
        make.right.mas_equalTo(_headImv.mas_right);
        make.size.mas_equalTo(_headImv);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImv.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.right.mas_equalTo(self.nameLabel.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        //        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
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
