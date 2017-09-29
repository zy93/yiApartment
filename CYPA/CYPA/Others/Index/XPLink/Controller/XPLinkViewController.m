//
//  XPLinkViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "XPLinkViewController.h"
#import "Header.h"
#import "ApiStoreSDK.h"
#import "BussnessPatenerModel.h"

@interface XPLinkViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property(nonatomic, strong)OrderView * myOrderView;
@property(nonatomic, strong)UITableView * tableView;

@property(nonatomic, strong)UIButton *businessBT;

@property(nonatomic, strong)NSMutableArray *middleArray;//中间数组
@property(nonatomic, strong)NSMutableArray *topArray;//上面轮播数组
@property(nonatomic, strong)UIScrollView *scrollView;



@end

@implementation XPLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViews];
    [self makeData];
    
//    [self afn];
    
}

-(void)makeData {
    
    self.topArray = [NSMutableArray array];
    self.middleArray = [NSMutableArray array];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:nil path:@"/supplier/listIndex" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
//                        NSLog(@"%@", dict);
            for (NSDictionary * dic in dict[@"data"]) {
                BussnessPatenerModel * model = [BussnessPatenerModel new];
                [model setValuesForKeysWithDictionary:dic];
                if ([model.ShowSite isEqualToString:@"1"]) {
                    //上部轮播
                    [self.topArray addObject:[NSString stringWithFormat:@"%@%@",BaseImageURL,model.Pic]];
                    
                }else if ([model.ShowSite isEqualToString:@"2"]){
                    //中间商家
                    [self.middleArray addObject:model];
                }else{
                    //分类商家
                }
                
            }
            if (self.topArray.count >= 3) {
                
                [self.myOrderView bindImageArray:self.topArray];
            }
            else if (self.topArray.count == 2) {
                NSMutableArray * array = [NSMutableArray arrayWithArray:self.topArray];
                [array addObject:self.topArray[0]];
                [self.myOrderView bindImageArray:array];
            }
            else if (self.topArray.count == 1){
                NSMutableArray * array = [NSMutableArray array];
                for (int i = 0; i < 3; i++) {
                    [array addObject:self.topArray[0]];
                }
                [self.myOrderView bindImageArray:array];
            }else{
                [self.myOrderView bindImageArray:nil];
            }
            //数据刷新
            [self.tableView reloadData];
            
        }else{
            //            [self showAlertWithString:@"获取数据失败"];
            NSLog(@"获取用户数据失败");
        }
    } failed:^{
        NSLog(@"获取用户数据失败");
        
    }];
    
    
}


-(void)setupViews {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(667));
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    _scrollView.delegate = self;
    
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(667))];;
    [_scrollView addSubview:contentView];
    
    //轮播图
//    NSArray *array = @[@"http://123.57.156.227:8088/odm/app/index/img/1.png",@"http://123.57.156.227:8088/odm/app/index/img/2.png", @"http://123.57.156.227:8088/odm/app/index/img/3.png"];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 10)];
    [self.view addSubview:view1];
    self.myOrderView = [[OrderView alloc] initWithFrame:CGRectMake(0, SIZE_SCALE_IPHONE6(63.5), SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(145))];
    //    self.myOrderView.backgroundColor = [UIColor cyanColor];
//    [self.myOrderView bindImageArray:array];
    [contentView addSubview:self.myOrderView];
    self.myOrderView.pc.frame = CGRectMake(0, CGRectGetHeight(self.myOrderView.frame)-10, SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(5));
    
    //tableView
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewStylePlain;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView setScrollEnabled:NO];
    
    [contentView addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myOrderView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    //商家入驻
    self.businessBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.businessBT setTitle:@"商家入驻" forState:(UIControlStateNormal)];
    self.businessBT.titleLabel.textAlignment = NSTextAlignmentRight;
    self.businessBT.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.businessBT];
    
    [self.businessBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_top);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(43.5)));
    }];
    
    [self.businessBT addTarget:self action:@selector(businessAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:self.backBT];
    
    
    //注册
    [self.tableView registerClass:[BusinessTableViewCell class] forCellReuseIdentifier:@"CELL_business"];
    [self.tableView registerClass:[KindTableViewCell class] forCellReuseIdentifier:@"CELL_kind"];
}

//点击商家入驻
-(void)businessAction {
    BusinessJoinViewController * businessVC = [[BusinessJoinViewController alloc] init];
    [self.navigationController pushViewController:businessVC animated:YES];
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
        BusinessTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_business" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataArray = self.middleArray;
        //刷新collectionview
        [cell.collectionView reloadData];
        
        cell.passId = ^(NSString * ID){
           
            BussinessWebViewController * webVC = [[BussinessWebViewController alloc] init];
            webVC.webAddress = ID;
            [self.navigationController pushViewController:webVC animated:YES];
            
        };

        return cell;
        
    }else {
        KindTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_kind" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.passId = ^(NSString * ID) {
            
            if ([ID isEqualToString:@"外卖"]) {
                LinkWebViewController * linkVC = [[LinkWebViewController alloc] init];
                linkVC.aUrl = @"http://waimai.baidu.com/waimai/shoplist/c63ab3051c9a6892";
                [self.navigationController pushViewController:linkVC animated:YES];
                
            } else {
                DatailViewController * datailVC = [[DatailViewController alloc] init];
                datailVC.id = ID;
                [self.navigationController pushViewController:datailVC animated:YES];
            }
            
        };
        
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE_SCALE_IPHONE6(5);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return SIZE_SCALE_IPHONE6(230);
    }else {
        return SIZE_SCALE_IPHONE6(226);
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
