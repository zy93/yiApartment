//
//  PersonCenterViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/17.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "Header.h"

@interface PersonCenterViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UPerson * pModel;
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)UIImageView *headImv;
@property(nonatomic, strong)UIImageView *backgroundImv;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *ageLabel;
@property (nonatomic,strong)UIImageView *genderImv;
@property(nonatomic, strong)UIButton *backIndexBT; //回到首页

@end

@implementation PersonCenterViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self makeData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"state"] isEqualToString:@""]) {
        
        VistorView * view1 = [[VistorView alloc] init];
        self.view = view1;
    }else{
        
        [self makeData];
        [self setupViews];
        
    }

}

-(void)makeData {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/getUserShow" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.pModel = [UPerson new];
            [self.pModel setValuesForKeysWithDictionary:dict[@"data"]];
            
            [self.backgroundImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,self.pModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
            self.backgroundImv.contentMode=UIViewContentModeScaleAspectFill;
            self.backgroundImv.clipsToBounds=YES;
            self.backgroundImv.frame = CGRectMake(SIZE_SCALE_IPHONE6(0), SIZE_SCALE_IPHONE6(114), kScreenWidth, SIZE_SCALE_IPHONE6(147));
            
            [self.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,self.pModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
            self.nameLabel.text = self.pModel.UNickName;
            
            if([self.pModel.USex isEqualToString:@"00_011_2"]){
                self.genderImv.image = [UIImage imageNamed:@"964"];
            }else{
                self.genderImv.image = [UIImage imageNamed:@"963"];
            }
            self.ageLabel.text = [NSString stringWithFormat:@"%@岁  %@", self.pModel.UAge, self.pModel.UConstellation];
            
        }else{
            NSLog(@"加载出错");
            [self showAlertWithString:dict[@"message"]];
        }
    } failed:^{
        NSLog(@"加载数据出错");
    }];
 
    
}

-(void)topViews {
    //背景图
    self.backgroundImv = [[UIImageView alloc] init];
    //    self.backgroundImv.image = [UIImage imageNamed:@"组-4"];
    [self.view addSubview:self.backgroundImv];
    
    [self.backgroundImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImv.mas_bottom);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(147));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    UIView * view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    view1.alpha = 0.8;
    [self.backgroundImv addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(0));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(0));
        make.size.mas_equalTo(self.backgroundImv);
    }];
    
    //头像
    self.headImv = [[UIImageView alloc] init];
    //    self.headImv.image = [UIImage imageNamed:@"组-3"];
    self.headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(40);
    self.headImv.layer.masksToBounds = YES;
    [self.view addSubview:self.headImv];
    
    [self.headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backgroundImv).offset(SIZE_SCALE_IPHONE6(-30));
        make.centerX.equalTo(self.backgroundImv);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(80)));
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.headImv.userInteractionEnabled = YES;
    [self.headImv addGestureRecognizer:tap];
    
    //姓名
    self.nameLabel = [[UILabel alloc] init];
//    self.nameLabel.text = @"往事随风";
    self.nameLabel.font = [UIFont systemFontOfSize:18];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nameLabel];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImv).offset(SIZE_SCALE_IPHONE6(-10));
        make.top.equalTo(self.headImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(7.5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //性别
    self.genderImv = [[UIImageView alloc] init];
    [self.view addSubview:self.genderImv];
    
    [self.genderImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.top.equalTo(self.nameLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
    }];
    
    
    
    //年龄+星座
    self.ageLabel = [[UILabel alloc] init];
//    self.ageLabel.text = @"20岁 天蝎座";
    self.ageLabel.textAlignment = NSTextAlignmentCenter;
    self.ageLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.ageLabel];
    
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImv);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    

}

//返回首页
-(void)backToIndexAction{
    RootTabBarController *rootVC =  (RootTabBarController *)self.tabBarController;
    rootVC.selectedIndex = 2;
}

