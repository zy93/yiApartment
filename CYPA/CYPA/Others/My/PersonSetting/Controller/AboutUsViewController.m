//
//  AboutUsViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/4/14.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "AboutUsViewController.h"
#import "Header.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController setTitle:@"关于我们"];
    [self setupViews];
}

-(void)setupViews {
    
    UILabel * label = [[UILabel alloc] init];
    label.text = @"北京青年乐有限公司";
    label.font = [UIFont systemFontOfSize:20.f];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    
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
