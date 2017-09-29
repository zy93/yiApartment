//
//  LockHistoryViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "LockHistoryViewController.h"
#import "Header.h"
#import "LockHistoryModel.h"
#import "MJRefresh.h"

@interface LockHistoryViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSMutableArray *historyArray;

@property(nonatomic, assign)NSInteger pageNum; //页码

@end

@implementation LockHistoryViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
        
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.historyArray = [NSMutableArray array];

    [self makeData];
    //初始页码为0
    self.pageNum = 0;
    
    self.tableView = [[UITableView alloc] init];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    self.tableView.separatorStyle = UITableViewStylePlain;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //下拉刷新
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(0));
        
    }];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    [self.tableView registerClass:[LockHistoryTableViewCell class] forCellReuseIdentifier:@"CELL_history"];
    [self.tableView registerClass:[LockRecordTableViewCell class] forCellReuseIdentifier:@"CELL_record"];


}

-(void)makeData {
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    [params setValue:@(self.pageNum) forKey:@"PageNum"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:params path:@"/unlock_door/history" success:^(NSMutableDictionary *dic) {
        
        for (NSDictionary * dict in dic[@"data"]) {
            LockHistoryModel * model = [LockHistoryModel new];
            [model setValuesForKeysWithDictionary:dict];
            [self.historyArray addObject:model];
        }
        
        [self.tableView reloadData];
        
    } failed:^{
        [self showAlertWithString:@"获取历史记录失败"];
    }];
}

//下拉刷新
-(void)headerRereshing{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    });
    
}


-(void)loadMoreData {
    self.pageNum ++;
    
    
    
    [self makeData];
    
    
}

#pragma tableView delegate dataSourse
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else {
        return self.historyArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        LockHistoryTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_history" forIndexPath:indexPath];
        if (self.historyArray.count != 0) {
            LockHistoryModel * model = self.historyArray[0];
            cell.openHistoryLabel.text = [NSString stringWithFormat:@"上次开锁时间:%@", model.CreateTime];
        }else{
           cell.openHistoryLabel.text = @"上次开锁时间:最近没有开过锁哦";
        }
       
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        LockRecordTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_record" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        LockHistoryModel * model = [LockHistoryModel new];
        model = self.historyArray[indexPath.row];
        
        NSString * dataString = [model.CreateTime substringToIndex:10];
        NSString * timeString = [model.CreateTime substringFromIndex:10];
        
        cell.dataLabel.text = dataString;
        cell.timeLabel.text = timeString;
        cell.roomLabel.text = [NSString stringWithFormat:@"%@", model.DoorName];
        return cell;

    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return SIZE_SCALE_IPHONE6(72);
    }else {
        return SIZE_SCALE_IPHONE6(45);
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
