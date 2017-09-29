//
//  BaseTitleViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/19.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "Header.h"

@interface BaseTitleViewController ()

@end

@implementation BaseTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    //标题栏
    self.titleImv = [[UIImageView alloc] init];
    self.titleImv.image = [UIImage imageNamed:@"矩形-5-拷贝-2"];
    [self.view addSubview:self.titleImv];
    
    [self.titleImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        //        make.height.equalTo(weakSelf).offset(SIZE_SCALE_IPHONE6(87));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(43.5));
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