//点击查看大图
-(void)tapAction{
    PictureViewController * pictureVC = [[PictureViewController alloc] init];
    pictureVC.aString = [NSString stringWithFormat:@"%@%@",BaseImageURL,self.pModel.UHeadPortrait];
    [self presentViewController:pictureVC animated:YES completion:nil];
}


-(void)setupViews {
    
    [self topViews];
    self.backBT.hidden = YES;
    //回到首页
    self.backIndexBT = [UIButton buttonTitle:@"回到首页" setBackground:nil andImage:nil titleColor:[UIColor colorWithHexString:@"FFFFFF"] titleFont:15];
    [self.view addSubview:self.backIndexBT];
    [self.backIndexBT addTarget:self action:@selector(backToIndexAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.backIndexBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleImv);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(43.5)));
    }];

    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[FunctionTableViewCell class] forCellReuseIdentifier:@"CELL_function"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backgroundImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-44));
    }];
    
    
    UIButton * exitBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [exitBT setTitle:@"注销登录" forState:(UIControlStateNormal)];
    [exitBT setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    exitBT.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:exitBT];
    
    [exitBT addTarget:self action:@selector(exitAction) forControlEvents:(UIControlEventTouchUpInside)];
    [exitBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleImv.mas_centerY);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(15)));
    }];
    

}

//注销登录
-(void)exitAction{
    
    UIAlertAction *actionRetry = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ChooseLoginViewController * chooseVC = [[ChooseLoginViewController alloc] init];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginID"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UID"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CustID"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RoomNo"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RoomID"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ApartmentID"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UHeadPortrait"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UNickName"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UPassWord"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginID"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];

        
        [self.navigationController pushViewController:chooseVC animated:YES];
    
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:actionCancel];
    [alertVC addAction:actionRetry];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}


//tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 9;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FunctionTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_function" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSArray * textArray = @[@"我的动态", @"我的消息", @"我的钱包", @"社区公告", @"我的账单", @"我的订单", @"我的合约", @"个人设置", @"关于我们"];
    NSArray * picArray = @[@"iconfont-yuyue", @"iconfont-liuyan", @"iconfont-qianbao", @"iconfont-xiaoxi", @"iconfont-hetong", @"iconfont-dingdan", @"iconfont-heyueji", @"iconfont-shezhi", @"about"];
    
    cell.functionImv.image = [UIImage imageNamed:picArray[indexPath.section]];
    cell.functionLabel.text = textArray[indexPath.section];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(50);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            MyDynamicViewController * dynamicVC = [[MyDynamicViewController alloc] init];
            [self.navigationController pushViewController:dynamicVC animated:YES];
            break;
            
        }
        case 1:
        {
            MyNewsViewController * newsVC = [[MyNewsViewController alloc] init];
            [self.navigationController pushViewController:newsVC animated:YES];
            break;
        }
        case 2:
        {
            XPCoinViewController * coinVC = [[XPCoinViewController alloc] init];
            [self.navigationController pushViewController:coinVC animated:YES];
            
            break;
        }
        case 3:
        {
            AnnouncementViewController * announcementVC = [[AnnouncementViewController alloc] init];
            [self.navigationController pushViewController:announcementVC animated:YES];
            
            break;
        }
        case 4:
        {
            MyBillViewController * billVC = [[MyBillViewController alloc] init];
            [self.navigationController pushViewController:billVC animated:YES];
            
            break;
        }
        case 5:
        {
            MyOrderViewController * orderVC = [[MyOrderViewController alloc] init];
            [self.navigationController pushViewController:orderVC animated:YES];
            break;
        }
        case 6:
        {
            MyContractViewController * contractVC = [[MyContractViewController alloc]init];
            [self.navigationController pushViewController:contractVC animated:YES];
            
            break;
        }
        case 7:
        {
            SettingChoiseViewController * settingVC = [[SettingChoiseViewController alloc] init];
            
            [self.navigationController pushViewController:settingVC animated:YES];
            
            break;
        }
        case 8:
        {
            XPRentViewController * rentVC = [[XPRentViewController alloc] init];
            [self.navigationController pushViewController:rentVC animated:YES];
            
            break;
        }
        default:
            break;
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
