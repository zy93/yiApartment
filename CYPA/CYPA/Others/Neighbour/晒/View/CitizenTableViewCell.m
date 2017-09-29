//
//  CitizenTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/7.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "CitizenTableViewCell.h"
#import "Header.h"

@interface CitizenTableViewCell ()

@end

@implementation CitizenTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    //头像
    _headImv = [[UIImageView alloc] init];
    _headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(22);
    _headImv.layer.masksToBounds = YES;
//    _headImv.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.headImv];
    
    //名字
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.text = @"测试";
    //    _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _nameLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_nameLabel];
    
    //性别
    _genderImv = [[UIImageView alloc] init];
//    _genderImv.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_genderImv];
    
    //地点
    _areaLabel = [[UILabel alloc] init];
    _areaLabel.font = [UIFont systemFontOfSize:13];
    _areaLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _areaLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_areaLabel];
    
    //发布内容
    _showContent = [[UILabel alloc] init];
    _showContent.font = [UIFont systemFontOfSize:13];
    _showContent.textColor = [UIColor colorWithHexString:@"666666"];
//    _showContent.backgroundColor = [UIColor grayColor];
//    _showContent.numberOfLines = 0;
    [self.contentView addSubview:_showContent];
    
    
}

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


-(void)layoutSubviews{
    [_headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(44), SIZE_SCALE_IPHONE6(44)));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImv.mas_top);
        make.left.mas_equalTo(self.headImv.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_genderImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_nameLabel.mas_centerY);
        make.left.mas_equalTo(_nameLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
    }];
    
    
    [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.nameLabel.mas_bottom);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    [_showContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(17));
        make.left.mas_equalTo(_headImv.mas_right).offset(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(_areaLabel.mas_right);
//        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(55));
        
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
