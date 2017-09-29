//
//  BusinessJoinViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/1.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BusinessJoinViewController.h"
#import "Header.h"

@interface BusinessJoinViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UILabel * kindLabel;
@property(nonatomic, strong)UIButton * kindButton;
@property(nonatomic, strong)UITableView * kindTableView;
@property(nonatomic, strong)UITextField * companyTF;
@property(nonatomic, strong)UITextField * nameTF;
@property(nonatomic, strong)UITextField * phoneTF;
@property(nonatomic, strong)UITextField * emailTF;
@property(nonatomic, strong)UITextField * thingsTF;
@property(nonatomic, strong)UIButton * submitBT;


@end

@implementation BusinessJoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    [self setupViews];


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
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(109));
    }];
    //标题
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"商家合作";
    titleLabel.font = [UIFont systemFontOfSize:18.f];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(10));
        make.centerX.mas_equalTo(topView.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];
    
    UILabel * noteLabel = [[UILabel alloc] init];
    noteLabel.text = @"请留下您的信息及合作事项，我们会尽快回复。";
    noteLabel.font = [UIFont systemFontOfSize:15.f];
    noteLabel.numberOfLines = 0;
//    noteLabel.backgroundColor = [UIColor yellowColor];
    noteLabel.textAlignment = NSTextAlignmentCenter;
    noteLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [topView addSubview:noteLabel];
    
    [noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(45));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-45));
        make.bottom.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(-10));
    }];
    

    //下部View
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(14));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    //合作类型
    UILabel * patterKindLabel = [[UILabel alloc] init];
    patterKindLabel.text = @"合作类型:";
    patterKindLabel.font = [UIFont systemFontOfSize:15.f];
    patterKindLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [bottomView addSubview:patterKindLabel];
    
    [patterKindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(14));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(25));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
    
    self.kindLabel = [[UILabel alloc] init];
    self.kindLabel.layer.borderWidth = 0.5;
    self.kindLabel.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:self.kindLabel];
    
    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(patterKindLabel.mas_top);
        make.left.mas_equalTo(patterKindLabel.mas_right).offset(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(SIZE_SCALE_IPHONE6(-56)));
        make.height.mas_equalTo(patterKindLabel.mas_height);
    }];
    
    //下拉菜单
    
    //下拉按钮
    self.kindButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.kindButton.backgroundColor = [UIColor yellowColor];
    [self.kindButton setImage:[UIImage imageNamed:@"组-987"] forState:normal];
    //    self.kindButton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.kindButton];
    [self.kindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.kindLabel.mas_top);
        make.right.mas_equalTo(self.kindLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(25), SIZE_SCALE_IPHONE6(25)));
    }];
    [self.kindButton addTarget:self action:@selector(kindSelectAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    

    //单位名称
    UILabel * companyLabel = [[UILabel alloc] init];
    companyLabel.text = @"单位名称:";
    companyLabel.font = [UIFont systemFontOfSize:15.f];
    companyLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [bottomView addSubview:companyLabel];
    
    [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(patterKindLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(patterKindLabel.mas_left);
        make.size.mas_equalTo(patterKindLabel);
    }];
    
    self.companyTF = [[UITextField alloc] init];
    self.companyTF.layer.borderWidth = 0.5;
    self.companyTF.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:self.companyTF];
    
    [self.companyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(companyLabel.mas_top);
        make.left.mas_equalTo(companyLabel.mas_right).offset(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(SIZE_SCALE_IPHONE6(-56)));
        make.height.mas_equalTo(companyLabel.mas_height);
    }];

    
    //姓名
    UILabel * nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"姓名:";
    nameLabel.font = [UIFont systemFontOfSize:15.f];
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [bottomView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(companyLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(patterKindLabel.mas_left);
        make.size.mas_equalTo(patterKindLabel);

    }];
    
    self.nameTF = [[UITextField alloc] init];
    self.nameTF.layer.borderWidth = 0.5;
    self.nameTF.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:self.nameTF];
    
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_top);
        make.left.mas_equalTo(nameLabel.mas_right).offset(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(SIZE_SCALE_IPHONE6(-56)));
        make.height.mas_equalTo(nameLabel.mas_height);
    }];
    
    //联系电话
    UILabel * phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"联系电话:";
    phoneLabel.font = [UIFont systemFontOfSize:15.f];
    phoneLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [bottomView addSubview:phoneLabel];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(patterKindLabel.mas_left);
        make.size.mas_equalTo(patterKindLabel);
        
    }];
    
    self.phoneTF = [[UITextField alloc] init];
    self.phoneTF.layer.borderWidth = 0.5;
    self.phoneTF.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:self.phoneTF];
    
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel.mas_top);
        make.left.mas_equalTo(phoneLabel.mas_right).offset(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(SIZE_SCALE_IPHONE6(-56)));
        make.height.mas_equalTo(phoneLabel.mas_height);
    }];
    
    //邮箱
    UILabel * emailLabel = [[UILabel alloc] init];
    emailLabel.text = @"邮箱:";
    emailLabel.font = [UIFont systemFontOfSize:15.f];
    emailLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [bottomView addSubview:emailLabel];
    
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(patterKindLabel.mas_left);
        make.size.mas_equalTo(patterKindLabel);
        
    }];
    
    self.emailTF = [[UITextField alloc] init];
    self.emailTF.layer.borderWidth = 0.5;
    self.emailTF.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:self.emailTF];
    
    [self.emailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(emailLabel.mas_top);
        make.left.mas_equalTo(emailLabel.mas_right).offset(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(SIZE_SCALE_IPHONE6(-56)));
        make.height.mas_equalTo(emailLabel.mas_height);
    }];
    

    //具体事项
    UILabel * thingsLabel = [[UILabel alloc] init];
    thingsLabel.text = @"具体事项:";
    thingsLabel.font = [UIFont systemFontOfSize:15.f];
    thingsLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [bottomView addSubview:thingsLabel];
    
    [thingsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(emailLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(emailLabel.mas_left);
        make.size.mas_equalTo(emailLabel);
        
    }];
    
    self.thingsTF = [[UITextField alloc] init];
    self.thingsTF.layer.borderWidth = 0.5;
    self.thingsTF.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:self.thingsTF];
    
    [self.thingsTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(thingsLabel.mas_top);
        make.left.mas_equalTo(thingsLabel.mas_right).offset(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(SIZE_SCALE_IPHONE6(-56)));
        make.height.mas_equalTo(thingsLabel.mas_height);
    }];
    
    //提交按钮
    self.submitBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.submitBT.backgroundColor = [UIColor redColor];
    self.submitBT.layer.cornerRadius = 3;
    self.submitBT.layer.masksToBounds = YES;
    [self.submitBT setTitle:@"提交" forState:(UIControlStateNormal)];
