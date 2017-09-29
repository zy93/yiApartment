//
//  ActivityDetailViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/10.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "Header.h"
#import "MBProgressHUD+Add.h"

@interface ActivityDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)UIImageView * headImv;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UIImageView * genderImv;
@property (nonatomic,strong)UILabel * ageLabel;
@property(nonatomic, strong)UIButton * joinBT;
@property(nonatomic, strong)UIButton * inviteBT;
@property(nonatomic, strong)TrystModel * detailModel;
@property(nonatomic, strong)NSMutableArray * personArray;
@property(nonatomic, strong)UICollectionView * pictureCollectionView;
@property(nonatomic, strong)UICollectionView * personCollectionView;
@property(nonatomic, strong)NSArray * picArray;

@property(nonatomic, strong)UILabel *activeLabel;
@property(nonatomic, strong)UIImageView * placeImv;
@property(nonatomic, strong)UILabel * placeLabel;
@property(nonatomic, strong)UIImageView * timeImv;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)TopLabel * introLabel;
@property(nonatomic, strong)UILabel * numLabel;
@property(nonatomic, strong)NSMutableArray *perArray;
@property(nonatomic, strong)NSMutableArray *personID; //参加人员
@property(nonatomic, assign)BOOL isJoinIn; //是否参加



@end

@implementation ActivityDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self makeData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self makeData];
    
    [self setupViews];


}

-(void)makeData {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    
//    NSNumber *number = [NSNumber numberWithInt:self.GroupID];
    NSLog(@"%@", self.GroupID);
    
    [dictory setValue:self.GroupID forKey:@"GroupID"];
    
    self.perArray = [[NSMutableArray alloc] init];
    self.personID = [[NSMutableArray alloc] init];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/group/detail" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.detailModel = [TrystModel new];
            [self.detailModel setValuesForKeysWithDictionary:dict[@"data"]];
            
//            NSLog(@"%@", dict[@"data"]);
//            NSLog(@"%@", self.detailModel.UHeadPortrait);
            
            for (NSDictionary * dic in dict[@"data"][@"Person"]) {
                UPerson * person = [UPerson new];
                [person setValuesForKeysWithDictionary:dic];
                //参与人照片
                [self.perArray addObject: person.UHeadPortrait];
                [self.personID addObject:dic[@"UID"]];
//                NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]);
                NSLog(@"%@", person.UID);
//                判断自己是否已参加
                if ([person.UID intValue] == [[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] intValue]) {
                    self.isJoinIn = YES;
                    [self.joinBT setTitle:@"已加入" forState:(UIControlStateNormal)];
                    self.joinBT.enabled = NO;
                }
                
                [self.personArray addObject:person];
            }
            
            //设置
            [_headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,self.detailModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
            
            _nameLabel.text = self.detailModel.Admin;
            
            if ([self.detailModel.USex isEqualToString: @"00_011_1"]) {
                self.genderImv.image = [UIImage imageNamed:@"963"];
            }else{
                self.genderImv.image = [UIImage imageNamed:@"964"];
            }
            
            _ageLabel.text = [NSString stringWithFormat:@"%@岁",self.detailModel.UAge];

            //判断活动状态
            if (self.detailModel.State == 1) {
                self.joinBT.hidden = YES;
                [self.inviteBT setTitle:@"活动结束" forState:(UIControlStateNormal)];
                self.inviteBT.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
                self.inviteBT.userInteractionEnabled = NO;
            }else{
                self.joinBT.hidden = NO;
                [self.inviteBT setTitle:@"邀请好友" forState:(UIControlStateNormal)];
                self.inviteBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
                self.inviteBT.userInteractionEnabled = YES;
                
            }

            //活动照片
            self.picArray  = [[NSArray alloc] init];
            self.picArray = [self.detailModel.picID componentsSeparatedByString:@";"];
            //活动介绍
            _numLabel.text = [NSString stringWithFormat:@"已报名：%d",self.detailModel.PersonNum];
            _introLabel.text = [NSString stringWithFormat:@"活动介绍：%@",self.detailModel.Intro];
            _timeLabel.text = self.detailModel.beginDate;
            _placeLabel.text = self.detailModel.Area;
            _activeLabel.text = self.detailModel.Name;
            
        }else{
            [MBProgressHUD showSuccess:dict[@"message"]];

//            NSLog(@"数据加载出错");
        }
        
        [self.pictureCollectionView reloadData];
        [self.personCollectionView reloadData];
        
    } failed:^{
        [MBProgressHUD showSuccess:@"数据加载出错"];
    }];
    
}

