//
//  IndexViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "IndexViewController.h"
#import "Header.h"
#import "NSDate+ZTCurrentDate.h"
#import "NSString+VerifyPhoneNumber.h"
#import <AudioToolbox/AudioToolbox.h>

//static SystemSoundID shake_sound_male_id = 0;

@interface IndexViewController ()<UIScrollViewDelegate>
//轮播图
@property(nonatomic, strong)OrderView *orderView;
@property(nonatomic, strong)UIButton *XPCoin;
@property(nonatomic, strong)UIButton *XPButler;
@property(nonatomic, strong)UILabel *XPButlerNum;
@property(nonatomic, strong)UIButton *XPRent;
@property(nonatomic, strong)UIButton *XPHourse;
@property(nonatomic, strong)UIButton *XPApartment;
@property(nonatomic, strong)UIButton *XPNeighbour;
@property(nonatomic, strong)UIButton *XPLink;
//@property(nonatomic, strong)NSString *CustId;
@property(nonatomic, strong)XPBaseModel * numModel;

@property(nonatomic, strong)NSArray * photoArray;
@property(nonatomic, strong)UISlider * slider;
@property(nonatomic, strong)UILabel * openLabel; //开门label
@property(nonatomic, strong)UIScrollView *scrollView; //滑动view


@end

@implementation IndexViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self makeData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = [UIColor whiteColor];
    [self makeData];
    
    [self.navigationController setNavigationBarHidden:YES];

    [self setupViews];

}


-(void)makeData {
    
    UIImageView * imv1 = [[UIImageView alloc] init];
    [imv1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/index/img/1.png", BaseURL]]];
    UIImageView * imv2 = [[UIImageView alloc] init];
    [imv2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/index/img/2.png", BaseURL]]];
    UIImageView * imv3 = [[UIImageView alloc] init];
    [imv3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/index/img/3.png", BaseURL]]];
    
    //通知消息
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustId"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo: dictory path:@"/workorder/getNumber" success:^(NSDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {

            self.numModel = [[XPBaseModel alloc] initWithDic:dict[@"data"]];
            
            if (self.numModel.number == 0) {
                self.XPButlerNum.hidden = YES;
            }else {
                self.XPButlerNum.text = [NSString stringWithFormat:@"%d",self.numModel.number];
                self.XPButlerNum.hidden = NO;
            }

        }else {
            //没有新消息
        }
    } failed:^{
        
    }];
    

}

