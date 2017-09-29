//
//  AnnouncementViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "AnnouncementViewController.h"
#import "Header.h"
#import "MJRefresh.h"
#import "MJRefreshHeaderView.h"
@interface AnnouncementViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation AnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeData];
    [self setupViews];
    
}

-(void)makeData {
    
    self.dataArray = [NSMutableArray array];
    
    NSMutableDictionary * dictory = [[NSMutableDictionary alloc] init];
//    dictory setValue:<#(nullable id)#> forKey:@"Time"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/msg/listSysMsg" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
//            NSLog(@"%@", dict);
            for (NSDictionary * dic in dict[@"data"]) {
                NewsModel * model = [NewsModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            //数据刷新
            [self.tableView reloadData];
        }else{
            [self showAlertWithString:@"获取数据失败"];
        }
    } failed:^{
        [self showAlertWithString:@"获取数据失败"];
        
    }];
    
}

-(void)setupViews {
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.estimatedRowHeight = 100;
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerClass:[MyNewsTableViewCell class] forCellReuseIdentifier:@"CELL_news"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
}

//下拉刷新
-(void)headerRereshing{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    });
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel * model = [NewsModel new];
    model = self.dataArray[indexPath.section];
    
    MyNewsTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_news" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentLabel.text = model.Content;
    
    cell.expandButton.hidden = YES;
    
//    CGSize titleSize = [model.Content boundingRectWithSize:CGSizeMake(SIZE_SCALE_IPHONE6(315), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
//    if (titleSize.height > 40) {
//        cell.expandButton.hidden = NO;
//        
////        cell.expandButton.tag = 1;
//    } else {
//        cell.expandButton.hidden = YES;
////        cell.expandButton.tag = 0;
//    }
//    
//    [cell.expandButton addTarget:self action:@selector(expandAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
    
}

-(void)expandAction:(UIButton *)sender {
    NSLog(@"***%ld", sender.tag);
    if (sender.tag == 0) {
        sender.tag = 1;
        [sender setTitle:@"展开" forState:normal];

    } else {
        sender.tag = 0;
        [sender setTitle:@"收起" forState:normal];
    }
    [self.tableView reloadData];
    
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//     MyNewsTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"*******%ld", cell.expandButton.tag);
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyNewsTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"(((((((%ld", cell.expandButton.tag);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NewsModel * model = [NewsModel new];
    model = self.dataArray[indexPath.section];
    
    CGSize titleSize = [model.Content boundingRectWithSize:CGSizeMake(SIZE_SCALE_IPHONE6(315), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return titleSize.height + 30;
    
//    self.tableView.delegate = nil;
//    MyNewsTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
//
////    NSLog(@"+++++++%ld",cell.expandButton.tag);
//    self.tableView.delegate = self;
//
//    CGSize titleSize = [model.Content boundingRectWithSize:CGSizeMake(SIZE_SCALE_IPHONE6(315), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
//
//    NSLog(@"%f", titleSize.height);
    
//    NSLog(@"%ld", cell.expandButton.tag);
//    if ([[NSString stringWithFormat:@"%ld", cell.expandButton.tag] isEqualToString:@"1"]) {
//        
//        return titleSize.height + 30;
//    } else {
//        return 70;
//    }



//    //判断是否展开
//    if (titleSize.height > 40) {
//        NSLog(@"%ld", cell.expandButton.tag);
//        if ([[NSString stringWithFormat:@"%ld", cell.expandButton.tag] isEqualToString:@"1"]) {
//            
//            return titleSize.height + 30;
//        } else {
//            return 70;
//        }
//    }else{
//        return titleSize.height + 30;
//    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE_SCALE_IPHONE6(5);
}



@end
