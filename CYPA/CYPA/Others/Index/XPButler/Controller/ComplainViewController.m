//
//  ComplainViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ComplainViewController.h"
#import "Header.h"
#import "UITextField+UIDataPicker1.h"
#import "MHDatePicker.h"


@interface ComplainViewController ()<UITextViewDelegate>
@property(nonatomic, strong)UILabel * roomLabel;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)UILabel * requireLabel;
@property(nonatomic, strong)UILabel * serviceLabel;
@property(nonatomic, strong)UITextField * timeTF;
@property(nonatomic, strong)UITextView * requireView;
@property(nonatomic, strong)UILabel * placeholderLabel;

@property(nonatomic, strong)UIButton * sureButton;
@property(nonatomic, strong)UIDatePicker *datePicker;
@property(nonatomic, strong)NSString *pickerTime;

//时间选择器
@property (strong, nonatomic) MHDatePicker *selectTimePicker;

@end

@implementation ComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
}

-(void)setupViews {
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    UIView * serviceView = [[UIView alloc] init];
    serviceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:serviceView];
    [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(320));
    }];
    
    //房间号
    self.roomLabel = [[UILabel alloc] init];
    //    self.roomLabel.backgroundColor = [UIColor grayColor];
    self.roomLabel.font = [UIFont systemFontOfSize:15];
    self.roomLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.roomLabel.text = [NSString stringWithFormat:@"房间号:  %@(默认)", [[NSUserDefaults standardUserDefaults] objectForKey:@"RoomNo"]];
    [self.view addSubview:self.roomLabel];
    
    [self.roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(serviceView.mas_top).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(serviceView.mas_left).offset(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(330), SIZE_SCALE_IPHONE6(15)));
    }];
    //时间段
    self.timeLabel = [[UILabel alloc] init];
    //    self.timeLabel.backgroundColor = [UIColor grayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.timeLabel.text = @"时间段:";
    [self.view addSubview:self.timeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.roomLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(self.roomLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];

    
    //开始时间
    self.timeTF = [[UITextField alloc] init];
    self.timeTF.placeholder = @"请选择";
    self.timeTF.font = [UIFont systemFontOfSize:15];
    self.timeTF.tag = 101;
    //    self.startTF.delegate = self;
    self.timeTF.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.view addSubview:self.timeTF];
    //时间选择
    self.timeTF.datePickerInput11 = YES;
    
    [self.timeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeLabel.mas_centerY);
        make.left.mas_equalTo(self.timeLabel.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(110), SIZE_SCALE_IPHONE6(20)));
    }];
    
    //结束时间选择
    UIButton * chooseTimeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:chooseTimeButton];
    
    [chooseTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeLabel.mas_centerY);
        make.left.mas_equalTo(self.timeLabel.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(110), SIZE_SCALE_IPHONE6(20)));
    }];
    //选择结束时间
    [chooseTimeButton addTarget:self action:@selector(chooseStartTime) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //服务类型
    self.serviceLabel = [[UILabel alloc] init];
    self.serviceLabel.font = [UIFont systemFontOfSize:15];
    self.serviceLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.serviceLabel.text = @"服务类型:投诉建议";
    [self.view addSubview:self.serviceLabel];
    
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(self.roomLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(330), SIZE_SCALE_IPHONE6(15)));
    }];
    
    //服务要求：
    self.requireLabel = [[UILabel alloc] init];
    self.requireLabel.font = [UIFont systemFontOfSize:15];
    self.requireLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.requireLabel.text = @"服务要求：";
    [self.view addSubview:self.requireLabel];
    //
    [self.requireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.serviceLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(self.roomLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //输入服务要求
    self.requireView = [[UITextView alloc] init];
    self.requireView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    self.requireView.textColor = [UIColor colorWithHexString:@"666666"];
    self.requireView.font = [UIFont systemFontOfSize:15];
    self.requireView.delegate = self;
    [self.view addSubview:self.requireView];
    
    [self.requireView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.requireLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(30));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(315), SIZE_SCALE_IPHONE6(90)));
    }];
    
    //textview的placeholder
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.placeholderLabel.font = [UIFont systemFontOfSize:15];
    self.placeholderLabel.numberOfLines = 2;
    //    self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
    self.placeholderLabel.text = @"  请简单描述您的投诉内容";
    //    self.placeholderLabel.backgroundColor = [UIColor yellowColor];
    [self.requireView addSubview:self.placeholderLabel];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        //        make.right.mas_equalTo(0);
        //        make.height.mas_equalTo(self.requireView);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(315), SIZE_SCALE_IPHONE6(40)));
    }];
    
    //确定
    self.sureButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.sureButton setTitle:@"确定" forState:(UIControlStateNormal)];
    self.sureButton.tintColor = [UIColor whiteColor];
    self.sureButton.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    self.sureButton.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.view addSubview:self.sureButton];
    
    //提交按钮
    [self.sureButton addTarget:self action:@selector(submitAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.requireView.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.centerX.mas_equalTo(serviceView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
    
}

//提交
-(void)submitAction {

    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustId"];
    [dict setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] forKey:@"phone"];
    [dict setValue:@"04_001_1" forKey:@"orderType"];
    [dict setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"ApartmentID"] forKey:@"ApartmentID"];
    [dict setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"RoomID"] forKey:@"RoomNo"];
    [dict setValue: self.timeTF.text forKey:@"workTime"];
    [dict setValue:self.requireView.text forKey:@"orderdesc"];
    

    if (self.timeTF.text.length == 0 || self.requireView.text.length == 0){
        
        [self showAlertWithString:@"请填写完整信息"];
        
    }else{
        [[GXNetWorkManager shareInstance] getInfoWithInfo:dict path:@"/workorder/new"success:^(NSMutableDictionary * dictionary) {
        
        if ([dictionary[@"code"] isEqualToString:@"0"]) {
            
            [self showAlertAndBackWithString:dictionary[@"message"]];
            
        }else {
            [MBProgressHUD showSuccess:@"暂时不支持发表情哦"];

//            [self showAlertWithString:dictionary[@"message"]];
            
        }
        
    } failed:^{
        [self showAlertWithString:@"提交失败"];
    }];
    
}
}

//选择时间
-(void)chooseStartTime{
    _selectTimePicker = [[MHDatePicker alloc] init];
    _selectTimePicker.datePickerMode = UIDatePickerModeDate;
    __weak typeof(self) weakSelf = self;
    [_selectTimePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        weakSelf.timeTF.text = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy/MM/dd"];
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

//点击空白回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

//textView delegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.requireView.text = textView.text;
    self.placeholderLabel.text = @"";
    return YES;
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
