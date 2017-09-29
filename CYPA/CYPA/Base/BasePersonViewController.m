//
//  BasePersonViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/15.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BasePersonViewController.h"
#import "Header.h"

@interface BasePersonViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;

@end

@implementation BasePersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //防止block的循环引用
//    __weak typeof(self) weakSelf = self;
    
//    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20)];
//    [self.view addSubview:_scrollView];
//    
//    _scrollView.contentSize = CGSizeMake(SIZE_SCALE_IPHONE6(0), SIZE_SCALE_IPHONE6(800));
//    _scrollView.backgroundColor = [UIColor whiteColor];
//    self.scrollView.delegate = self;
    
    //标题栏
    self.titleImv = [[UIImageView alloc] init];
    self.titleImv.image = [UIImage imageNamed:@"矩形-5-拷贝-2"];
    [self.view addSubview:self.titleImv];
    
    [self.titleImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(20));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
//        make.height.equalTo(weakSelf).offset(SIZE_SCALE_IPHONE6(87));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(43.5));
    }];
    
    //背景图
    self.backgroundImv = [[UIImageView alloc] init];
//    self.backgroundImv.image = [UIImage imageNamed:@"组-4"];
    [self.view addSubview:self.backgroundImv];
    
    [self.backgroundImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(187));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    UIView * view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    view1.alpha = 0.8;
    [self.backgroundImv addSubview:view1];
    
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
    [self.backgroundImv addSubview:self.headImv];
    
    [self.headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backgroundImv).offset(SIZE_SCALE_IPHONE6(-30));
        make.centerX.equalTo(self.backgroundImv);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(80)));
    }];
    //姓名
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"往事随风";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.backgroundImv addSubview:self.nameLabel];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImv).offset(SIZE_SCALE_IPHONE6(-10));
        make.top.equalTo(self.headImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //性别
    self.genderImv = [[UIImageView alloc] init];
    [self.backgroundImv addSubview:self.genderImv];
    
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
    [self.backgroundImv addSubview:self.ageLabel];
    
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImv);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(200), SIZE_SCALE_IPHONE6(25)));
    }];
    
    //返回
    self.backBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBT setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:normal];
    [self.view addSubview:self.backBT];
    
    [self.backBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleImv);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(43.5), SIZE_SCALE_IPHONE6(43.5)));

    }];
    
    [self.backBT addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //敲门
    _knockBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _knockBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _knockBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _knockBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _knockBT.layer.masksToBounds = YES;
    [_knockBT setTitle:@"敲门" forState:(UIControlStateNormal)];
    [self.view addSubview:_knockBT];
    
    [_knockBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backgroundImv.mas_right).offset(SIZE_SCALE_IPHONE6(-17.5));
        make.bottom.mas_equalTo(self.backgroundImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(-27.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
//    
//    [_knockBT addTarget:self action:@selector(knockAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

//返回
-(void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
