//
//  PersonShowViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/16.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "PersonShowViewController.h"
#import "Header.h"
#import "PersonIntroduceCell.h"

@interface PersonShowViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UPerson * pModel;
//@property(nonatomic, strong)UILabel *addrLabel2;
//@property(nonatomic, strong)UILabel *introLabel2;
//@property(nonatomic, strong)UILabel *homeLabel2;
//@property(nonatomic, strong)UILabel *hobbyLabel2;

//个人动态展示数组
@property(nonatomic, strong)NSMutableArray * personShowDataArray;

@end

@implementation PersonShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeData];
    [self setupViews];


}

-(void)makeData {
    
    self.personShowDataArray = [NSMutableArray array];
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:self.UID forKey:@"UID"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/getUserShow" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.pModel = [UPerson new];
            [self.pModel setValuesForKeysWithDictionary:dict[@"data"]];
            
            for (NSDictionary * dic in dict[@"data"][@"Show"]) {
                UPerson * showModel = [UPerson new];
                [showModel setValuesForKeysWithDictionary:dic];
                [self.personShowDataArray addObject:showModel];
            }

        }else{
            [MBProgressHUD showSuccess:@"加载出错"];
            NSLog(@"加载出错");
        }
        //刷新UI
        [self.tableView reloadData];
        
    } failed:^{
        NSLog(@"加载数据出错");
    }];
    
}

-(void)setupViews {
    //个人动态
    self.tableView = [[UITableView alloc] init];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[PersonShowTableViewCell class] forCellReuseIdentifier:@"CELL_show"];
    [self.tableView registerClass:[PersonDetailTableViewCell class] forCellReuseIdentifier:@"CELL_intro"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}

-(void)knockAction {
    
    TalkViewController * talkVC = [[TalkViewController alloc] init];
    
    talkVC.FID = self.pModel.UID;
    
    [self.navigationController pushViewController:talkVC animated:YES];
    
}

-(void)showBigPicture{
    
    PictureViewController * pictureVC = [[PictureViewController alloc] init];

    pictureVC.aString = [NSString stringWithFormat:@"%@%@", BaseImageURL,self.pModel.UHeadPortrait];
    [self presentViewController:pictureVC animated:YES completion:nil];
    

    
}

//tableview的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.personShowDataArray.count + 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 4;
    }else{
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE_SCALE_IPHONE6(5);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        PersonIntroduceCell * cell = [[PersonIntroduceCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.personModel = self.pModel;
        
        //敲门
        [cell.knockBT addTarget:self action:@selector(knockAction) forControlEvents:(UIControlEventTouchUpInside)];
        //点击头像查看大图
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)];
        cell.headImv.userInteractionEnabled = YES;
        [cell.headImv addGestureRecognizer:tap];
        
        
        return cell;
    }
    else if (indexPath.section == 1) {
        
        PersonDetailTableViewCell * cell = [[PersonDetailTableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSArray * array = @[@"地址", @"签名", @"家乡", @"兴趣爱好"];
        cell.introLabel.text = array[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:
                cell.detailLabel.text = self.pModel.ApartmentName;
                break;
            case 1:
                cell.detailLabel.text = self.pModel.USignaTure;
                break;
            case 2:
                cell.detailLabel.text = self.pModel.UHome;
                break;
            case 3:
                cell.detailLabel.text = self.pModel.UHobby;
                break;
            default:
                break;
        }
        return cell;
        
    }else{
    
    PersonShowTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_show" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    UPerson * model = self.personShowDataArray[indexPath.section-2];
    
//    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    NSDate * date = [formatter dateFromString:model.CreateTime];
//    NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
//    [formatter1 setDateFormat:@"yyyy/MM/dd"];
//    NSString * timeString = [formatter1 stringFromDate:date];
    
    NSString * timeString = [model.CreateTime substringToIndex:10];
        
    cell.timeLabel.text = timeString;
    cell.showContent.text = model.ShowCont;
//    cell.imageString = model.ShowPic;
    NSArray * array = [model.ShowPic componentsSeparatedByString:@";"];
    [cell setCellImageWithArray:array];
    
    return cell;
    }

}


//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return SIZE_SCALE_IPHONE6(187);
    }
    else if(indexPath.section == 1){
        return SIZE_SCALE_IPHONE6(50);
    }
    else{
//        return SIZE_SCALE_IPHONE6(167.5);
        PersonShowTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL_show"];
        
        [cell cellAutoLayoutHeight:cell.showContent.text];
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
        return size.height + SIZE_SCALE_IPHONE6(100);
        
    }
}
//选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section != 0){
    
    UPerson * model = [UPerson new];
    model = self.personShowDataArray[indexPath.section-2];
    model.UHeadPortrait = self.pModel.UHeadPortrait;
    model.USex = self.pModel.USex;
    model.UNickName = self.pModel.UNickName;
    model.Area = self.pModel.Area;
    
    ShowDetailViewController * showVC = [[ShowDetailViewController alloc] init];
    showVC.personModel = model;
    
    [self.navigationController pushViewController:showVC animated:YES];
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
