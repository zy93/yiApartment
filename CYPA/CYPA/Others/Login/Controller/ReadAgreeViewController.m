//
//  ReadAgreeViewController.m
//  CYPA
//
//  Created by HDD on 2016/10/17.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ReadAgreeViewController.h"
#import "TopLabel.h"
#import "Header.h"

@interface ReadAgreeViewController ()

@end

@implementation ReadAgreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    
    TopLabel * label = [[TopLabel alloc] init];
    label.numberOfLines = 0;
    label.text = @"    哈哈哈,这是测试数据 啊,小郭同学赶紧的把服务协议给我啊";
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
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
