//
//  RootTabBarController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/15.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "RootTabBarController.h"
#import "Header.h"
#import "IntelligenceVC.h"
@interface RootTabBarController ()<UITabBarControllerDelegate>

@end

@implementation RootTabBarController

- (void)viewWillLayoutSubviews{
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = SIZE_SCALE_IPHONE6(45);
    tabFrame.origin.y = self.view.frame.size.height - SIZE_SCALE_IPHONE6(45);
    self.tabBar.frame = tabFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self creatTabBarView];
    
    


}

//导航栏
-(void)creatTabBarView {
    
    //首页
    IndexViewController *indexVC = [[IndexViewController alloc] init];
//    UINavigationController * indexNC = [[UINavigationController alloc] initWithRootViewController:indexVC];
    indexVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"组-9"] selectedImage:[UIImage imageNamed:@"组-9"]];
    indexVC.citizenModel = self.citizenModel;
    
    
    //我的
    PersonCenterViewController * myVC = [[PersonCenterViewController alloc] init];
//    UINavigationController *myNC = [[UINavigationController alloc] initWithRootViewController:myVC];
    myVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"12224"] selectedImage:[UIImage imageNamed:@"12224"]];
    
    //智能
    IntelligenceViewController * intelligentVC = [[IntelligenceViewController alloc] init];
//    UINavigationController * intelligentNC = [[UINavigationController alloc] initWithRootViewController:intelligentVC];
    intelligentVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"1223"] selectedImage:[UIImage imageNamed:@"1223"]];
    
//    //智能
//    IntelligenceVC * intelligentVC = [[IntelligenceVC alloc] init];
//    //    UINavigationController * intelligentNC = [[UINavigationController alloc] initWithRootViewController:intelligentVC];
//    intelligentVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"1223"] selectedImage:[UIImage imageNamed:@"1223"]];
    
    
    //link生活
    OutletsViewController * linkVC = [[OutletsViewController alloc] init];
//    UINavigationController * linkNC = [[UINavigationController alloc] initWithRootViewController:linkVC];
    linkVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"-11"] selectedImage:[UIImage imageNamed:@"-11"]];
    
    
    //左邻右舍
    NeighbourViewController * neighbourVC = [[NeighbourViewController alloc] init];
//    UINavigationController * neighbourNC = [[UINavigationController alloc] initWithRootViewController:neighbourVC];
    neighbourVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"00"] selectedImage:[UIImage imageNamed:@"00"]];
   
//    neighbourVC.citizenModel = self.citizenModel;
    
//    NSLog(@"%@", neighbourVC.citizenModel.UHeadPortrait);

    
//    self.viewControllers = @[neighbourNC, linkNC, indexNC,  intelligentNC, myNC];
    self.viewControllers = @[neighbourVC, linkVC, indexVC,  intelligentVC, myVC];

    self.selectedIndex = 2;
    
    // 矫正TabBar图片位置，使之垂直居中显示
    CGFloat offset = 5.0;
    for (UITabBarItem *item in self.tabBar.items) {
        item.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
    }
    //设置选中的颜色
    self.tabBar.tintColor = [UIColor colorWithHexString:@"fc4d01"];
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
