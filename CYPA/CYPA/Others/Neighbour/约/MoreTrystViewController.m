//
//  MoreTrystViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/10.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MoreTrystViewController.h"
#import "Header.h"
@interface MoreTrystViewController ()<UITableViewDataSource, UITableViewDelegate>

//@property(nonatomic, strong)UIButton * newTrystBT;
@property(nonatomic, strong)UIButton * lastTrystBT1;
@property(nonatomic, strong)UIButton * oldTrystBT;
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)UILabel * oldLabel;
@property(nonatomic, strong)UILabel * lastLabel;

@property(nonatomic, strong)NSMutableArray * dataArray;
@property(nonatomic, strong)NSMutableArray * lastTrystArray;
@property(nonatomic, strong)NSMutableArray * oldTrystArray;


@end

@implementation MoreTrystViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self makeData];
    self.dataArray = self.lastTrystArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    

}

-(void)makeData {

    self.dataArray = [NSMutableArray array];
    self.lastTrystArray = [NSMutableArray array];
    self.oldTrystArray = [NSMutableArray array];
    
    //所有邻居动态列表信息
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"0" forKey:@"type"];
    [dic setValue:@"0" forKey:@"PageIndex"];
    [dic setValue:@"10" forKey:@"PageNum"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dic path:@"/group/getList" success:^(NSMutableDictionary * dict) {
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                TrystModel * newModel = [TrystModel new];
                [newModel setValuesForKeysWithDictionary:dic];
                [self.lastTrystArray addObject:newModel];
            }
//            NSLog(@"%@",self.lastTrystArray);
            
        }else {
            [self showAlertWithString:dict[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } failed:^{
        [self showAlertWithString:@"数据加载出错"];
    }];
    
    
    NSMutableDictionary * dic1 = [NSMutableDictionary dictionary];
    [dic1 setValue:@"1" forKey:@"type"];
    [dic setValue:@"1" forKey:@"PageIndex"];
    [dic setValue:@"5" forKey:@"PageNum"];
    
    //所有公民动态列表信息
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dic1 path:@"/group/getList" success:^(NSMutableDictionary * dict) {
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                TrystModel * oldModel = [TrystModel new];
                [oldModel setValuesForKeysWithDictionary:dic];
                [self.oldTrystArray addObject:oldModel];
            }
//            NSLog(@"%@",self.oldTrystArray);
            
        }else {
            [self showAlertWithString:dict[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } failed:^{
        [self showAlertWithString:@"数据加载出错"];
    }];
    
    
}

-(void)setupViews {
    //上部View
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(47));
    }];
    
    //最新活动
    self.lastTrystBT1 = [BottomButton buttonWithType:(UIButtonTypeCustom)];
    [self.lastTrystBT1 setBackgroundImage:[UIImage imageNamed:@"975"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.lastTrystBT1];
    
    [self.lastTrystBT1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.right.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(90), SIZE_SCALE_IPHONE6(26)));
    }];
    _lastLabel = [[UILabel alloc] init];
    _lastLabel.text = @"最新活动";
    _lastLabel.textColor = [UIColor whiteColor];
    _lastLabel.font = [UIFont systemFontOfSize:15];
    _lastLabel.textAlignment = NSTextAlignmentCenter;
    [self.lastTrystBT1 addSubview:_lastLabel];
    
    [_lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.lastTrystBT1);
        make.size.mas_equalTo(self.lastTrystBT1);
    }];
    
    [self.lastTrystBT1 addTarget:self action:@selector(newTrystAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //以往活动
    self.oldTrystBT = [BottomButton buttonWithType:(UIButtonTypeCustom)];
    [self.oldTrystBT setBackgroundImage:[UIImage imageNamed:@"977"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.oldTrystBT];
    [self.oldTrystBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.left.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(90), SIZE_SCALE_IPHONE6(26)));
    }];
    
    _oldLabel = [[UILabel alloc] init];
    _oldLabel.text = @"以往活动";
    _oldLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    _oldLabel.font = [UIFont systemFontOfSize:15];
    _oldLabel.textAlignment = NSTextAlignmentCenter;
    [self.oldTrystBT addSubview:_oldLabel];
    [_oldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.oldTrystBT);
        make.size.mas_equalTo(self.oldTrystBT);
    }];
    
    [self.oldTrystBT addTarget:self action:@selector(oldTrystAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[MoreTrystTableViewCell class] forCellReuseIdentifier:@"CELL_tryst"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    
    
    
    
}


-(void)oldTrystAction {
    [self.oldTrystBT setBackgroundImage:[UIImage imageNamed:@"976"] forState:(UIControlStateNormal)];
    self.oldLabel.textColor = [UIColor whiteColor];
    [self.lastTrystBT1 setBackgroundImage:[UIImage imageNamed:@"978"] forState:(UIControlStateNormal)];
    self.lastLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    //换数组
    self.dataArray = self.oldTrystArray;
    [self.tableView reloadData];
//    NSLog(@"%@",self.dataArray);
    
}

-(void)newTrystAction {
    [self.lastTrystBT1 setBackgroundImage:[UIImage imageNamed:@"975"] forState:(UIControlStateNormal)];
    self.lastLabel.textColor = [UIColor whiteColor];
    [self.oldTrystBT setBackgroundImage:[UIImage imageNamed:@"977"] forState:(UIControlStateNormal)];
    self.oldLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    //换数组
    self.dataArray = self.lastTrystArray;
    [self.tableView reloadData];
//    NSLog(@"%@",self.dataArray);
}


//tableView  delegate datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreTrystTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_tryst" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    TrystModel * model = self.dataArray[indexPath.section];
    
//    NSLog(@"%@",model.beginDate);
    
    NSArray * array = [model.picID componentsSeparatedByString:@";"];
    [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL, array[0]]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    cell.activeLabel.text = model.Name;
    cell.placeLabel.text = model.Area;
    cell.timeLabel.text = model.beginDate;
    cell.numLabel.text = [NSString stringWithFormat:@"参加人数：%d",model.PersonNum];
    cell.introLabel.text = [NSString stringWithFormat:@"活动介绍：%@",model.Intro];
//    [cell.introLabel sizeToFit];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(175);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE_SCALE_IPHONE6(5);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     TrystModel * model = self.dataArray[indexPath.section];
    
    ActivityDetailViewController * activityVC = [[ActivityDetailViewController alloc] init];
    activityVC.GroupID = model.GroupID;
    
    [self.navigationController pushViewController:activityVC animated:YES];
    
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