-(void)setupViews {
    
    NSLog(@"%@", self.detailModel.UHeadPortrait);
    
    //上部View
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(160));
    }];
 
    //头像
    _headImv = [[UIImageView alloc] init];
    _headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(22);
    _headImv.layer.masksToBounds = YES;
//        _headImv.backgrouvndColor = [UIColor cyanColor];
//    [_headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,self.detailModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    [self.view addSubview:self.headImv];
    
    [_headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(44), SIZE_SCALE_IPHONE6(44)));
    }];
    
    //名字
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];

    [self.view addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImv.mas_top);
        make.left.mas_equalTo(self.headImv.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    
    //性别
    _genderImv = [[UIImageView alloc] init];
//    _genderImv.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:_genderImv];
    
    [_genderImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_top);
        make.left.mas_equalTo(self.nameLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
    }];
    
    //年龄
    _ageLabel = [[UILabel alloc] init];
    _ageLabel.font = [UIFont systemFontOfSize:13];
    _ageLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    _ageLabel.backgroundColor = [UIColor grayColor];
//    _ageLabel.text = [NSString stringWithFormat:@"%@岁",self.detailModel.UAge];
    [self.view addSubview:_ageLabel];
    
    [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(7.5));
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    UILabel * label1 = [[UILabel alloc] init];
    label1.text = @"发起人";
    label1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.centerX.mas_equalTo(self.headImv.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //邀请好友
    _inviteBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _inviteBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _inviteBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _inviteBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _inviteBT.layer.masksToBounds = YES;
    [_inviteBT setTitle:@"邀请好友" forState:(UIControlStateNormal)];
    
    [self.view addSubview:_inviteBT];
    
    [_inviteBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(SIZE_SCALE_IPHONE6(20));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-10));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
    
    //邀请好友
    [_inviteBT addTarget:self action:@selector(inviteAction) forControlEvents:(UIControlEventTouchUpInside)];

    //加入活动
    _joinBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _joinBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    _joinBT.layer.cornerRadius = SIZE_SCALE_IPHONE6(3);
    _joinBT.titleLabel.font = [UIFont systemFontOfSize:15];
    _joinBT.layer.masksToBounds = YES;
    [_joinBT setTitle:@"加入活动" forState:(UIControlStateNormal)];
    [self.view addSubview:_joinBT];
    
    if (self.isJoinIn) {
        [_joinBT setTitle:@"已加入" forState:(UIControlStateNormal)];
    } else {
        [_joinBT setTitle:@"加入活动" forState:(UIControlStateNormal)];

    }
    
    
    [_joinBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_inviteBT.mas_top);
        make.right.mas_equalTo(self.inviteBT.mas_left).offset(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(self.inviteBT);
    }];
    
    //加入活动
    [_joinBT addTarget:self action:@selector(joinAction) forControlEvents:(UIControlEventTouchUpInside)];
    

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(70), SIZE_SCALE_IPHONE6(70));
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = SIZE_SCALE_IPHONE6(12.5);
    
    self.pictureCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.pictureCollectionView.delegate = self;
    self.pictureCollectionView.backgroundColor = [UIColor whiteColor];
    self.pictureCollectionView.pagingEnabled = YES;
    self.pictureCollectionView.showsHorizontalScrollIndicator = NO;
    self.pictureCollectionView.dataSource = self;
    [self.view addSubview:self.pictureCollectionView];
    self.pictureCollectionView.tag = 9990;
    
    [self.pictureCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(-17));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(85));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-32.5));
        make.top.mas_equalTo(label1.mas_centerY);
    }];
    
    [self.pictureCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL_pic"];
    
    //下部View
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(1));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    //活动名
    _activeLabel = [[UILabel alloc] init];
    _activeLabel.font = [UIFont systemFontOfSize:18];
    _activeLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _activeLabel.text = self.detailModel.Name;
    //    _activeLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_activeLabel];
    
    [_activeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(10));
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(20));
    }];

    
    //地点
    _placeImv = [[UIImageView alloc] init];
    //    _placeImv.backgroundColor = [UIColor blackColor];
    _placeImv.image = [UIImage imageNamed:@"iconfont-zuobiao"];
    [self.view addSubview:_placeImv];
    
    [_placeImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(40));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(20));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(12), SIZE_SCALE_IPHONE6(12)));
    }];
    
    //地点
    _placeLabel = [[UILabel alloc] init];
    _placeLabel.font = [UIFont systemFontOfSize:13];
    _placeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    _placeLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_placeLabel];
    
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.placeImv.mas_centerY);
        make.left.mas_equalTo(self.placeImv.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    
    //时间
    _timeImv = [[UIImageView alloc] init];
    //    _timeImv.backgroundColor = [UIColor blackColor];
    _timeImv.image = [UIImage imageNamed:@"iconfont-time"];
    [self.view addSubview:_timeImv];
    
    [_timeImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_placeLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(_placeImv.mas_left);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(12), SIZE_SCALE_IPHONE6(12)));
    }];
    
    //时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    _timeLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeImv.mas_centerY);
        make.left.mas_equalTo(self.timeImv.mas_right);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //活动简介
    _introLabel = [[TopLabel alloc] init];
    _introLabel.font = [UIFont systemFontOfSize:13];
    _introLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    _introLabel.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_introLabel];
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(self.timeImv.mas_left);
//        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-10));
    }];
    
    //报名人数
    _numLabel = [[UILabel alloc] init];
    _numLabel.font = [UIFont systemFontOfSize:13];
    _numLabel.textColor = [UIColor colorWithHexString:@"333333"];

    //    _numLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_numLabel];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.introLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(self.timeImv.mas_left);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(12.5));
    }];
    
    
    //参与人头像
    UICollectionViewFlowLayout * layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(25), SIZE_SCALE_IPHONE6(25));
    layout1.minimumInteritemSpacing = SIZE_SCALE_IPHONE6(12.5);
    
    self.personCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout1];
    self.personCollectionView.delegate = self;
    self.personCollectionView.backgroundColor = [UIColor whiteColor];
    self.personCollectionView.pagingEnabled = YES;
    self.personCollectionView.showsHorizontalScrollIndicator = NO;
    self.personCollectionView.dataSource = self;
    [self.view addSubview:self.personCollectionView];
    self.personCollectionView.tag = 9991;
    
    [self.personCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(0));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(44));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-44));
        make.top.mas_equalTo(_numLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
    }];
    
    [self.personCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL_person"];
    
}

