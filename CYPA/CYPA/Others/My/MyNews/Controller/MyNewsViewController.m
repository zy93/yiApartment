//
//  MyNewsViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/20.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MyNewsViewController.h"
#import "Header.h"
@interface MyNewsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation MyNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self makeData];
    [self setupViews];
    
//    [self writeToFile];

}

//-(void)writeToFile {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ; //得到documents的路径，为当前应用程序独享
//    NSString *documentD = [paths objectAtIndex:0];
//    NSString *configFile = [documentD stringByAppendingPathComponent:@"news.plist"]; //得到documents目录下dujw.plist配置文件的路径
//    NSMutableDictionary *configList =[[NSMutableDictionary alloc] initWithContentsOfFile:configFile];  //初始化字典，读取配置文件的信息
//    //NSMutableDictionary *configList =[[NSMutableDictionary alloc] dictionaryWithContentsOfFile:configFile];
//    
//    //第二：写入文件file
//    if (!configList) {          //第一次，文件没有创建，因此要创建文件，并写入相应的初始值。
//    
//    configList = [[NSMutableDictionary alloc] init];
//    
//    [configList writeToFile:configFile atomically:YES];
//    
//    }
//    
//    [configList writeToFile:configFile atomically:YES];
//
//}

-(void)makeData {
    
    self.dataArray = [NSMutableArray array];
    
    NSMutableDictionary * dictory = [[NSMutableDictionary alloc] init];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/msg/listMySysMsg" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
//                        NSLog(@"%@", dict);
            for (NSDictionary * dic in dict[@"data"]) {
                NewsModel * model = [NewsModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
                
                NSFileManager *fm = [NSFileManager defaultManager];
                
                NSArray * arr = [[NSArray alloc] initWithObjects: model, nil];
                NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *filePath = [path stringByAppendingPathComponent:@"news.plist"];
                [fm createFileAtPath:filePath contents:nil attributes:nil];
                
                [arr writeToFile:filePath atomically:YES];

                NSLog(@"this is filePath : %@",filePath); 

            }
            
            //数据刷新
            [self.tableView reloadData];
        }else{
            [self showAlertWithString:@"获取数据失败"];
        }
    } failed:^{
        [self showAlertWithString:@"获取数据失败"];
        
    }];
    
}

-(void)setupViews {
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerClass:[MyNewsTableViewCell class] forCellReuseIdentifier:@"CELL_news"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NewsModel * model = [NewsModel new];
//    model = self.dataArray[indexPath.section];
//    
//    MyNewsTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_news" forIndexPath:indexPath];
//    cell.contentLabel.text = model.Content;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    return cell;
    
    NewsModel * model = [NewsModel new];
    model = self.dataArray[indexPath.section];
    
    MyNewsTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_news" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentLabel.text = model.Content;
    
    cell.expandButton.hidden = YES;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel * model = [NewsModel new];
    model = self.dataArray[indexPath.section];
    
    CGSize titleSize = [model.Content boundingRectWithSize:CGSizeMake(SIZE_SCALE_IPHONE6(315), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return titleSize.height + 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE_SCALE_IPHONE6(5);
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