//    self.submitBT.titleLabel.font = [UIFont systemFontOfSize:<#(CGFloat)#>]
    [self.view addSubview:self.submitBT];
    
    [self.submitBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(thingsLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(25)));
    }];

    [self.submitBT addTarget:self action:@selector(submitAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //种类tableView
    self.kindTableView = [[UITableView alloc] init];
    self.kindTableView.separatorStyle = UITableViewStylePlain;
    //    self.kindTableView.backgroundColor = [UIColor yellowColor];
    self.kindTableView.delegate = self;
    self.kindTableView.dataSource = self;
    self.kindTableView.hidden = YES;
    [self.view addSubview:self.kindTableView];
    
    [self.kindTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    [self.kindTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.kindLabel.mas_bottom);
        make.right.mas_equalTo(self.kindButton.mas_right);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(100), SIZE_SCALE_IPHONE6(225)));
    }];

    
    
}

//点击提交
-(void)submitAction{
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:self.kindLabel.text forKey:@"SubType"];
    [dictory setValue:self.companyTF.text forKey:@"Name"];
    [dictory setValue:self.nameTF.text forKey:@"Contact"];
    [dictory setValue:self.phoneTF.text forKey:@"ContactPhone"];
    [dictory setValue:self.emailTF.text forKey:@"Email"];
    [dictory setValue:self.thingsTF.text forKey:@"SupDesc"];


    if (self.kindLabel.text.length == 0 || self.companyTF.text.length == 0 || self.nameTF.text.length == 0 || self.phoneTF.text.length == 0 || self.emailTF.text.length == 0 || self.thingsTF.text.length == 0) {
        
        [self showAlert:@"请补全信息"];
    }else{
    
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/supplier/new" success:^(NSMutableDictionary * dict){
        
        //        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            [self showAlertAndBackWithString:dict[@"message"]];
            
        }else {
            [self showAlert:dict[@"message"]];
        }
        
        
    } failed:^{
        [self showAlert:@"数据加载出错"];
    }];

    
    }
}

//下拉菜单
-(void)kindSelectAction{
    if(self.kindTableView.hidden == YES) {
        self.kindTableView.hidden = NO;
    }else {
        self.kindTableView.hidden = YES;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell * cell = [self.kindTableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        NSArray * array = @[@"美食", @"电影", @"团购",@"外卖", @"旅行", @"丽人", @"购物", @"出行", @"生活服务"];
        cell.textLabel.text = array[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        return cell;
  
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        NSArray * array = @[@"美食", @"电影", @"团购",@"外卖", @"旅行", @"丽人", @"购物", @"出行", @"生活服务"];
//        self.id = array[indexPath.row];
//        self.kindLabel.text = self.id;
//        NSLog(@"%@", self.id);
        self.kindLabel.text = array[indexPath.row];
        self.kindTableView.hidden = YES;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SIZE_SCALE_IPHONE6(25);

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
