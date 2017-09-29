//
//  ChooseLoginViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ChooseLoginViewController.h"
#import "Header.h"

@interface ChooseLoginViewController ()
@property(nonatomic, strong)UIImageView *backgroudImv;
@property(nonatomic, strong)UIButton *citizenBT;
@property(nonatomic, strong)UIButton *visitorBT;
@end

@implementation ChooseLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    //背景
    self.backgroudImv = [[UIImageView alloc] init];
    self.backgroudImv.frame = self.view.bounds;
    self.backgroudImv.image = [UIImage imageNamed:@"组-2"];
    [self.view addSubview:self.backgroudImv];
    
    //我是公民
    self.citizenBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.citizenBT setImage:[UIImage imageNamed:@"组-41"] forState:normal];
//    self.citizenBT.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.citizenBT];
    
    [self.citizenBT addTarget:self action:@selector(citizenAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.citizenBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-70));
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-60));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(90), SIZE_SCALE_IPHONE6(110)));
        
    }];
    
    //我是访客
    self.visitorBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.visitorBT setImage:[UIImage imageNamed:@"图层-0"] forState:normal];
//    self.visitorBT.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.visitorBT];
    
    [self.visitorBT addTarget:self action:@selector(visitorAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.visitorBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(70));
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-60));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(90), SIZE_SCALE_IPHONE6(110)));
        
    }];
}

//点击我是公民
-(void)citizenAction{
    LoginViewController * loginVC = [[LoginViewController alloc] init];
//    [self presentViewController:loginVC animated:YES completion:nil];
    
    [self.navigationController pushViewController:loginVC animated:YES];
}

//点击我是访客
-(void)visitorAction{
    
    VisitorLoginViewController * visitorVC = [[VisitorLoginViewController alloc] init];
    [self.navigationController pushViewController:visitorVC animated:YES];
    
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
