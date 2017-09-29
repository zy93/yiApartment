//
//  EvaluateViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/29.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "EvaluateViewController.h"
#import "Header.h"
@interface EvaluateViewController ()<UITextViewDelegate>
@property(nonatomic, assign)NSInteger feedBackCount;
@property(nonatomic, assign)NSInteger attitudeCount;
@property(nonatomic, assign)NSInteger qualityCount;

@property(nonatomic, strong)UILabel * placehoderLabel;
@property(nonatomic, strong)UITextView * commentView;
@property(nonatomic, strong)UIButton * sureButton;

@property(nonatomic, strong)StarView *starQualityView;
@property(nonatomic, strong)StarView *starFeedbackView;
@property(nonatomic, strong)StarView *starAttitudeView;

@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
    
}

-(void)setupViews {
    //标题
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"请对本次服务进行打分";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.frame = CGRectMake(0, SIZE_SCALE_IPHONE6(80), self.view.frame.size.width, SIZE_SCALE_IPHONE6(20));
    [self.view addSubview:titleLabel];
    
    //反馈速度
    UILabel * feedBackLabel = [[UILabel alloc] init];
    feedBackLabel.text = @"反馈速度：";
    feedBackLabel.font = [UIFont systemFontOfSize:15.f];
    feedBackLabel.textColor = [UIColor colorWithHexString:@"333333"];
    feedBackLabel.frame = CGRectMake(SIZE_SCALE_IPHONE6(15), CGRectGetMaxY(titleLabel.frame)+SIZE_SCALE_IPHONE6(20), SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(20));
    [self.view addSubview:feedBackLabel];
    
    _starFeedbackView = [[StarView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(feedBackLabel.frame)+SIZE_SCALE_IPHONE6(30), CGRectGetMinY(feedBackLabel.frame), SIZE_SCALE_IPHONE6(150), CGRectGetHeight(feedBackLabel.frame)) EmptyImage:@"形状-41-拷贝-8" StarImage:@"形状-41-拷贝-5"];
//    starFeedbackView.backgroundColor = [UIColor yellowColor];
    
//    self.feedBackCount = [starFeedbackView count];
    [self.view addSubview:_starFeedbackView];
    
    
    //服务态度
    UILabel * attitudeLabel= [[UILabel alloc] init];
    attitudeLabel.text = @"服务态度：";
    attitudeLabel.font = [UIFont systemFontOfSize:15.f];
    attitudeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    attitudeLabel.frame = CGRectMake(CGRectGetMinX(feedBackLabel.frame), CGRectGetMaxY(feedBackLabel.frame)+SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(20));
    [self.view addSubview:attitudeLabel];
    
    _starAttitudeView = [[StarView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_starFeedbackView.frame), CGRectGetMinY(attitudeLabel.frame), SIZE_SCALE_IPHONE6(150), CGRectGetHeight(attitudeLabel.frame)) EmptyImage:@"形状-41-拷贝-8" StarImage:@"形状-41-拷贝-5"];
//    self.attitudeCount = [starAttitudeView count];
    [self.view addSubview:_starAttitudeView];
    
    
    //服务质量
    UILabel * qualityLabel = [[UILabel alloc] init];
    qualityLabel.text = @"服务质量：";
    qualityLabel.font = [UIFont systemFontOfSize:15.f];
    qualityLabel.textColor = [UIColor colorWithHexString:@"333333"];
    qualityLabel.frame = CGRectMake(CGRectGetMinX(feedBackLabel.frame), CGRectGetMaxY(attitudeLabel.frame)+SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(20));
    [self.view addSubview:qualityLabel];
    
    self.starQualityView = [[StarView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_starFeedbackView.frame), CGRectGetMinY(qualityLabel.frame), SIZE_SCALE_IPHONE6(150), CGRectGetHeight(qualityLabel.frame)) EmptyImage:@"形状-41-拷贝-8" StarImage:@"形状-41-拷贝-5"];
//    self.qualityCount = [starQualityView count];
    [self.view addSubview:_starQualityView];
    

    
    //输入服务要求
    self.commentView = [[UITextView alloc] initWithFrame:CGRectMake(SIZE_SCALE_IPHONE6(50), CGRectGetMaxY(qualityLabel.frame)+SIZE_SCALE_IPHONE6(32.5), self.view.frame.size.width - SIZE_SCALE_IPHONE6(100), SIZE_SCALE_IPHONE6(100))];
    self.commentView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    self.commentView.textColor = [UIColor colorWithHexString:@"666666"];
    self.commentView.font = [UIFont systemFontOfSize:15];
    self.commentView.delegate = self;
    [self.view addSubview:self.commentView];
    
    //textview的placeholder
    self.placehoderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.commentView.frame), SIZE_SCALE_IPHONE6(30))];
    self.placehoderLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.placehoderLabel.font = [UIFont systemFontOfSize:15];
    self.placehoderLabel.numberOfLines = 2;
    //    self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
    self.placehoderLabel.text = @"  写点评语吧，我们会不断地改进服务";
    //    self.placeholderLabel.backgroundColor = [UIColor yellowColor];
    [self.commentView addSubview:self.placehoderLabel];
    
    
    //确定
    self.sureButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.sureButton.frame = CGRectMake(0.5*CGRectGetWidth(self.view.frame)- SIZE_SCALE_IPHONE6(30), CGRectGetMaxY(self.commentView.frame)+SIZE_SCALE_IPHONE6(25), SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(25));
    [self.sureButton setTitle:@"确定" forState:(UIControlStateNormal)];
    self.sureButton.tintColor = [UIColor whiteColor];
    self.sureButton.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    self.sureButton.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [self.view addSubview:self.sureButton];
    
    //提交按钮
    [self.sureButton addTarget:self action:@selector(submitAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)submitAction {
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.workOrderID forKey:@"WorkOrderID"];
    [dict setValue:[NSString stringWithFormat:@"%ld,%ld,%ld", self.starFeedbackView.count,self.starAttitudeView.count, self.starQualityView.count] forKey:@"Score"];
    [dict setValue:self.commentView.text forKey:@"opinion"];
    
    //上传
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dict path:@"/workorder/score" success:^(NSMutableDictionary * dictionary) {
        
        if ([dictionary[@"code"] isEqualToString:@"0"]) {
            
//            [self showAlertWithString:@"评价成功"];
            [self showAlertAndBackWithString:@"评价成功"];
            
        }else {
            [self showAlertWithString:dictionary[@"message"]];
            
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } failed:^{
        [self showAlertWithString:@"提交失败"];
    }];
    
}


//textView delegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.commentView.text = textView.text;
    self.placehoderLabel.text = @"";
    return YES;
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
