//
//  TalkViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/9.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "TalkViewController.h"
#import "Header.h"
@interface TalkViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)TalkModel * myModel;
@property(nonatomic, strong)TalkModel * othersModel;
@property(nonatomic, strong)UITextField * inputView;
@property(nonatomic, strong)UILabel *placeholderLabel;

//对话数组
@property(nonatomic, strong)NSMutableArray *talkArray;
//对话人的信息数组
@property(nonatomic, strong)NSMutableArray *personInfoArray;

@end

@implementation TalkViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self makeData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self makeData];
    
    [self setupViews];

}

-(void)makeData {
    
    self.talkArray = [NSMutableArray array];
    self.personInfoArray = [[NSMutableArray alloc] init];
    
    //UID:   FID:self.FID
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dictory setValue:self.FID forKey:@"FID"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/friend/getMsgList" success:^(NSMutableDictionary *dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            for (NSDictionary * dic in dict[@"data"]) {
                TalkModel * model = [TalkModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.talkArray addObject:model];
            }
            
//                NSLog(@"%@",self.talkArray);

        }else {
            NSLog(@"%@",dict[@"message"]);
        }
        //刷新UI
        [self.tableView reloadData];
        
        NSLog(@"%@", self.talkArray);
    } failed:^{
        NSLog(@"消息接受失败");
    }];

    
    //只加载一次对话人的信息
    //我的
    NSMutableDictionary * dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dic1 path:@"/user/getUserInfoByUID" success:^(NSMutableDictionary *dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.myModel = [TalkModel new];
            [self.myModel setValuesForKeysWithDictionary:dict[@"data"]];
           
        }else{
            [self showAlertWithString:dictory[@"message"]];
        }
            [self.tableView reloadData];
                            
        } failed:^{
            NSLog(@"数据加载出错");
        }];
    //别人的
    NSMutableDictionary * dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setValue:self.FID forKey:@"UID"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dic2 path:@"/user/getUserInfoByUID" success:^(NSMutableDictionary *dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.othersModel = [TalkModel new];
            [self.othersModel setValuesForKeysWithDictionary:dict[@"data"]];
            
        }else{
            [self showAlertWithString:dictory[@"message"]];
        }
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"数据加载出错");
    }];
    
}
-(void)setupViews {
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.tableView.userInteractionEnabled = YES;
    [self.tableView addGestureRecognizer:tap];
    
    [self.tableView registerClass:[MyTalkTableViewCell class] forCellReuseIdentifier:@"CELL_myTalk"];
    [self.tableView registerClass:[OthersTableViewCell class] forCellReuseIdentifier:@"CELL_others"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-100));
    }];
    
    

    
    //输入文本框
    self.inputView = [[UITextField alloc] init];
