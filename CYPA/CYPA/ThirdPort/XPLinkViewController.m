//
//  XPLinkViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "XPLinkViewController.h"
#import "Header.h"

@interface XPLinkViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)OrderView * myOrderView;
@property(nonatomic, strong)UITableView * tableView;
@end

@implementation XPLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //轮播图
    NSArray *array = @[@"92017921af137874-a",@"92038578a351f299-d", @"92119203344f77fa-c"];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 10)];
    [self.view addSubview:view1];
    self.myOrderView = [[OrderView alloc] initWithFrame:CGRectMake(0, SIZE_SCALE_IPHONE6(63.5), SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(150))];
    //    self.myOrderView.backgroundColor = [UIColor cyanColor];
    [self.myOrderView bindImageArray:array];
    [self.view addSubview:self.myOrderView];
    self.myOrderView.pc.frame = CGRectMake(0, CGRectGetHeight(self.myOrderView.frame)-10, SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(5));

    //tableView
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewStylePlain;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myOrderView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        
    }];
    

    
}

#pragma mark tableView delegate datasourse
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else {
        
    }
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
