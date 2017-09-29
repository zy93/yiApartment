//
//  MyNewsTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/20.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MyNewsTableViewCell.h"
#import "Header.h"
@implementation MyNewsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    
    return self;
}

-(void)setupViews {
    
    self.hornImv = [[UIImageView alloc] init];
    self.hornImv.image = [UIImage imageNamed:@"iconfont-laba"];
    [self.contentView addSubview:_hornImv];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.contentView addSubview:self.contentLabel];

    self.expandButton = [UIButton buttonTitle:@"展开" setBackground:nil andImage:@"965" titleColor:[UIColor colorWithHexString:@"666666"] titleFont:14];
    
//    self.expandButton = [[HeadButton alloc] init];
//    [_expandButton setTitle:@"展开" forState:normal];
//    [_expandButton setImage:[UIImage imageNamed:@"965"] forState:normal];
//    [_expandButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.expandButton.tag = 0;
    [self.contentView addSubview:self.expandButton];
    
}

-(void)layoutSubviews{
    [self.hornImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(16));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
    }];
    
    [self.expandButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(20)));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hornImv.mas_right).offset(SIZE_SCALE_IPHONE6(15));
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(5));
//        make.bottom.mas_equalTo(self.expandButton.mas_top).offset(-5);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
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
