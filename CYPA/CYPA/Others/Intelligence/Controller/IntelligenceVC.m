//
//  IntelligenceVC.m
//  CYPA
//
//  Created by HDD on 2016/11/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "IntelligenceVC.h"
#import "Header.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

@interface IntelligenceVC ()<BMKLocationServiceDelegate,BMKMapViewDelegate,UIWebViewDelegate>

@property(nonatomic, strong)BMKLocationService  *locService;
@property(nonatomic, strong)NSString *ylgurl; //h5页面
@property(nonatomic, strong)NSString *blance; //账户余额
@property(nonatomic, strong)UIWebView *webView;


@end

@implementation IntelligenceVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //开始定位
    [self startLocationAction];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.webView = [[UIWebView alloc] init];
    
    //    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.titleImv.frame)+20, self.view.frame.size.width, 300);
    
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-45));
    }];
    
//    self.backBT.hidden = YES;
    
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    
}

//-(BMKLocationService *)locService{
//    if (!_locService) {
//        _locService = [[BMKLocationService alloc] init];
//        _locService.delegate = self;
//
//    }
//    return _locService;
//}


-(void)startLocationAction {
    //启动LocationService
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"位置坐标: location %f,longitude %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [self getCountryWithLocation:userLocation];
    
    
}

//通过坐标获取位置
-(void)getCountryWithLocation:(BMKUserLocation *)userLocation{
    [_locService stopUserLocationService];
    
    //获取用户的余额
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    //    NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/rmb/balance" success:^(NSMutableDictionary * dict) {
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            NSMutableDictionary *params = @{
                                            @"lat" : [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude],
                                            @"lng" : [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude],
                                            @"maptype" : @"bd",
                                            @"user_tel" : [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"],
                                            @"community" : [[NSUserDefaults standardUserDefaults] objectForKey:@"apartmentName"],
                                            @"room" : [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"roomNo"]],
                                            @"money" : [NSString stringWithFormat:@"%@", dict[@"data"][@"Balance"]]
                                            }.mutableCopy;
            
            [[GXNetWorkManager shareInstance] getInfoWithInfo:params path:@"/common/ylgurl" success:^(NSMutableDictionary *dic) {
                if ([dic[@"code"] intValue] == 0){
                    self.ylgurl = dic[@"data"][@"ylgurl"];
                    NSURL * url = [NSURL URLWithString:self.ylgurl];
                    NSURLRequest * request = [NSURLRequest requestWithURL:url];
                    [self.webView loadRequest:request];
                    
                } else {
                    [self showAlertWithString:@"获取位置失败"];
                }
                
            } failed:^{
                [self showAlertWithString:@"获取位置失败"];
            }];
           
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
    } failed:^{
        NSLog(@"获取位置失败");
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