//    self.inputView.backgroundColor = [UIColor grayColor];
    self.inputView.delegate = self;
    [self.view addSubview:self.inputView];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(65));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-25));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];
    
    //textview的placeholder
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.placeholderLabel.font = [UIFont systemFontOfSize:15.f];
    self.placeholderLabel.numberOfLines = 2;
    //    self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
    self.placeholderLabel.text = @"写个小纸条给TA";
    self.placeholderLabel.textAlignment = NSTextAlignmentCenter;
    //    self.placeholderLabel.backgroundColor = [UIColor yellowColor];
    [self.inputView addSubview:self.placeholderLabel];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(315), SIZE_SCALE_IPHONE6(40)));
    }];
    

    //表情按钮
    UIButton * emotionButton = [[UIButton alloc] init];
    [emotionButton setImage:[UIImage imageNamed:@"iconfont-biaoqing"] forState:(UIControlStateNormal)];
    [self.view addSubview:emotionButton];
    
    [emotionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.inputView.mas_left).offset(SIZE_SCALE_IPHONE6(-5));
        make.bottom.mas_equalTo(self.inputView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(30), SIZE_SCALE_IPHONE6(30)));
    }];
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputView.mas_bottom);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(1)));
    }];
    
    //送礼
    UIButton * giftBt = [UIButton buttonWithType:(UIButtonTypeCustom)];
    giftBt.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [giftBt setTitle:@"送礼" forState:(UIControlStateNormal)];
    giftBt.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    giftBt.layer.masksToBounds = YES;
    [self.view addSubview:giftBt];
    
    [giftBt addTarget:self action:@selector(giftAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [giftBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
        make.right.mas_equalTo(self.view.mas_centerX).offset(SIZE_SCALE_IPHONE6(-20));
        make.top.mas_equalTo(self.inputView.mas_bottom).offset(SIZE_SCALE_IPHONE6(20));
    }];
    
    //留言
    UIButton * sendBt = [UIButton buttonWithType:(UIButtonTypeCustom)];
    sendBt.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [sendBt setTitle:@"发送" forState:(UIControlStateNormal)];
    sendBt.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    sendBt.layer.masksToBounds = YES;
    [self.view addSubview:sendBt];
    
    [sendBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
        make.left.mas_equalTo(self.view.mas_centerX).offset(SIZE_SCALE_IPHONE6(20));
        make.top.mas_equalTo(self.inputView.mas_bottom).offset(SIZE_SCALE_IPHONE6(20));
    }];
    
    [sendBt addTarget:self action:@selector(sendAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

//送礼
-(void)giftAction {
    
    OutletsViewController * outLetVC = [[OutletsViewController alloc] init];
    
    NSLog(@"%@", self.FID);
    outLetVC.FID = self.FID;
    outLetVC.justKind = 1;
    
    [self.navigationController pushViewController:outLetVC animated:YES];
    
}

//留言
-(void)sendAction {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    if([self.inputView.text isEqualToString:@""]){
        [self showAlertWithString:@"留言不能为空哦(⊙o⊙)"];
    }else{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dic setValue:self.FID forKey:@"FID"];
    [dic setValue:self.inputView.text forKey:@"content"];

    [[GXNetWorkManager shareInstance]getInfoWithInfo:dic path:@"/friend/newMsg" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            [self showAlertWithString:@"发送成功"];
            self.inputView.text = @"";
        }else {
//            [self showAlertWithString:dict[@"message"]];
            [MBProgressHUD showSuccess:dict[@"message"]];
        }
        
        [self makeData];
        
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"发送出错");
    }];
    
    }
    
    
}




//tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.talkArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //自动滚动到底部
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    TalkModel * model = [TalkModel new];
    model = self.talkArray[indexPath.row];
    
    if (!(model.msgFrom == [self.FID intValue])) {
        
        MyTalkTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_myTalk" forIndexPath:indexPath];
        //设置cell为不可点击状态
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,self.myModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        
        cell.nameLabel.text = self.myModel.UNickName;
        if([self.myModel.USex isEqualToString:@"00_011_2"]){
            cell.genderImv.image = [UIImage imageNamed:@"964"];
        }else{
            cell.genderImv.image = [UIImage imageNamed:@"963"];
            
        }
        cell.contentLabel.text = model.content;
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSDate * date = [formatter dateFromString:model.createtime];
        NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
        [formatter1 setDateFormat:@"yyyy/MM/dd hh:mm"];
        NSString * timeString = [formatter1 stringFromDate:date];
        
        cell.timeLabel.text = timeString;
        
        cell.headBT.UID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"];
        [cell.headBT addTarget:self action:@selector(personShow:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        return cell;
    }else {
        
        OthersTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_others" forIndexPath:indexPath];
        
        //设置cell为不可点击状态
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,self.othersModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        
        cell.nameLabel.text = self.othersModel.UNickName;
        if([self.othersModel.USex isEqualToString:@"00_011_2"]){
            cell.genderImv.image = [UIImage imageNamed:@"964"];
        }else{
            cell.genderImv.image = [UIImage imageNamed:@"963"];
            
        }
        
        cell.contentLabel.text = model.content;
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSDate * date = [formatter dateFromString:model.createtime];
        NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
        [formatter1 setDateFormat:@"yyyy/MM/dd hh:mm"];
        NSString * timeString = [formatter1 stringFromDate:date];
        
        cell.timeLabel.text = timeString;

        cell.headBT.UID = self.FID;
        [cell.headBT addTarget:self action:@selector(personShow:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }

    
}

//点击头像显示个人信息
-(void)personShow:(HeadButton *)sender {
    
    PersonShowViewController * showVC = [[PersonShowViewController alloc] init];
    
    showVC.UID = sender.UID;
    
    [self.navigationController pushViewController:showVC animated:YES];
}


//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(90);
}

////点击空白消失键盘
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.view endEditing:YES];
//}

-(void)tapAction {
    [self.view endEditing:YES];
}


//textField代理  屏幕偏移
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.inputView.text = textField.text;
        self.placeholderLabel.text = @"";
        
        CGRect frame = self.view.frame;
        frame.origin.y = -(216 + SIZE_SCALE_IPHONE6(30));
        self.view.frame = frame;
    }];
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
    
    return YES;
}

//点击return回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
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
