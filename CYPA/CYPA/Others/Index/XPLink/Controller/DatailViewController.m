//
//  DatailViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "DatailViewController.h"
#import "Header.h"
@interface DatailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView * datilyTableView;
@property(nonatomic, strong)UITableView * kindTableView;
@property(nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation DatailViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self makeDataWithCat_id:nil];
}

-(void)makeDataWithCat_id:(NSString *)catId {
    
    self.dataArray = [NSMutableArray array];
    //获取商家列表信息
//    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    
//    if([self.id isEqualToString:@"美食"]){
//        [dictory setValue:@"07_005_01" forKey:@"SubType"];
//    }else if([self.id isEqualToString:@"电影"]){
//        [dictory setValue:@"07_005_02" forKey:@"SubType"];
//    }else if([self.id isEqualToString:@"团购"]){
//        [dictory setValue:@"07_005_03" forKey:@"SubType"];
//    }else if([self.id isEqualToString:@"外卖"]){
//        [dictory setValue:@"07_005_04" forKey:@"SubType"];
//    }else if([self.id isEqualToString:@"旅行"]){
//        [dictory setValue:@"07_005_05" forKey:@"SubType"];
//    }else if([self.id isEqualToString:@"丽人"]){
//        [dictory setValue:@"07_005_06" forKey:@"SubType"];
//    }else if([self.id isEqualToString:@"购物"]){
//        [dictory setValue:@"07_005_07" forKey:@"SubType"];
//    }else if([self.id isEqualToString:@"出行"]){
//        [dictory setValue:@"07_005_08" forKey:@"SubType"];
//    }else{
//        [dictory setValue:@"07_005_09" forKey:@"SubType"];
//    }
    
    /*自己的后台*/
//    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/supplier/listByType" success:^(NSMutableDictionary * dict){
//        
////        NSLog(@"%@", dict);
//        if ([dict[@"code"] isEqualToString:@"0"]) {
//            for (NSDictionary * dic in dict[@"data"]) {
//                BussinessModel * model = [BussinessModel new];
//                [model setValuesForKeysWithDictionary:dic];
//                [self.dataArray addObject:model];
//            }
//            
//        }else {
//            [self showAlertWithString:dict[@"message"]];
//        }
//        
//        [self.datilyTableView reloadData];
//        
//    } failed:^{
//        [self showAlertWithString:@"数据加载出错"];
//    }];
    
    if([self.id isEqualToString:@"美食"]){
        catId = @"cat_ids=326";
    }else if([self.id isEqualToString:@"电影"]){
        catId = @"cat_ids=323&subcat_ids=345";
    }else if([self.id isEqualToString:@"团购"]){
        catId = @"cat_ids=320";
    }else if([self.id isEqualToString:@"外卖"]){
//        catId = @"cat_ids=326";
        
    }else if([self.id isEqualToString:@"旅行"]){
        catId = @"cat_ids=377";
    }else if([self.id isEqualToString:@"丽人"]){
        catId = @"cat_ids=323&subcat_ids=956";
    }else if([self.id isEqualToString:@"购物"]){
        catId = @"cat_ids=316&subcat_ids=875";
    }else if([self.id isEqualToString:@"出行"]){
        catId = @"cat_ids=377";
    }else{
        catId = @"cat_ids=316";
    }

    NSString *httpUrl = @"http://apis.baidu.com/baidunuomi/openapi/searchshops";
    NSString *httpArg = [NSString stringWithFormat:@"city_id=100010000&%@", catId];
//    NSString *httpArg = @"city_id=100010000&page_size=40&cat_ids=316";
    [self request: httpUrl withHttpArg: httpArg];
    
    
}


