//
//  IntelligenceViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "IntelligenceViewController.h"
#import "Header.h"

@interface IntelligenceViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, assign)NSInteger select1;
@property(nonatomic, assign)NSInteger select2;
@property(nonatomic, assign)NSInteger select3;
@property(nonatomic, assign)NSInteger select4;
@end

@implementation IntelligenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backBT.hidden = YES;
    //判断button的当前图片
    self.select1 = 0;
    self.select2 = 0;
    self.select3 = 0;
    self.select4 = 0;
    
    self.tableView = [[UITableView alloc] init];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
   
    self.tableView.separatorStyle = UITableViewStylePlain;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-44));
        
    }];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    [self.tableView registerClass:[LockTitleTableViewCell class] forCellReuseIdentifier:@"CELL_lockTitle"];
    [self.tableView registerClass:[LockTableViewCell class] forCellReuseIdentifier:@"CELL_lock"];
    [self.tableView registerClass:[ConditionTitleTableViewCell class] forCellReuseIdentifier:@"CELL_conditionTitle"];
    [self.tableView registerClass:[ConditionTableViewCell class] forCellReuseIdentifier:@"CELL_condition"];
    [self.tableView registerClass:[PowerTableViewCell class] forCellReuseIdentifier:@"CELL_power"];
    [self.tableView registerClass:[LightTableViewCell class] forCellReuseIdentifier:@"CELL_light"];
    [self.tableView registerClass:[CurtainTableViewCell class] forCellReuseIdentifier:@"CELL_curtain"];

}


#pragma tableView delegate dataSourse
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 2;
    }else {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LockTitleTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_lockTitle" forIndexPath:indexPath];
            [cell.historyBT addTarget:self action:@selector(historyAction) forControlEvents:(UIControlEventTouchUpInside)];

            return cell;
            
        }else {
            LockTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_lock" forIndexPath:indexPath];
            return cell;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ConditionTitleTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_conditionTitle" forIndexPath:indexPath];
            [cell.changeBT setImage:[UIImage imageNamed:@"组-989"] forState:(UIControlStateNormal)];

            [cell.changeBT addTarget:self action:@selector(changeImage1:) forControlEvents:(UIControlEventTouchUpInside)];
            
            return cell;
            
        }else {
            ConditionTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_condition" forIndexPath:indexPath];
            
            return cell;
        }
    }else if (indexPath.section == 2) {
        PowerTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_power" forIndexPath:indexPath];
        [cell.changeBT setImage:[UIImage imageNamed:@"组-989"] forState:(UIControlStateNormal)];
        
        [cell.changeBT addTarget:self action:@selector(changeImage2:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }else if (indexPath.section == 3) {
        CurtainTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_curtain" forIndexPath:indexPath];
        [cell.changeBT setImage:[UIImage imageNamed:@"组-989"] forState:(UIControlStateNormal)];
        
        [cell.changeBT addTarget:self action:@selector(changeImage3:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }else if (indexPath.section == 4) {
        LightTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_light" forIndexPath:indexPath];
        [cell.changeBT setImage:[UIImage imageNamed:@"组-989"] forState:(UIControlStateNormal)];
        
        [cell.changeBT addTarget:self action:@selector(changeImage4:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"更多";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
        
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
//cell行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        if (indexPath.row == 0) {
            return SIZE_SCALE_IPHONE6(40);
        }else {
            return SIZE_SCALE_IPHONE6(160);
        }
    }else if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        return SIZE_SCALE_IPHONE6(50);
        
    }else if (indexPath.section == 5) {
        return SIZE_SCALE_IPHONE6(50);
    }
    else {
//        return 100;
    }
    
    return 0;
}

//cell上的button点击
-(void)historyAction {

    LockHistoryViewController * historyVC = [[LockHistoryViewController alloc] init];
    [self.navigationController pushViewController:historyVC animated:YES];
    
}

//开关换图片
-(void)changeImage1:(UIButton *)aButton{

    if (self.select1 == 0) {
        [aButton setImage:[UIImage imageNamed:@"组-989"] forState:(UIControlStateNormal)];
        self.select1 = 1;
    } else if (self.select1 == 1){
        [aButton setImage:[UIImage imageNamed:@"组-990"] forState:(UIControlStateNormal)];
        self.select1 = 0;
    }
}

-(void)changeImage2:(UIButton *)aButton{
    
    if (self.select2 == 0) {
        [aButton setImage:[UIImage imageNamed:@"组-989"] forState:(UIControlStateNormal)];
        self.select2 = 1;
    } else if (self.select2 == 1){
        [aButton setImage:[UIImage imageNamed:@"组-990"] forState:(UIControlStateNormal)];
        self.select2 = 0;
    }
}

-(void)changeImage3:(UIButton *)aButton{
    
    if (self.select3 == 0) {
        [aButton setImage:[UIImage imageNamed:@"组-989"] forState:(UIControlStateNormal)];
        self.select3 = 1;
    } else if (self.select3 == 1){
        [aButton setImage:[UIImage imageNamed:@"组-990"] forState:(UIControlStateNormal)];
        self.select3 = 0;
    }
}

-(void)changeImage4:(UIButton *)aButton{
    
    if (self.select4 == 0) {
        [aButton setImage:[UIImage imageNamed:@"组-989"] forState:(UIControlStateNormal)];
        self.select4 = 1;
    } else if (self.select4 == 1){
        [aButton setImage:[UIImage imageNamed:@"组-990"] forState:(UIControlStateNormal)];
        self.select4 = 0;
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
