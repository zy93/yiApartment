//
//  SettingChoiseViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/24.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "SettingChoiseViewController.h"
#import "Header.h"

@interface SettingChoiseViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView * tableView;

@end

@implementation SettingChoiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.textLabel.font = [UIFont systemFontOfSize:15];
    NSArray * array = @[@"个人信息", @"账户安全"];
    cell.textLabel.text = array[indexPath.section];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PersonSettingViewController * settingVC = [[PersonSettingViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
        
    }else{
        PassWordChoisceViewController * passVC = [[PassWordChoisceViewController alloc] init];
        [self.navigationController pushViewController:passVC animated:YES];
    }
    
}


//4009918080


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
