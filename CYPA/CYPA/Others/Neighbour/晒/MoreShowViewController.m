//
//  MoreShowViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/7.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MoreShowViewController.h"
#import "Header.h"

@interface MoreShowViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UIButton * neighbourBT;
@property(nonatomic, strong)UIButton * citizenBT;
@property(nonatomic, strong)UILabel * neighbourLabel;
@property(nonatomic, strong)UILabel * citizenLabel;

@property(nonatomic, strong)UITableView * tableView;

@property(nonatomic, strong)NSMutableArray * dataArray;
@property(nonatomic, strong)NSMutableArray * neighbourDataArray;
@property(nonatomic, strong)NSMutableArray * citizenDataArray;


@end

@implementation MoreShowViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self makeData];
    
    if (self.dataArray.count == 0) {
        self.dataArray = self.neighbourDataArray;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    

    
}

-(void)makeData {
    self.dataArray = [NSMutableArray array];
    self.neighbourDataArray = [NSMutableArray array];
    self.citizenDataArray = [NSMutableArray array];
    
    NSMutableDictionary * dictory1 = [[NSMutableDictionary alloc] init];
    [dictory1 setValue:@"1" forKey:@"ApartmentID"];

    //所有邻居动态列表信息
    [[GXNetWorkManager shareInstance] getInfoWithInfo: dictory1 path:@"/user/getNeighborShowList" success:^(NSMutableDictionary * dict) {
        
//        NSLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                UPerson * neighbourModel = [UPerson new];
                [neighbourModel setValuesForKeysWithDictionary:dic];
                [self.neighbourDataArray addObject:neighbourModel];
                
//                NSLog(@"%@", neighbourModel.UShowPic);

            }
//            NSLog(@"%@",self.neighbourDataArray);
            
        }else {
            [self showAlertWithString:dict[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } failed:^{
        [self showAlertWithString:@"数据加载出错"];
    }];
    
    //所有公民动态列表信息
    [[GXNetWorkManager shareInstance] getInfoWithInfo:nil path:@"/user/getShowList" success:^(NSMutableDictionary * dict) {
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                UPerson * citizenModel = [UPerson new];
                [citizenModel setValuesForKeysWithDictionary:dic];
                [self.citizenDataArray addObject:citizenModel];
            }
//            NSLog(@"%@",self.citizenDataArray);
            
        }else {
            
            
//            [self showAlertWithString:dict[@"message"]];
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
    self.neighbourLabel.text = @"所有邻居";
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
    self.citizenLabel.text = @"所有公民";
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
    
    [self.tableView registerClass:[CitizenTableViewCell class] forCellReuseIdentifier:@"CELL_citizen"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}

-(void)allCitizen {
    [self.citizenBT setBackgroundImage:[UIImage imageNamed:@"976"] forState:(UIControlStateNormal)];
    self.citizenLabel.textColor = [UIColor whiteColor];
    [self.neighbourBT setBackgroundImage:[UIImage imageNamed:@"978"] forState:(UIControlStateNormal)];
    self.neighbourLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    //换数组
    self.dataArray = self.citizenDataArray;
    [self.tableView reloadData];
//    NSLog(@"%@",self.dataArray);
    
}

-(void)allNeighbour {
    [self.neighbourBT setBackgroundImage:[UIImage imageNamed:@"975"] forState:(UIControlStateNormal)];
    self.neighbourLabel.textColor = [UIColor whiteColor];
    [self.citizenBT setBackgroundImage:[UIImage imageNamed:@"977"] forState:(UIControlStateNormal)];
    self.citizenLabel.textColor = [UIColor colorWithHexString:kButtonBGColor];
    //换数组
    self.dataArray = self.neighbourDataArray;
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
    
     CitizenTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_citizen" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UPerson * model = self.dataArray[indexPath.section];
    [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,model.UHeadPortrait]]];
    cell.nameLabel.text = model.UNickName;
    cell.showContent.text = model.ShowCont;
    
    NSArray * array = [model.ShowPic componentsSeparatedByString:@";"];
//    NSLog(@"%@", array);
    [cell setCellImageWithArray:array];
    
    cell.areaLabel.text = model.Area;
    
    if([model.USex isEqualToString:@"00_011_2"]){
        cell.genderImv.image = [UIImage imageNamed:@"964"];
    }else{
        cell.genderImv.image = [UIImage imageNamed:@"963"];
        
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(201);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE_SCALE_IPHONE6(5);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UPerson * model = self.dataArray[indexPath.section];
    
    ShowDetailViewController * showVC = [[ShowDetailViewController alloc] init];
    showVC.personModel = model;
    
    [self.navigationController pushViewController:showVC animated:YES];
    
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
