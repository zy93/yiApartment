//
//  PayHistoryViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/1.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PayHistoryViewController.h"
#import "Header.h"
#import "WZXRoundView.h"
#import "CheckModel.h"
#import "MHDatePicker.h"

@interface PayHistoryViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property(nonatomic, strong)UITextField * startTF;
@property(nonatomic, strong)UITextField * endTF;
@property(nonatomic, strong)UITableView * tableView;

@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UILabel * lifeCostLabel;
@property(nonatomic, strong)UILabel * shopCostLabel;

//饼状图arr
@property(nonatomic, strong)NSMutableArray * arr;
@property(nonatomic, strong)UIView * bottomRoundView;

//历史缴费
@property(nonatomic, strong)NSMutableArray * checkArray;

//日期选择器
@property (strong, nonatomic) MHDatePicker *selectDatePicker;

@end

@implementation PayHistoryViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self makeData];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [self getHistoryCheckWithbeginDate:@"2016-01-01" endDate:[formatter stringFromDate:[NSDate date]]];
    
//    [self makeData];
    
    [self setupViews];
    

    
}

-(void)makeData {
    
    //获取用户的消费金额
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
        NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/rmb/statBusiness" success:^(NSMutableDictionary * dict) {
        
        NSLog(@"%@", dict);
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            NSString * s = [NSString stringWithFormat:@"%@", dict[@"data"][@"Total"]];
            double a = [s doubleValue];
            self.titleLabel.text = [NSString stringWithFormat:@"￥ %.1f", a];
            
            NSString * s1 = [NSString stringWithFormat:@"%@", dict[@"data"][@"ShopTotal"]];
            double b = [s1 doubleValue];
            self.shopCostLabel.text = [NSString stringWithFormat:@"￥ %.1f", b];
            
            NSString * s2 = [NSString stringWithFormat:@"%@", dict[@"data"][@"LifeTotal"]];
            double c = [s2 doubleValue];
            self.lifeCostLabel.text = [NSString stringWithFormat:@"￥ %.1f", c];
            
            
            _arr = [NSMutableArray array];
            NSMutableDictionary * dic2 = [[NSMutableDictionary alloc]init];
            [dic2 setObject:dict[@"data"][@"ShopTotal"] forKey:@"num"];
//                        [dic2 setObject:@"0" forKey:@"num"];

            [dic2 setObject:[UIColor redColor] forKey:@"color"];
            [_arr addObject:dic2];
            
            NSMutableDictionary * dic1 = [[NSMutableDictionary alloc]init];
            [dic1 setObject:dict[@"data"][@"LifeTotal"] forKey:@"num"];
//            [dic1 setObject:@"0" forKey:@"num"];

            [dic1 setObject:[UIColor cyanColor] forKey:@"color"];
            [_arr addObject:dic1];
            
            WZXRoundView *roundView = [[WZXRoundView alloc] initWithFrame:CGRectMake(0, 0, _bottomRoundView.frame.size.width, _bottomRoundView.frame.size.width) andArr:self.arr];
            
            [_bottomRoundView addSubview:roundView];
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
    } failed:^{
        NSLog(@"获取用户信息失败");
    }];
    
}

