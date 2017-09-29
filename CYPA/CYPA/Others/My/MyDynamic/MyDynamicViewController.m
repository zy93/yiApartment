//
//  MyDynamicViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/17.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MyDynamicViewController.h"
#import "Header.h"

@interface MyDynamicViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView * tableView;

@end

@implementation MyDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViews];

    
}

-(void)setupViews{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[FunctionTableViewCell class] forCellReuseIdentifier:@"CELL_function"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    

}

//tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FunctionTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_function" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSArray * textArray = @[@"我的晒", @"我的敲", @"我的约"];
    NSArray * picArray = @[@"iconfont-iconfontxiangce1", @"iconfont-2tianjiahaoyou", @"iconfont-huodong"];
    
    cell.functionImv.image = [UIImage imageNamed:picArray[indexPath.section]];
    cell.functionLabel.text = textArray[indexPath.section];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(50);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            MyShowViewController * showVC = [[MyShowViewController alloc] init];
            [self.navigationController pushViewController:showVC animated:YES];
            
            break;
        }
        case 1:{
            MyKnockViewController * knockVC = [[MyKnockViewController alloc] init];
            [self.navigationController pushViewController:knockVC animated:YES];
            
            break;
        }
        case 2:{
            MyTrystViewController * trystVC = [[MyTrystViewController alloc] init];
            [self.navigationController pushViewController:trystVC animated:YES];
            
            break;
        }
        default:
            break;
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
