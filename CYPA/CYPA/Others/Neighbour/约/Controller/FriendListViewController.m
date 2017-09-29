//
//  FriendListViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/11.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "FriendListViewController.h"
#import "Header.h"
@interface FriendListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)NSMutableArray * friendArray;
@property(nonatomic, strong)UITableView * tableView;

@end

@implementation FriendListViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self makeData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setupViews];

}

-(void)makeData {

    self.friendArray = [NSMutableArray array];
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dictory setValue:self.GroupID forKey:@"GroupID"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]);
    NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/group/getFriendList" success:^(NSMutableDictionary * dict) {
        
        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            for (NSDictionary * dic in dict[@"data"]) {
                TalkModel * model = [TalkModel new];
                [model setValuesForKeysWithDictionary:dic];

                [self.friendArray addObject:model];
            }
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"数据加载出错");
    }];

    
}

-(void)setupViews {
 
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[FriendTableViewCell class] forCellReuseIdentifier:@"CELL_friend"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

}

//tableView  delegate datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.friendArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    FriendTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_friend" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    TalkModel * model = self.friendArray[indexPath.section];
    [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,model.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    cell.nameLabel.text = model.UNickName;
    cell.ageLabel.text = model.UAge;
    cell.constellationLabel.text = model.UConstellation;
    cell.areaLabel.text = model.Area;
    
    cell.inviteBT.UID = [NSString stringWithFormat:@"%@", model.UID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //判断活动状态
    if (model.State == 1) {
        [cell.inviteBT setTitle:@"已参加" forState:(UIControlStateNormal)];
        cell.inviteBT.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        cell.inviteBT.userInteractionEnabled = NO;
    }else if(model.State == 0){
        [cell.inviteBT setTitle:@"邀请" forState:(UIControlStateNormal)];
        cell.inviteBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
        
        cell.inviteBT.userInteractionEnabled = YES;
        
        
    }
    
    [cell.inviteBT addTarget:self action:@selector(inviteAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    return cell;
    
}

//邀请
-(void)inviteAction:(HeadButton *)sender {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:sender.UID forKey:@"FID"];
    [dictory setValue:self.GroupID forKey:@"GroupID"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/group/invite" success:^(NSMutableDictionary * dict) {
        
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            [self showAlertWithString:dict[@"message"]];
            
//            
//            [sender setTitle:@"已邀请" forState:(UIControlStateNormal)];
//            sender.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
//            sender.userInteractionEnabled = NO;
            
            [self.tableView reloadData];

            }else{
                [self showAlertWithString:dict[@"message"]];
            }
                    

    } failed:^{
        NSLog(@"加载出错");
    }];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(90);
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
