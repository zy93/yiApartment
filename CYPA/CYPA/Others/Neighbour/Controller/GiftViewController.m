//
//  GiftViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "GiftViewController.h"
#import "Header.h"

@interface GiftViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    
}

-(void)setupViews {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width-40, 250);
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 190) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[GiftCollectionViewCell class] forCellWithReuseIdentifier:@"CELL_gift"];
    [self.view addSubview:self.collectionView];
    
}

//back
- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//collectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GiftCollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CELL_gift" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    [cell.sendButton addTarget:self action:@selector(sendButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
    
}

//点击赠送
-(void)sendButtonAction:(UIButton *)sender {

    PayViewController * payVC = [[PayViewController alloc] init];
    [self.navigationController pushViewController:payVC animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
