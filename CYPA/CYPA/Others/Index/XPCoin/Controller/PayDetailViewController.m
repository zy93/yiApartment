//
//  PayDetailViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/16.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PayDetailViewController.h"
#import "Header.h"
@interface PayDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSMutableArray * kindArray;

@property(nonatomic, strong)UILabel * totalLabel;
@property(nonatomic, assign)int totalAmount; //总费用


@end

@implementation PayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self makeData];

    [self setupViews];

}

-(void)makeData {
    
    self.kindArray = [NSMutableArray array];
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:self.BusinessFlow forKey:@"BusinessFlow"];
//        NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/rmb/detailBusiness" success:^(NSMutableDictionary * dict) {
        
//                        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            for (NSDictionary * dic in dict[@"data"]) {
                CheckModel * model = [CheckModel new];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.kindArray addObject:model];
                
                self.totalAmount += [model.Amount intValue];
            }
            
            self.totalLabel.text = [NSString stringWithFormat:@"总费用:%d", self.totalAmount];
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"获取信息失败");
    }];

    
}

-(void)setupViews {
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[kindOfPayTableViewCell class] forCellReuseIdentifier:@"CELL_pay"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(0));
    }];
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, self.view.frame.size.width, SIZE_SCALE_IPHONE6(660));
    
    self.tableView.tableFooterView = bottomView;
    
    //总费用
    self.totalLabel = [[UILabel alloc] init];
    self.totalLabel.text = @"总费用： 0";
    [bottomView addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    NSLog(@"%ld",self.kindArray.count);
    return self.kindArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CheckModel * model = self.kindArray[indexPath.row];
    
    kindOfPayTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_pay" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.kindLabel.text = model.FeeItem;
    cell.costLabel.text = [NSString stringWithFormat:@"费用：%@元", model.Amount];
    
    cell.checkButton.hidden = YES;
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(50);
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