-(void)setupViews{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(667));
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    _scrollView.delegate = self;
    
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(667))];;
    [_scrollView addSubview:contentView];

    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 10)];
    [self.view addSubview:view1];
    
    //轮播图
    NSMutableArray * array = [NSMutableArray array];
    [array addObject:[NSString stringWithFormat:@"%@/index/img/1.png", BaseURL]];
    [array addObject:[NSString stringWithFormat:@"%@/index/img/2.png", BaseURL]];
    [array addObject:[NSString stringWithFormat:@"%@/index/img/3.png", BaseURL]];

    
    self.orderView = [[OrderView alloc] init];
    self.orderView.frame = CGRectMake(SIZE_SCALE_IPHONE6(10.5), SIZE_SCALE_IPHONE6(30), SIZE_SCALE_IPHONE6(354), SIZE_SCALE_IPHONE6(200));
    //    self.orderView.backgroundColor = [UIColor cyanColor];
    [self.orderView bindImageArray:array];
    [contentView addSubview:self.orderView];
    
    //新派币
    self.XPCoin = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.XPCoin setImage:[UIImage imageNamed:@"组-43"] forState:(UIControlStateNormal)];
    [contentView addSubview:self.XPCoin];
    
    [self.XPCoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderView.mas_bottom).offset(SIZE_SCALE_IPHONE6(22));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(22.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(100), SIZE_SCALE_IPHONE6(106)));
        
    }];
    
    [self.XPCoin addTarget:self action:@selector(XPCoinAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //新派管家
    self.XPButler = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.XPButler setImage:[UIImage imageNamed:@"组-44"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.XPButler];
    
    [self.XPButler mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.XPCoin.mas_top);
        make.left.mas_equalTo(self.XPCoin.mas_right).offset(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(100), SIZE_SCALE_IPHONE6(106)));
        
    }];
    
    [self.XPButler addTarget:self action:@selector(XPButlerAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //新派管家提醒
    self.XPButlerNum = [[UILabel alloc] init];
    self.XPButlerNum.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.XPButlerNum setTextColor:[UIColor whiteColor]];
    self.XPButlerNum.font = [UIFont systemFontOfSize:13];
    self.XPButlerNum.textAlignment = NSTextAlignmentCenter;
    self.XPButlerNum.layer.cornerRadius = 8;
    self.XPButlerNum.layer.masksToBounds = YES;
    self.XPButlerNum.text = [NSString stringWithFormat:@"%d",self.numModel.number];
//    NSLog(@"%@",self.XPButlerNum.text);
    [self.view addSubview:self.XPButlerNum];
    [self.XPButlerNum mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.XPButler.mas_top).offset(SIZE_SCALE_IPHONE6(20));
        make.right.mas_equalTo(self.XPButler.mas_right).offset(SIZE_SCALE_IPHONE6(-10));
        make.size.mas_equalTo(CGSizeMake(16,16));
        
    }];
    
    //我要租新派
    self.XPRent = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.XPRent setImage:[UIImage imageNamed:@"组-46"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.XPRent];
    
    [self.XPRent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.XPCoin.mas_top);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-22.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(100), SIZE_SCALE_IPHONE6(106)));
        
    }];
    
    [self.XPRent addTarget:self action:@selector(XPRentAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //房间
    self.XPHourse = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.XPHourse setImage:[UIImage imageNamed:@"组-48"] forState:(UIControlStateNormal)];
    self.XPHourse.userInteractionEnabled = NO;
    [self.view addSubview:self.XPHourse];
    
    [self.XPHourse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.XPCoin.mas_bottom).offset(SIZE_SCALE_IPHONE6(12));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(22.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(161), SIZE_SCALE_IPHONE6(108)));
        
    }];

    //滑动按钮
    self.slider = [[UISlider alloc] init];
    self.slider.backgroundColor = [UIColor clearColor];
    [self.slider setThumbImage:[UIImage imageNamed:@"111="] forState:(UIControlStateNormal)];
    [self.view addSubview:_slider];
    self.slider.maximumValue = 1.0;
    self.slider.minimumValue = 0.0;
    
    UIImage * clearImage = [self clearPixel];
    [_slider setMaximumTrackImage:clearImage forState:UIControlStateNormal];
    [_slider setMinimumTrackImage:clearImage forState:UIControlStateNormal];
    
//    [self.slider setMinimumTrackTintColor:[UIColor clearColor]];
//    [self.slider setMaximumTrackTintColor:[UIColor clearColor]];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.XPHourse.mas_left).offset(SIZE_SCALE_IPHONE6(20));
        make.top.mas_equalTo(self.XPHourse.mas_top).offset(SIZE_SCALE_IPHONE6(22));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(122), SIZE_SCALE_IPHONE6(40)));
    }];
    //不断触发valueEvent
    self.slider.continuous = YES ;
    [self.slider addTarget:self action:@selector(dragAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //开门
    _openLabel = [[UILabel alloc] init];
    _openLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    _openLabel.font = [UIFont systemFontOfSize:12.f];
    _openLabel.textAlignment = NSTextAlignmentCenter;
    _openLabel.hidden = YES;
    [self.view addSubview:_openLabel];
    [_openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.slider.mas_left);
        make.right.mas_equalTo(self.slider.mas_right);
        make.top.mas_equalTo(self.slider.mas_top);
        make.bottom.mas_equalTo(self.slider.mas_bottom);
    }];
    
    //公寓
    self.XPApartment = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.XPApartment setImage:[UIImage imageNamed:@"组-50"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.XPApartment];
    
    [self.XPApartment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.XPHourse.mas_top);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-22.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(161), SIZE_SCALE_IPHONE6(108)));
        
    }];
    
    [self.XPApartment addTarget:self action:@selector(XPApartmentAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //左邻右舍
    self.XPNeighbour = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.XPNeighbour setImage:[UIImage imageNamed:@"组-52"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.XPNeighbour];
    
    [self.XPNeighbour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.XPHourse.mas_bottom).offset(SIZE_SCALE_IPHONE6(12));
        make.left.mas_equalTo(self.XPCoin.mas_left);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(161), SIZE_SCALE_IPHONE6(108)));
        
    }];
    
    [self.XPNeighbour addTarget:self action:@selector(XPNeighbourAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //新派link
    self.XPLink = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.XPLink setImage:[UIImage imageNamed:@"组-49"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.XPLink];
    
    [self.XPLink mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.XPNeighbour.mas_top);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-22.5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(161), SIZE_SCALE_IPHONE6(108)));
    }];
    
    [self.XPLink addTarget:self action:@selector(XPLinkAction) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)dragAction:(id)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"state"] isEqualToString:@""]) {
        [self showAlertWithString:@"只有公民才能使用此功能哦"];
        self.slider.value = 0;
        
    }else{
        if (self.slider.value == 1.0) {
            _openLabel.hidden = NO;
            [self openTheDoorWithDoorType:@"2"];
        }
        else{
            self.slider.value = 0;
        }
        self.slider.value = 0;
        

    }
    
}

