//
//  PersonShowTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/9.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PersonShowTableViewCell.h"
#import "Header.h"

@implementation PersonShowTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    } 
    return self;
}

-(void)setupViews{

    //发布时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _timeLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    
    //发布内容
    _showContent = [[TopLabel alloc] init];
    _showContent.font = [UIFont systemFontOfSize:13];
    _showContent.textColor = [UIColor colorWithHexString:@"333333"];
    _showContent.textAlignment = NSTextAlignmentLeft;
//    _showContent.backgroundColor = [UIColor grayColor];
    _showContent.numberOfLines = 0;
    [self.contentView addSubview:_showContent];


    
}

-(void)layoutSubviews{
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(13.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
//        make.width.mas_equalTo(80);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        
    }];
    
    [_showContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_timeLabel.mas_bottom);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(92.5));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        //        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(55));
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-90));
        
    }];

    
    
}

//加载照片
- (void)setCellImageWithArray:(NSArray *)array
{
    
    for(UIView *Imv in [self subviews])
    {
        if ([Imv isKindOfClass:[UIImageView class]]) {
            [Imv removeFromSuperview];
        }
    }
    
    if (array.count < 3) {
        for (int i = 0; i < array.count; i++) {
            UIImageView * picImv = [[UIImageView alloc] init];
            [picImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,array[i]]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
            picImv.backgroundColor = [UIColor cyanColor];
            [self addSubview:picImv];
            
            [picImv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-10));
                make.left.mas_equalTo(SIZE_SCALE_IPHONE6(92.5)+SIZE_SCALE_IPHONE6(90*i));
                make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(72.5), SIZE_SCALE_IPHONE6(72.5)));
            }];
        }

    }else{
    
    for (int i = 0; i < 3; i++) {
        UIImageView * picImv = [[UIImageView alloc] init];
        [picImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,array[i]]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        picImv.backgroundColor = [UIColor cyanColor];
        [self addSubview:picImv];
        
        [picImv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-10));
            make.left.mas_equalTo(SIZE_SCALE_IPHONE6(92.5)+SIZE_SCALE_IPHONE6(90*i));
            make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(72.5), SIZE_SCALE_IPHONE6(72.5)));
        }];
    }
    }
}

//字体高度
- (void)cellAutoLayoutHeight:(NSString *)str{
    
    self.showContent.lineBreakMode = NSLineBreakByWordWrapping;
    self.showContent.preferredMaxLayoutWidth = CGRectGetWidth(self.showContent.frame);
    self.showContent.text = str;
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
