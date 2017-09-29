//
//  MoreNeighbourViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/4.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MoreNeighbourViewController.h"
#import "Header.h"

@interface MoreNeighbourViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UIButton * neighbourBT;
@property(nonatomic, strong)UIButton * citizenBT;
@property(nonatomic, strong)UILabel * neighbourLabel;
@property(nonatomic, strong)UILabel * citizenLabel;

@property(nonatomic, strong)UITableView * tableView;

@property(nonatomic, strong)NSMutableArray * dataArray;
@property(nonatomic, strong)NSMutableArray * newestDataArray;
@property(nonatomic, strong)NSMutableArray * hotestDataArray;


@end

@implementation MoreNeighbourViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self makeData];
    
    if (self.dataArray.count == 0) {
        self.dataArray = self.newestDataArray;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    self.dataArray = [NSMutableArray array];


}

-(void)makeData {
    self.newestDataArray = [NSMutableArray array];
    self.hotestDataArray = [NSMutableArray array];
    
    //最新公民列表信息
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"0" forKey:@"Type"];
    [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dic setValue:@"100" forKey:@"PageNum"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dic path:@"/friend/getList" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                UPerson * newestModel = [UPerson new];
                [newestModel setValuesForKeysWithDictionary:dic];
                [self.newestDataArray addObject:newestModel];
            }
//            NSLog(@"%@",self.newestDataArray);
            
        }else {
            [self showAlertWithString:dict[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } failed:^{
        [self showAlertWithString:@"数据加载出错"];
    }];
    
    NSMutableDictionary * dic1 = [NSMutableDictionary dictionary];
    [dic1 setValue:@"1" forKey:@"Type"];
    [dic1 setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dic1 setValue:@"100" forKey:@"PageNum"];
    
    //最热公民列表信息
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dic1 path:@"/friend/getList" success:^(NSMutableDictionary * dict) {
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                UPerson * hotestModel = [UPerson new];
                [hotestModel setValuesForKeysWithDictionary:dic];
                [self.hotestDataArray addObject:hotestModel];
            }
//            NSLog(@"%@",self.hotestDataArray);
            
        }else {
            [self showAlertWithString:dict[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } failed:^{
        [self showAlertWithString:@"数据加载出错"];
    }];

    
}


-(void)setupViews{
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
    
    //所有邻居
    self.neighbourBT = [BottomButton buttonWithType:(UIButtonTypeCustom)];
    [self.neighbourBT setBackgroundImage:[UIImage imageNamed:@"975"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.neighbourBT];
    
    [self.neighbourBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.right.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(90), SIZE_SCALE_IPHONE6(26)));
    }];
    self.neighbourLabel = [[UILabel alloc] init];
    self.neighbourLabel.text = @"最新邻居";
    self.neighbourLabel.textColor = [UIColor whiteColor];
    self.neighbourLabel.font = [UIFont systemFontOfSize:15];
    self.neighbourLabel.textAlignment = NSTextAlignmentCenter;
    [self.neighbourBT addSubview:_neighbourLabel];
    
    [self.neighbourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.neighbourBT);
        make.size.mas_equalTo(self.neighbourBT);
    }];
    
    [self.neighbourBT addTarget:self action:@selector(allNeighbour) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //所有公民
    self.citizenBT = [BottomButton buttonWithType:(UIButtonTypeCustom)];
    [self.citizenBT setBackgroundImage:[UIImage imageNamed:@"977"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.citizenBT];
    [self.citizenBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView.mas_centerY);
        make.left.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(90), SIZE_SCALE_IPHONE6(26)));
    }];
    
    self.citizenLabel = [[UILabel alloc] init];
    self.citizenLabel.text = @"最热邻居";
    self.citizenLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    self.citizenLabel.font = [UIFont systemFontOfSize:15];
    self.citizenLabel.textAlignment = NSTextAlignmentCenter;
    [self.citizenBT addSubview:_citizenLabel];
    [self.citizenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.citizenBT);
        make.size.mas_equalTo(self.citizenBT);
    }];
    
    [self.citizenBT addTarget:self action:@selector(allCitizen) forControlEvents:(UIControlEventTouchUpInside)];

    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[NeighbourTableViewCell class] forCellReuseIdentifier:@"CELL_neighbour"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}

//tableView  delegate datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NeighbourTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_neighbour" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UPerson * model = self.dataArray[indexPath.section];
    [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,model.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    cell.nameLabel.text = model.UNickName;
    cell.ageLabel.text = model.UAge;
    cell.constellationLabel.text = model.UConstellation;
    cell.areaLabel.text = model.Area;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(90);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE_SCALE_IPHONE6(5);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonShowViewController * personVC = [[PersonShowViewController alloc] init];
    UPerson * model = self.dataArray[indexPath.section];
    personVC.UID = model.UID;
    
    [self.navigationController pushViewController:personVC animated:YES];
    
}


-(void)allNeighbour {
    
    [self.neighbourBT setBackgroundImage:[UIImage imageNamed:@"975"] forState:(UIControlStateNormal)];
    self.neighbourLabel.textColor = [UIColor whiteColor];
    [self.citizenBT setBackgroundImage:[UIImage imageNamed:@"977"] forState:(UIControlStateNormal)];
    self.citizenLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    
    
    //换数组
    self.dataArray = self.newestDataArray;
    [self.tableView reloadData];
//    NSLog(@"%@",self.dataArray);

    
}

-(void)allCitizen {
    
    [self.citizenBT setBackgroundImage:[UIImage imageNamed:@"976"] forState:(UIControlStateNormal)];
    self.citizenLabel.textColor = [UIColor whiteColor];
    [self.neighbourBT setBackgroundImage:[UIImage imageNamed:@"978"] forState:(UIControlStateNormal)];
    self.neighbourLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    
    
    //换数组
    self.dataArray = self.hotestDataArray;
    [self.tableView reloadData];
    
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
