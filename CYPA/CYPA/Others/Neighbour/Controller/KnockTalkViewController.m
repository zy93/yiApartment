//
//  KnockTalkViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "KnockTalkViewController.h"
#import "Header.h"
@interface KnockTalkViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation KnockTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self setupViews];
    
}

//布局页面
-(void)setupViews {
    //个人动态tableView
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = self.view.frame;
    CGRect frame = self.tableView.frame;
    frame.origin.y = 80;
    frame.size.height = self.view.frame.size.height - 300;
    self.tableView.frame = frame;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.hidden = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyTalkTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL_mytalk"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OthersTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL_othertalk"];
    [self.view addSubview:self.tableView];
    
}

//back
- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//点击送礼
- (IBAction)giftClicked:(id)sender {
    
    GiftViewController * giftVC = [[GiftViewController alloc] init];
    [self.navigationController pushViewController:giftVC animated:YES];
}

//点击发送
- (IBAction)sendClicked:(id)sender {
    
    
    
}



//tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 == 0) {
        MyTalkTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_mytalk" forIndexPath:indexPath];
        return cell;
    } else {
        OthersTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_othertalk" forIndexPath:indexPath];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
