//
//  PersonIntroduceCell.m
//  CYPA
//
//  Created by HDD on 16/7/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PersonIntroduceCell.h"
#import "Header.h"

@interface PersonIntroduceCell ()
@property(nonatomic, strong)UIImageView *titleImv;
@property(nonatomic, strong)UIImageView *backgroundImv;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *ageLabel;
@property (nonatomic,strong)UIImageView *genderImv;

@end

@implementation PersonIntroduceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
    
}

-(void)setupViews {
//    //标题栏
//    self.titleImv = [[UIImageView alloc] init];
//    self.titleImv.image = [UIImage imageNamed:@"矩形-5-拷贝-2"];
//    [self.contentView addSubview:self.titleImv];
//    
//    [self.titleImv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(20));
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        //        make.height.equalTo(weakSelf).offset(SIZE_SCALE_IPHONE6(87));
//        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(43.5));
//    }];
    
    //背景图
    self.backgroundImv = [[UIImageView alloc] init];
    //    self.backgroundImv.image = [UIImage imageNamed:@"组-4"];
    [self.contentView addSubview:self.backgroundImv];
    
    [self.backgroundImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    UIView * view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    view1.alpha = 0.8;
    [self.contentView addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(0));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(0));
        make.size.mas_equalTo(self.backgroundImv);
    }];
    
    //头像
    self.headImv = [[UIImageView alloc] init];
    //    self.headImv.image = [UIImage imageNamed:@"组-3"];
    self.headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(40);
    self.headImv.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImv];
    
    [self.headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backgroundImv).offset(SIZE_SCALE_IPHONE6(-30));
        make.centerX.equalTo(self.backgroundImv);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(80)));
    }];
    //姓名
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"往事随风";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImv).offset(SIZE_SCALE_IPHONE6(-10));
        make.top.equalTo(self.headImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //性别
    self.genderImv = [[UIImageView alloc] init];
    [self.contentView addSubview:self.genderImv];
    
    [self.genderImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.top.equalTo(self.nameLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
    }];
    
    
    
    //年龄+星座
    self.ageLabel = [[UILabel alloc] init];
    //    self.ageLabel.text = @"20岁 天蝎座";
    self.ageLabel.textAlignment = NSTextAlignmentCenter;
    self.ageLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.ageLabel];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImv);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(200), SIZE_SCALE_IPHONE6(25)));
    }];
    
    //敲门
    _knockBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _knockBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _knockBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _knockBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _knockBT.layer.masksToBounds = YES;
    [_knockBT setTitle:@"敲门" forState:(UIControlStateNormal)];
    [self.contentView addSubview:_knockBT];
    
    [_knockBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backgroundImv.mas_right).offset(SIZE_SCALE_IPHONE6(-17.5));
        make.bottom.mas_equalTo(self.backgroundImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(-27.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
}

-(void)setPersonModel:(UPerson *)personModel{
        //展示
    [self.backgroundImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,personModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    [self.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,personModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    self.nameLabel.text = personModel.UNickName;
    
    if([personModel.USex isEqualToString:@"00_011_2"]){
        self.genderImv.image = [UIImage imageNamed:@"964"];
    }else{
        self.genderImv.image = [UIImage imageNamed:@"963"];
    
    }
    self.ageLabel.text = [NSString stringWithFormat:@"%@ %@", personModel.UAge, personModel.UConstellation];
    
    if (personModel.UID == [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]) {
        self.knockBT.hidden = YES;
    }else {
        self.knockBT.hidden = NO;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
