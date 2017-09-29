//
//  ServiceDetailViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/17.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ServiceDetailViewController.h"
#import "Header.h"
@interface ServiceDetailViewController ()

@property(nonatomic, strong)UIImageView * headImv;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * serviceLabel;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)UILabel * roomLabel;
@property(nonatomic, strong)UILabel * requireLabel;

@property(nonatomic, strong)UIImageView * ESQImv;
@property(nonatomic, strong)UILabel * ESQNameLabel;

@property(nonatomic, strong)UILabel * stateLabel;
@property(nonatomic, strong)XPServiceModel * serviceModel;

@end

@implementation ServiceDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self makeData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self makeData];

    
    [self setupViews];
}

-(void)makeData {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:self.WorkOrderID forKey:@"WorkOrderID"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/workorder/getWorkOrder" success:^(NSMutableDictionary * dict) {
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.serviceModel = [XPServiceModel new];
            [self.serviceModel setValuesForKeysWithDictionary:dict[@"data"]];
            
            if ([self.serviceModel.orderType isEqualToString:@"投诉"]) {
                self.timeLabel.text = [NSString stringWithFormat:@"服务时间:%@", self.serviceModel.workTime];
            }else{
                NSArray * array = [self.serviceModel.workTime componentsSeparatedByString:@","];
                self.timeLabel.text = [NSString stringWithFormat:@"时间段:%@至%@", array[0], array[1]];
            }
            self.serviceLabel.text = [NSString stringWithFormat:@"服务类型：%@", self.serviceModel.orderType];
            self.requireLabel.text = [NSString stringWithFormat:@"服务要求：%@", self.serviceModel.ORDERDESC];
            _stateLabel.text = self.serviceModel.STATUS;
            

        }else{
            [self showAlertWithString:@"获取数据失败"];
        }
    } failed:^{
        [self showAlertWithString:@"获取数据失败"];
        
    }];
}


-(void)setupViews {
    
    //上部View
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(250));
//        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-500));
    }];
    
    //头像
    _headImv = [[UIImageView alloc] init];
    _headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(11);
    _headImv.layer.masksToBounds = YES;
            _headImv.backgroundColor = [UIColor cyanColor];
    [_headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,[[NSUserDefaults standardUserDefaults] objectForKey:@"UHeadPortrait"]]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    [self.view addSubview:self.headImv];
    
    [_headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(22), SIZE_SCALE_IPHONE6(22)));
    }];
    
    //名字
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"UNickName"];
    [self.view addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImv.mas_centerY);
        make.left.mas_equalTo(self.headImv.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //房间号
    self.roomLabel = [[UILabel alloc] init];
    //    self.roomLabel.backgroundColor = [UIColor grayColor];
    self.roomLabel.font = [UIFont systemFontOfSize:15];
    self.roomLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.roomLabel.text = [NSString stringWithFormat:@"房间号:  %@(默认)", [[NSUserDefaults standardUserDefaults] objectForKey:@"RoomNo"]];
    [self.view addSubview:self.roomLabel];
    
    [self.roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(22.5));
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //时间段
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.view addSubview:self.timeLabel];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.roomLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];

    //服务类型
    self.serviceLabel = [[UILabel alloc] init];
    self.serviceLabel.font = [UIFont systemFontOfSize:15];
    self.serviceLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    [self.view addSubview:self.serviceLabel];
    
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];

    //服务要求
    self.requireLabel = [[UILabel alloc] init];
    self.requireLabel.font = [UIFont systemFontOfSize:15];
    self.requireLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.view addSubview:self.requireLabel];
    
    [self.requireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.serviceLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-45));
//        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    
    //客服头像
    _ESQImv = [[UIImageView alloc] init];
    _ESQImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(11);
    _ESQImv.layer.masksToBounds = YES;
    _ESQImv.backgroundColor = [UIColor cyanColor];

    _ESQImv.image = [UIImage imageNamed:@"kefu.png"];
    [self.view addSubview:self.ESQImv];
    
    [_ESQImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(-50));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(22), SIZE_SCALE_IPHONE6(22)));
    }];
    
    //客服名字
    _ESQNameLabel = [[UILabel alloc] init];
    _ESQNameLabel.font = [UIFont systemFontOfSize:15];
    _ESQNameLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _ESQNameLabel.backgroundColor = [UIColor yellowColor];
    _ESQNameLabel.text = @"小派";
    [self.view addSubview:_ESQNameLabel];
    
    [_ESQNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.ESQImv.mas_centerY);
        make.right.mas_equalTo(self.ESQImv.mas_left).offset(SIZE_SCALE_IPHONE6(-5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    

    //服务状态
    _stateLabel = [[UILabel alloc] init];
    _stateLabel.font = [UIFont systemFontOfSize:15];
    _stateLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _stateLabel.backgroundColor = [UIColor yellowColor];
    
    
    [self.view addSubview:_stateLabel];
    
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(-20));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-50));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    
    //下部View
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    
    UIButton * callBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [callBT setImage:[UIImage imageNamed:@"iconfont-laba"] forState:(UIControlStateNormal)];
    [callBT setTitle:@"联系客服" forState:(UIControlStateNormal)];
    [callBT setTitleColor:[UIColor blackColor] forState:normal];
    callBT.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:callBT];
    
    [callBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(7.5));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-12.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(90), SIZE_SCALE_IPHONE6(20)));
    }];
    
    [callBT addTarget:self action:@selector(callESQAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

//打电话给客服
-(void)callESQAction {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"联系客服" message:@"拨打 010-87212566" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://010-87212566"]];

    }];
    
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:sureAction];
    [alert addAction:cancleAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
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