//邀请好友
-(void)inviteAction {
    
    FriendListViewController * friendVC = [[FriendListViewController alloc] init];
    friendVC.UID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"];
    friendVC.GroupID = self.detailModel.GroupID;
    
    [self.navigationController pushViewController:friendVC animated:YES];
    
}

//加入活动
-(void)joinAction {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dictory setValue:self.GroupID forKey:@"GroupID"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/group/join" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            PromptViewController * promptVC = [[PromptViewController alloc] init];
            promptVC.UID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"];
            promptVC.GroupID = self.detailModel.GroupID;
            [self.personCollectionView reloadData];
            
            [self.navigationController pushViewController:promptVC animated:YES];
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        
    } failed:^{
        NSLog(@"数据加载出错");
    }];

    
}


//collectionView  delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 9990) {
        return self.picArray.count;
    }else {
        
        return self.detailModel.PersonNum;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 9990) {
        UICollectionViewCell * cell = [self.pictureCollectionView dequeueReusableCellWithReuseIdentifier:@"CELL_pic" forIndexPath:indexPath];
        UIImageView * IMV = [[UIImageView alloc] init];
        [IMV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,self.picArray[indexPath.row]]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        cell.backgroundView = IMV;
        
        return cell;
    }else {
        UICollectionViewCell * cell = [self.personCollectionView dequeueReusableCellWithReuseIdentifier:@"CELL_person" forIndexPath:indexPath];
        UIImageView * IMV = [[UIImageView alloc] init];
        [IMV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,self.perArray[indexPath.row]]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        cell.backgroundView = IMV;
        cell.layer.cornerRadius = SIZE_SCALE_IPHONE6(12.5);
        cell.layer.masksToBounds = YES;
        
        return cell;
    
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag == 9990) {

        PictureViewController * pictureVC = [[PictureViewController alloc] init];
        
        pictureVC.aString = [NSString stringWithFormat:@"%@%@", BaseImageURL,self.picArray[indexPath.row]];
        [self presentViewController:pictureVC animated:YES completion:nil];
    }
    else {
        PersonShowViewController * personVC = [[PersonShowViewController alloc] init];
        
        personVC.UID = self.personID[indexPath.row];
        [self.navigationController pushViewController:personVC animated:YES];
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