//获取规定时间的缴费信息
-(void)getHistoryCheckWithbeginDate:(NSString *)beginDate endDate:(NSString *)endDate {
    
    self.checkArray = [NSMutableArray array];
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:beginDate forKey:@"BeginDate"];
    [dictory setValue:endDate forKey:@"EndDate"];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];

    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/rmb/listBusiness" success:^(NSMutableDictionary * dict) {
        
                        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            for (NSDictionary * dic in dict[@"data"]) {
                CheckModel * model = [CheckModel new];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.checkArray addObject:model];
            }
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        
        //刷新数据
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"获取用户信息失败");
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
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(140));
    }];
    
    //title
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = [NSString stringWithFormat:@"总支出  %d",0];
    _titleLabel.font = [UIFont systemFontOfSize:23];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(0));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(200), SIZE_SCALE_IPHONE6(30)));
    }];
    
    //饼状图
    
    _bottomRoundView = [[UIView alloc] initWithFrame:CGRectMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(100), SIZE_SCALE_IPHONE6(95), SIZE_SCALE_IPHONE6(95))];
    [self.view addSubview:_bottomRoundView];

    
    //生活缴费
    UIImageView * lifeImv = [[UIImageView alloc] init];
    lifeImv.image = [UIImage imageNamed:@"iconfont-shenghuo"];
    [topView addSubview:lifeImv];
    
    [lifeImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(50));
        make.left.mas_equalTo(_bottomRoundView.mas_right).offset(SIZE_SCALE_IPHONE6(44));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(27), SIZE_SCALE_IPHONE6(20)));
    }];
    
    UILabel * lifeLabel1 = [[UILabel alloc] init];
    lifeLabel1.text = @"生活缴费";
    lifeLabel1.font = [UIFont systemFontOfSize:15];
    lifeLabel1.textAlignment = NSTextAlignmentLeft;
    lifeLabel1.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:lifeLabel1];
    
    [lifeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lifeImv.mas_top);
        make.left.mas_equalTo(lifeImv.mas_right).offset(SIZE_SCALE_IPHONE6(10));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    //生活缴费金额
    _lifeCostLabel = [[UILabel alloc] init];
    _lifeCostLabel.text = @"￥  0";
    _lifeCostLabel.font = [UIFont systemFontOfSize:15];
    _lifeCostLabel.textAlignment = NSTextAlignmentRight;
    _lifeCostLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.view addSubview:_lifeCostLabel];
    
    [_lifeCostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lifeImv.mas_top);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-20));
        make.height.mas_equalTo(lifeImv.mas_height);
    }];

    
    
    //购物
    UIImageView * shopImv = [[UIImageView alloc] init];
    shopImv.image = [UIImage imageNamed:@"iconfont-gouwu"];
    [topView addSubview:shopImv];
    
    [shopImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lifeImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(lifeImv.mas_left);
        make.size.mas_equalTo(lifeImv);
    }];
    
    UILabel * shopLabel1 = [[UILabel alloc] init];
    shopLabel1.text = @"购物";
    shopLabel1.font = [UIFont systemFontOfSize:15];
    shopLabel1.textAlignment = NSTextAlignmentLeft;
    shopLabel1.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:shopLabel1];
    
    [shopLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shopImv.mas_top);
        make.left.mas_equalTo(lifeLabel1.mas_left);
        make.size.mas_equalTo(lifeLabel1);
    }];
    
    //购物金额
    _shopCostLabel = [[UILabel alloc] init];
    _shopCostLabel.text = @"￥  0";
    _shopCostLabel.font = [UIFont systemFontOfSize:15];
    _shopCostLabel.textAlignment = NSTextAlignmentRight;
    _shopCostLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self.view addSubview:_shopCostLabel];
    
    [_shopCostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shopImv.mas_top);
        make.right.mas_equalTo(_lifeCostLabel.mas_right);
        make.height.mas_equalTo(shopImv.mas_height);
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
    
    //历史记录底部的View
    UIView * view1 = [[UIView alloc] init];
//    view1.backgroundColor = [UIColor yellowColor];
    [bottomView addSubview:view1];

    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(50));
    }];
    
    //历史记录
    UILabel * historyLabel = [[UILabel alloc] init];
    historyLabel.text = @"历史记录";
//    historyLabel.backgroundColor = [UIColor cyanColor];
    historyLabel.font = [UIFont systemFontOfSize:15];
    historyLabel.textAlignment = NSTextAlignmentLeft;
    historyLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [bottomView addSubview:historyLabel];
    
    [historyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view1.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(25));
//        make.width.mas_equalTo(SIZE_SCALE_IPHONE6(65));
    }];
    
    //开始时间
    self.startTF = [[UITextField alloc] init];
    self.startTF.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    self.startTF.placeholder = @"请选择";
    self.startTF.font = [UIFont systemFontOfSize:15];
    //时间选择器
//    self.startTF.datePickerInputModelDate = YES;
    self.startTF.layer.cornerRadius = 3;
    self.startTF.layer.masksToBounds = YES;
    [self.view addSubview:self.startTF];
    
    [self.startTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(historyLabel.mas_top);
        make.left.mas_equalTo(historyLabel.mas_right).offset(SIZE_SCALE_IPHONE6(30));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(115), SIZE_SCALE_IPHONE6(25)));
    }];
    
    UIImageView * pushImv1 = [[UIImageView alloc] init];
    pushImv1.image = [UIImage imageNamed:@"iconfont-arrowdown-1"];
    [self.startTF addSubview:pushImv1];
    
    [pushImv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.startTF.mas_centerY);
        make.right.mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(13), SIZE_SCALE_IPHONE6(5)));
    }];
    //开始时间选择
    UIButton * startButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    startButton.tag = 1;