//-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
//    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
//    NSURL *url = [NSURL URLWithString: urlStr];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
//    [request setHTTPMethod: @"GET"];
//    [request addValue: @"217d2d19426e04caec19d62c16606203" forHTTPHeaderField: @"apikey"];
//    [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
//        if (error) {
//            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
//        } else {
//        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"HttpResponseCode:%ld", responseCode);
//        NSLog(@"HttpResponseBody %@",responseString);
//        }
//    }];
//}

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"217d2d19426e04caec19d62c16606203" forHTTPHeaderField: @"apikey"];
    
    [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue]completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
        if (error) {
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        } else {
            NSDictionary * dictory = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            if ([dictory[@"errno"] intValue] != 1005) {
                for (NSDictionary * dic in dictory[@"data"][@"shops"]) {
                    
                    BussinessModel * model = [[BussinessModel alloc] init];
                    [model setValue:dic[@"shop_name"] forKey:@"shop_name"];
                    [model setValue:dic[@"shop_url"] forKey:@"shop_url"];
                    
                    NSDictionary * dic1 = dic[@"deals"][0];
                    [model setValue:dic1[@"description"] forKey:@"Description"];
                    [model setValue:dic1[@"sale_num"] forKey:@"sale_num"];
                    [model setValue:dic1[@"image"] forKey:@"image"];
                    
                    [self.dataArray addObject:model];
                    
                }
            }
            
            
        }
        
        [self.datilyTableView reloadData];
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //datilyTableView
    self.datilyTableView = [[UITableView alloc] init];
    self.datilyTableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    self.datilyTableView.tag = 1000;
    self.datilyTableView.separatorStyle = UITableViewStylePlain;
    self.datilyTableView.delegate = self;
    self.datilyTableView.dataSource = self;

    
    [self.view addSubview:self.datilyTableView];
    
    [self.datilyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    //注册
    [self.datilyTableView registerClass:[DatailTableViewCell class] forCellReuseIdentifier:@"CELL_datail"];

    //种类
    self.kindLabel = [[UILabel alloc] init];
    self.kindLabel.text = self.id;
    self.kindLabel.font = [UIFont systemFontOfSize:18];
    self.kindLabel.textAlignment = NSTextAlignmentCenter;
    self.kindLabel.textColor = [UIColor whiteColor];
//    self.kindLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.kindLabel];

    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_top).offset(SIZE_SCALE_IPHONE6(15));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(15)));
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kindSelectAction)];
    self.kindLabel.userInteractionEnabled = YES;
    [self.kindLabel addGestureRecognizer:tap];
    
    
    
    //下拉按钮
    self.kindButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.kindButton setImage:[UIImage imageNamed:@"800"] forState:normal];
//    self.kindButton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.kindButton];
    [self.kindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.kindLabel.mas_top);
        make.left.mas_equalTo(self.kindLabel.mas_right).offset(SIZE_SCALE_IPHONE6(12));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(21), SIZE_SCALE_IPHONE6(15)));
    }];
    [self.kindButton addTarget:self action:@selector(kindSelectAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //种类tableView
    self.kindTableView = [[UITableView alloc] init];
    self.kindTableView.tag = 2000;
    self.kindTableView.separatorStyle = UITableViewStylePlain;
    self.kindTableView.delegate = self;
    self.kindTableView.dataSource = self;
    self.kindTableView.hidden = YES;
    [self.view addSubview:self.kindTableView];
    
    [self.kindTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    [self.kindTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(self.kindLabel.mas_left);
        make.right.mas_equalTo(self.kindButton.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(225));
    }];
    
}

//种类选择
-(void)kindSelectAction{
    if(self.kindTableView.hidden == YES) {
        self.kindTableView.hidden = NO;
    }else {
        self.kindTableView.hidden = YES;
    }
}

#pragma mark tableView delegate datasourse

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView.tag == 1000) {
        return self.dataArray.count;
    }else {
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1000) {
        return 1;
    }else{
        return 9;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1000) {
        
        DatailTableViewCell * cell = [self.datilyTableView dequeueReusableCellWithIdentifier:@"CELL_datail" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        /*自己的后台*/
//        [cell.showImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,model.Pic]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
//        cell.nameLabel.text = model.Name;
//        cell.introduceLabel.text = model.SupDesc;
//        cell.telLabel.text = model.ContactPhone;
        if (self.dataArray.count != 0) {
            BussinessModel * model = [BussinessModel new];
            model = self.dataArray[indexPath.section];
            cell.nameLabel.text = model.shop_name;
            [cell.showImv sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:placeholdPicture]];
            cell.introduceLabel.text = model.Description;
            cell.numLabel.text = [NSString stringWithFormat:@"已售量：%@", model.sale_num];
        }
        
        
        return cell;
    } else {
        UITableViewCell * cell = [self.kindTableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        NSArray * array = @[@"美食", @"电影", @"团购",@"外卖", @"旅行", @"丽人", @"购物", @"出行", @"生活服务"];
        cell.textLabel.text = array[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 1000) {
        return SIZE_SCALE_IPHONE6(5);
    }else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 2000) {
        NSArray * array = @[@"美食", @"电影", @"团购",@"外卖", @"旅行", @"丽人", @"购物", @"出行", @"生活服务"];
        self.id = array[indexPath.row];
        self.kindLabel.text = self.id;

        [self makeDataWithCat_id:nil];
        
        self.kindTableView.hidden = YES;
    }else {
        
        //点击datailTableView
        BussinessModel * model = self.dataArray[indexPath.section];
        LinkWebViewController * linkVC = [[LinkWebViewController alloc] init];
        linkVC.aUrl = model.shop_url;
        [self.navigationController pushViewController:linkVC animated:YES];
        
        
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1000) {
        return SIZE_SCALE_IPHONE6(108);
    }else{
        return SIZE_SCALE_IPHONE6(25);
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
