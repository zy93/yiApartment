//
//  ShowViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/20.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ShowViewController.h"
#import "Header.h"

@interface ShowViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UICollectionView * collectionView;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
}

//布局页面
-(void)setupViews {
    //个人动态tableView
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = self.view.frame;
    CGRect frame = self.tableView.frame;
    frame.origin.y = 220;
    self.tableView.frame = frame;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.hidden = YES;
    [self.tableView registerClass:[UITableViewCell  class] forCellReuseIdentifier:@"CELL_news"];
    [self.view addSubview:self.tableView];
    
    
    //照片collectionView
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.hidden = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [self.view addSubview:self.collectionView];
}

////敲门
//- (IBAction)knockClicked:(id)sender {
//    
//    KnockTalkViewController * knockTalkVC = [[KnockTalkViewController alloc] init];
//    [self.navigationController pushViewController:knockTalkVC animated:YES];
//    
//}


//个人动态
- (IBAction)PersonClicked:(id)sender {
    
    self.collectionView.hidden = YES;
    self.tableView.hidden = NO;
}

//相册
- (IBAction)photoClicked:(id)sender {
    self.collectionView.hidden = NO;
    self.tableView.hidden = YES;
}




- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_news" forIndexPath:indexPath];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}


//collectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
    
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
