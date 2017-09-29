//
//  MyShowViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/17.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MyShowViewController.h"
#import "Header.h"

@interface MyShowViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView * tableView;
//个人动态展示数组
@property(nonatomic, strong)NSMutableArray * personShowDataArray;
@property(nonatomic, strong)UPerson * pModel;

@end

@implementation MyShowViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self makeData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViews];

}

-(void)makeData {
    
    self.personShowDataArray = [NSMutableArray array];
    
    //   UID: self.personModel.UID
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/getUserShow" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"][@"Show"]) {
                UPerson * showModel = [UPerson new];
                [showModel setValuesForKeysWithDictionary:dic];
                [self.personShowDataArray addObject:showModel];
            }
            
        }else{
            NSLog(@"加载出错");
            [self showAlertWithString:dict[@"message"]];
        }
        //刷新UI
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"加载数据出错");
    }];
    
}



-(void)setupViews{
    
    //个人动态
    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[PersonShowTableViewCell class] forCellReuseIdentifier:@"CELL_show"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}

//tableview的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.personShowDataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE_SCALE_IPHONE6(5);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonShowTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_show" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UPerson * model = self.personShowDataArray[indexPath.section];
    
    
//    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    NSDate * date = [formatter dateFromString:model.CreateTime];
//    NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
//    [formatter1 setDateFormat:@"yyyy/MM/dd"];
//    NSString * timeString = [formatter1 stringFromDate:date];

    NSString * timeString = [model.CreateTime substringToIndex:10];
    
    cell.timeLabel.text = timeString;
    cell.showContent.text = model.ShowCont;
    //    cell.imageString = model.ShowPic;
    NSArray * array = [model.ShowPic componentsSeparatedByString:@";"];
    [cell setCellImageWithArray:array];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return SIZE_SCALE_IPHONE6(167.5);
    
    PersonShowTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_show"];
    
    [cell cellAutoLayoutHeight:cell.showContent.text];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    return size.height + SIZE_SCALE_IPHONE6(100);
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self getUserInfo];
    
    UPerson * model = self.personShowDataArray[indexPath.section];
    model.UHeadPortrait = self.pModel.UHeadPortrait;
    model.USex = self.pModel.USex;
    model.UNickName = self.pModel.UNickName;
    model.Area = self.pModel.Area;
    
    
    ShowDetailViewController * showVC = [[ShowDetailViewController alloc] init];
    showVC.personModel = model;
    [self.navigationController pushViewController:showVC animated:YES];
    
}

-(void)getUserInfo{
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/getUserInfoByUID" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.pModel = [UPerson new];
            [self.pModel setValuesForKeysWithDictionary:dict[@"data"]];
        }else{
            NSLog(@"加载出错");
            [self showAlertWithString:dict[@"message"]];
        }
        //刷新UI
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"加载数据出错");
    }];
    

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