//开门
-(void)openTheDoorWithDoorType:(NSString *)type {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    [params setValue:type forKey:@"DoorType"];
//    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"RoomID"] forKey:@"DoorID"];
    [params setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] forKey:@"Phone"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:params path:@"/unlock_door/unlock" success:^(NSMutableDictionary *dic) {

        NSLog(@"%@", dic[@"message"]);
        
        if ([dic[@"code"] intValue] == 0) {
            self.openLabel.text = @"门开了";
            [self showAlertWithString:@"开门成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _openLabel.hidden = YES;
            });
            
        } else {
            _openLabel.text = @"很抱歉";
            [self showAlertWithString:@"开门失败"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _openLabel.hidden = YES;
            });
        }
        //开门声音
        [self playSound];

    } failed:^{
        [self showAlertWithString:@"开门失败"];
    }];
}

//新派币
-(void)XPCoinAction {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"state"] isEqualToString:@""]) {
        
        [self showAlertWithString:@"只有公民才能使用此功能哦"];

    }else{
        
        XPCoinViewController * coinVC = [[XPCoinViewController alloc] init];
        [self.navigationController pushViewController:coinVC animated:YES];
    }
    
}
//新派管家
-(void)XPButlerAction {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"state"] isEqualToString:@""]) {
        
        [self showAlertWithString:@"只有公民才能使用此功能哦"];
        
    }else{
        XPButlerViewController * butlerVC = [[XPButlerViewController alloc] init];
        butlerVC.citizenModel = self.citizenModel;
        [self.navigationController pushViewController:butlerVC animated:YES];
    }
    
}
//我要租新派
-(void)XPRentAction {
    XPRentViewController * rentVC = [[XPRentViewController alloc] init];
    [self.navigationController pushViewController:rentVC animated:YES];
    
}

//公寓
-(void)XPApartmentAction {
    [self openTheDoorWithDoorType:@"1"];
    
}
//左邻右舍
-(void)XPNeighbourAction {

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"state"] isEqualToString:@""]) {
        [self showAlertWithString:@"只有公民才能使用此功能哦"];
    }else{
        RootTabBarController *rootVC =  (RootTabBarController *)self.tabBarController;
        rootVC.selectedIndex = 0;
    }
}
//新派link
-(void)XPLinkAction {
    XPLinkViewController * linkVC = [[XPLinkViewController alloc] init];
    [self.navigationController pushViewController:linkVC animated:YES];
    
}

-(void) playSound

{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"opendoor1" ofType:@"wav"];
//    if (path) {
//        //注册声音到系统
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id);
//        AudioServicesPlaySystemSound(shake_sound_male_id);
//                AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
//    }
//    
//    AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动

}


//设置slider的滑动颜色
- (UIImage *) clearPixel {
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