//    startButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:startButton];
    
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(historyLabel.mas_top);
        make.left.mas_equalTo(historyLabel.mas_right).offset(SIZE_SCALE_IPHONE6(30));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(115), SIZE_SCALE_IPHONE6(25)));
    }];
    //选择开始时间
    [startButton addTarget:self action:@selector(chooseStartTime:) forControlEvents:(UIControlEventTouchUpInside)];
    //至
    UILabel * toLabel = [[UILabel alloc] init];
    //    toLabel.backgroundColor = [UIColor grayColor];
    toLabel.font = [UIFont systemFontOfSize:15];
    toLabel.textColor = [UIColor colorWithHexString:@"333333"];
    toLabel.text = @"至";
    [self.view addSubview:toLabel];
    
    [toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTF.mas_top);
        make.left.mas_equalTo(self.startTF.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.height.mas_equalTo(self.startTF.mas_height);
    }];
    
    //结束时间
    self.endTF = [[UITextField alloc] init];
    self.endTF.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    self.endTF.font = [UIFont systemFontOfSize:15];
    self.endTF.placeholder = @"请选择";
//    时间选择器
//    self.endTF.datePickerInputModelDate = YES;
    self.endTF.layer.cornerRadius = 3;
    self.endTF.layer.masksToBounds = YES;
    self.endTF.tag = 8999;
    self.endTF.delegate = self;
    
    [self.view addSubview:self.endTF];
    
    [self.endTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTF.mas_top);
        make.left.mas_equalTo(toLabel.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(self.startTF);
    }];
    
    UIImageView * pushImv2 = [[UIImageView alloc] init];
    pushImv2.image = [UIImage imageNamed:@"iconfont-arrowdown-1"];
    [self.endTF addSubview:pushImv2];
    
    [pushImv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.startTF.mas_centerY);
        make.right.mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(13), SIZE_SCALE_IPHONE6(5)));
    }];
    
    //结束时间选择
    UIButton * endButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    endButton.tag = 2;
    //    startButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:endButton];
    
    [endButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTF.mas_top);
        make.left.mas_equalTo(toLabel.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(self.startTF);
    }];
    //选择结束时间
    [endButton addTarget:self action:@selector(chooseStartTime:) forControlEvents:(UIControlEventTouchUpInside)];
    

    //历史记录的tableView
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    [self.tableView registerClass:[PayHistoryTableViewCell class] forCellReuseIdentifier:@"CELL_pay"];
}


//tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.checkArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayHistoryTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_pay" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    CheckModel * model = self.checkArray[indexPath.row];
    
    cell.timeLabel.text = model.BusiDate;
    cell.costLabel.text = [NSString stringWithFormat:@"总缴费：%.1f", [model.TotalFee doubleValue]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SIZE_SCALE_IPHONE6(50);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PayDetailViewController * payVC = [[PayDetailViewController alloc] init];
    CheckModel * model = self.checkArray[indexPath.row];
    
    payVC.BusinessFlow = model.BusinessFlow;
    
    [self.navigationController pushViewController:payVC animated:YES];
}

//选择时间
-(void)chooseStartTime:(UIButton *)sender{
    _selectDatePicker = [[MHDatePicker alloc] init];
    _selectDatePicker.isBeforeTime = YES;
    _selectDatePicker.datePickerMode = UIDatePickerModeDate;
    
    __weak typeof(self) weakSelf = self;
    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        
        if (sender.tag == 1) {
            weakSelf.startTF.text = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy/MM/dd"];
        } else {
            weakSelf.endTF.text = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy/MM/dd"];
        }
        
        if ([weakSelf.startTF.text length] != 0 && [weakSelf.endTF.text length]!= 0) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
        
            NSDate * begindate = [formatter dateFromString:self.startTF.text];
            NSDate * enddate = [formatter dateFromString:self.endTF.text];
            
            [self getHistoryCheckWithbeginDate:[formatter stringFromDate:begindate] endDate:[formatter stringFromDate:enddate]];
    
            [self.tableView reloadData];
        }
        
        
    }];
}

//时间格式转换
- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}



////TextField代理
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField.tag == 8999) {
//        if (self.startTF.text.length != 0) {
//            
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-MM-dd"];
//            
//            NSDate * begindate = [formatter dateFromString:self.startTF.text];
//            NSDate * enddate = [formatter dateFromString:self.endTF.text];
//            
//            [self getHistoryCheckWithbeginDate:[formatter stringFromDate:begindate] endDate:[formatter stringFromDate:enddate]];
//
//            [self.tableView reloadData];
//            
//        }
//    }
//}




//点击空白回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
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
