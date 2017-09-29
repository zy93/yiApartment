//
//  PersonShowViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/16.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PersonShowViewController.h"
#import "Header.h"

@interface PersonShowViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UPerson * pModel;
@property(nonatomic, strong)UILabel *addrLabel2;
@property(nonatomic, strong)UILabel *introLabel2;
@property(nonatomic, strong)UILabel *homeLabel2;
@property(nonatomic, strong)UILabel *hobbyLabel2;

//个人动态展示数组
@property(nonatomic, strong)NSMutableArray * personShowDataArray;

@end

@implementation PersonShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeData];
    [self setupViews];


}

-(void)makeData {
    
    self.personShowDataArray = [NSMutableArray array];
    
//   UID: self.personModel.UID
    [[GXNetWorkManager shareInstance] getInfoWithUID:self.personModel.UID apartmentID:nil Type:nil path:@"/user/getUserShow" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.pModel = [UPerson new];
            [self.pModel setValuesForKeysWithDictionary:dict[@"data"]];
            
            for (NSDictionary * dic in dict[@"data"][@"Show"]) {
                UPerson * showModel = [UPerson new];
                [showModel setValuesForKeysWithDictionary:dic];
                [self.personShowDataArray addObject:showModel];
            }
            
//            NSLog(@"%@",self.personShowDataArray);
           
            //展示
            [self.backgroundImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.156.227:8080/AppImages/%@",self.pModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
            [self.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.156.227:8080/AppImages/%@",self.pModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
            self.nameLabel.text = self.pModel.UNickName;
            
            if([self.pModel.USex isEqualToString:@"00_011_2"]){
                self.genderImv.image = [UIImage imageNamed:@"964"];
            }else{
                self.genderImv.image = [UIImage imageNamed:@"963"];
                
            }
            self.ageLabel.text = [NSString stringWithFormat:@"%@ %@", self.pModel.UAge, self.pModel.UConstellation];
            self.addrLabel2.text = self.pModel.ApartmentName;
            self.hobbyLabel2.text = self.pModel.UHobby;
            self.introLabel2.text = self.pModel.USignaTure;
            self.homeLabel2.text = self.pModel.UHome;
            
            
        }else{
            NSLog(@"加载出错");
//            [self showAlert:dict[@"message"]];
        }
        //刷新UI
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"加载数据出错");
    }];
    
}

-(void)setupViews {
    
    //信息view
    //地址
    UIView * addressView = [[UIView alloc] init];
    addressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:addressView];
    
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backgroundImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    UILabel * addrLabel1 = [[UILabel alloc] init];
    addrLabel1.text = @"地址";
    addrLabel1.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [addressView addSubview:addrLabel1];
    
    [addrLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(addressView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.addrLabel2 = [[UILabel alloc] init];
    self.addrLabel2.text = self.pModel.ApartmentName;
    self.addrLabel2.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [addressView addSubview:self.addrLabel2];
    
    [self.addrLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(addressView.mas_centerY);
        make.centerX.mas_equalTo(addressView.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //签名
    UIView * introView = [[UIView alloc] init];
    introView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:introView];
    
    [introView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addressView.mas_bottom).offset(SIZE_SCALE_IPHONE6(1));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    UILabel * introLabel1 = [[UILabel alloc] init];
    introLabel1.text = @"签名";
    introLabel1.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [introView addSubview:introLabel1];
    
    [introLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(introView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.introLabel2 = [[UILabel alloc] init];
    self.introLabel2.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [introView addSubview:self.introLabel2];
    
    [self.introLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(introView.mas_centerY);
        make.centerX.mas_equalTo(introView.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //家乡
    UIView * hometownView = [[UIView alloc] init];
    hometownView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:hometownView];
    
    [hometownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introView.mas_bottom).offset(SIZE_SCALE_IPHONE6(1));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    UILabel * homeLabel1 = [[UILabel alloc] init];
    homeLabel1.text = @"家乡";
    homeLabel1.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [hometownView addSubview:homeLabel1];
    
    [homeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(hometownView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.homeLabel2 = [[UILabel alloc] init];
    self.homeLabel2.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [hometownView addSubview:self.homeLabel2];
    
    [self.homeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(hometownView.mas_centerY);
        make.centerX.mas_equalTo(hometownView.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //兴趣爱好
    UIView * hobbyView = [[UIView alloc] init];
    hobbyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:hobbyView];
    
    [hobbyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hometownView.mas_bottom).offset(SIZE_SCALE_IPHONE6(1));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    UILabel * hobbyLabel1 = [[UILabel alloc] init];
    hobbyLabel1.text = @"兴趣爱好";
    hobbyLabel1.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [hobbyView addSubview:hobbyLabel1];
    
    [hobbyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(hobbyView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.hobbyLabel2 = [[UILabel alloc] init];
    self.hobbyLabel2.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    [hobbyView addSubview:self.hobbyLabel2];
    
    [self.hobbyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(hobbyView.mas_centerY);
        make.centerX.mas_equalTo(hobbyView.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    
    
    
    //个人动态
    self.tableView = [[UITableView alloc] init];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[PersonShowTableViewCell class] forCellReuseIdentifier:@"CELL_show"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hobbyView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    //敲门
    [self.knockBT addTarget:self action:@selector(knockAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)knockAction {
    
    TalkViewController * talkVC = [[TalkViewController alloc] init];
    
    talkVC.FID = self.pModel.UID;
    
    [self.navigationController pushViewController:talkVC animated:YES];
    
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
    
    UPerson * model = self.personShowDataArray[indexPath.section];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate * date = [formatter dateFromString:model.CreateTime];
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"yyyy/MM/dd"];
    NSString * timeString = [formatter1 stringFromDate:date];
    
    cell.timeLabel.text = timeString;
    cell.showContent.text = model.ShowCont;
    cell.imageString = model.ShowPic;
    NSLog(@"%@", model.ShowPic);
    
    return cell;

}


//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(167.5);
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
