//
//  NeighbourViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/15.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "NeighbourViewController.h"
#import "Header.h"

@interface NeighbourViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)NSMutableArray * showDataArray;
@property(nonatomic, strong)NSMutableArray * knockDataArray;
@property(nonatomic, strong)NSMutableArray * trystDataArray;

@property(nonatomic, strong)UICollectionView * showCollectionView;
@property(nonatomic, strong)UICollectionView * knockCollectionView;
@property(nonatomic, strong)UICollectionView * trystCollectionView;
@property(nonatomic, strong)UIButton * moreShowBT;
@property(nonatomic, strong)UIButton * moreKnockBT;
@property(nonatomic, strong)UIButton * moretrystBT;
//最新晒
@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UIButton * showBT;
//发布活动
@property(nonatomic, strong)UIButton * publishBT;

@property(nonatomic, strong)UPerson * showPerson;

@property(nonatomic, strong)XPCitizen * myModel;


@end

@implementation NeighbourViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [self makeData];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    //加载数据
//    [self makeData];
    
    [self showView];
    [self knockView];
    [self trystView];

    
}


-(void)makeData {
    
    self.showDataArray = [NSMutableArray array];
    self.knockDataArray = [NSMutableArray array];
    self.trystDataArray = [NSMutableArray array];
    
    //个人的信息
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/getUserInfoByUID" success:^(NSMutableDictionary * dict) {
        
//        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.myModel = [XPCitizen new];
            [self.myModel setValuesForKeysWithDictionary:dict[@"data"]];
            
        }else{
            [self showAlert:dict[@"message"]];
        }
    } failed:^{
        NSLog(@"获取用户信息失败");
    }];
    
    
    //最新晒的信息
    [[GXNetWorkManager shareInstance] getInfoWithUID:nil apartmentID:@"1" Type:nil path:@"/user/getNeighborShowList" success:^(NSMutableDictionary * dictory) {
        if ([dictory[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dictory[@"data"]) {
                UPerson * showModel = [UPerson new];
                [showModel setValuesForKeysWithDictionary:dic];
                [self.showDataArray addObject:showModel];
            }
            
        }else{
            [self showAlert:dictory[@"message"]];
        }
        //刷新UI
        [self.showCollectionView reloadData];
    } failed:^{
         NSLog(@"加载数据失败");
        
    }];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"1" forKey:@"Type"];
    
    
//    NSLog(@"+++%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]);
    
    [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dic setValue:@"100" forKey:@"PageNum"];
    
    //最热公民列表信息
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dic path:@"/friend/getList" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                UPerson * knockModel = [UPerson new];
                [knockModel setValuesForKeysWithDictionary:dic];
                [self.knockDataArray addObject:knockModel];
            }
//            NSLog(@"%@",self.knockDataArray);
            
        }else {
            [self showAlert:[NSString stringWithFormat:@"%@", dict[@"message"]]];
        }
        
        [self.knockCollectionView reloadData];
        
    } failed:^{
        [self showAlert:@"数据加载出错"];
    }];
    

//    //约
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:@"0" forKey:@"type"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dict path:@"/group/getList" success:^(NSMutableDictionary *dictory) {
        if ([dictory[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dictory[@"data"]) {
                TrystModel * trystModel = [[TrystModel alloc] init];
                [trystModel setValuesForKeysWithDictionary:dic];
                [self.trystDataArray addObject:trystModel];
            }
//            NSLog(@"%ld",self.trystDataArray.count);
        }else{
            [self showAlert:dictory[@"message"]];
        }
        
        [self.trystCollectionView reloadData];
        
    } failed:^{
        [self showAlert:@"数据加载出错"];
    }];
    
    
}

-(void)showView {

    UIImageView * showImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-983"]];
    [self.view addSubview:showImv];
    [showImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(20));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(47)));
    }];

    //最新晒
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    _titleLabel.text = @"最新晒";
    _titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.view addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(52.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(250), SIZE_SCALE_IPHONE6(75));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.showCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.showCollectionView.backgroundColor = [UIColor clearColor];
    self.showCollectionView.showsHorizontalScrollIndicator = NO;
    self.showCollectionView.pagingEnabled = YES;
    self.showCollectionView.delegate = self;
    self.showCollectionView.dataSource = self;
    self.showCollectionView.tag = 9999;
    
    [self.view addSubview:self.showCollectionView];
    
    [self.showCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(250), SIZE_SCALE_IPHONE6(75)));
    }];
    
    [self.showCollectionView registerClass:[ShowCollectionViewCell class] forCellWithReuseIdentifier:@"CELL_show"];
    
    //我要晒
    _showBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    _showBT.backgroundColor = [UIColor redColor];
    [_showBT setImage:[UIImage imageNamed:@"组-982"] forState:(UIControlStateNormal)];
    [self.view addSubview:_showBT];
    
    [_showBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(SIZE_SCALE_IPHONE6(80));
            make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-26));
            make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(57), SIZE_SCALE_IPHONE6(62)));
        }];
    
    [self.showBT addTarget:self action:@selector(showAction) forControlEvents:(UIControlEventTouchUpInside)];
    
        //左划
        UIImageView * leftImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-986"]];
        [self.view addSubview:leftImv];
    
        //右划
        UIImageView * rightImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-985"]];
        [self.view addSubview:rightImv];
    
        [leftImv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(22));
            make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
            make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(18), SIZE_SCALE_IPHONE6(27)));
        }];
    
        [rightImv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(leftImv.mas_top);
            make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
            make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(18), SIZE_SCALE_IPHONE6(27)));
        }];
    
    //更多
    _moreShowBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_moreShowBT setBackgroundImage:[UIImage imageNamed:@"组-979"] forState:(UIControlStateNormal)];
    [self.view addSubview:_moreShowBT];
    
    [_moreShowBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showCollectionView.mas_bottom).offset(SIZE_SCALE_IPHONE6(-5));
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];
    
    [self.moreShowBT addTarget:self action:@selector(moreShowAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

//我要晒
-(void)showAction {
    
    PublishViewController * publishVC = [[PublishViewController alloc] init];
    
    publishVC.citizenModel = self.myModel;

    [self presentViewController:publishVC animated:YES completion:nil];
}

//更多晒
-(void)moreShowAction {
    MoreShowViewController * moreShowVC = [[MoreShowViewController alloc] init];
    [self.navigationController pushViewController:moreShowVC animated:YES];
    
}


-(void)knockView {

    UIImageView * knockImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-984"]];
    [self.view addSubview:knockImv];
    [knockImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreShowBT.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(47)));
    }];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(160), SIZE_SCALE_IPHONE6(80));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.knockCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    layout.minimumInteritemSpacing = 13;
    self.knockCollectionView.backgroundColor = [UIColor clearColor];
    self.knockCollectionView.pagingEnabled = YES;
    self.knockCollectionView.showsHorizontalScrollIndicator = NO;
    self.knockCollectionView.delegate = self;
    self.knockCollectionView.dataSource = self;
    self.knockCollectionView.tag = 9998;

    [self.view addSubview:self.knockCollectionView];
    
    [self.knockCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreShowBT.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-23.5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(182));
    }];
    
    [self.knockCollectionView registerClass:[KnockCollectionViewCell class] forCellWithReuseIdentifier:@"CELL_knock"];
    
    
    //更多
    _moreKnockBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_moreKnockBT setBackgroundImage:[UIImage imageNamed:@"组-979"] forState:(UIControlStateNormal)];
    [self.view addSubview:_moreKnockBT];
    
    [_moreKnockBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.knockCollectionView.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];
    
    [self.moreKnockBT addTarget:self action:@selector(moreKnockAction) forControlEvents:(UIControlEventTouchUpInside)];

    
    //左划
    UIImageView * leftImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-986"]];
    [self.view addSubview:leftImv];
    
    //右划
    UIImageView * rightImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-985"]];
    [self.view addSubview:rightImv];
    
    [leftImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreShowBT.mas_bottom).offset(SIZE_SCALE_IPHONE6(100));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(18), SIZE_SCALE_IPHONE6(27)));
    }];
    
    [rightImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftImv.mas_top);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(18), SIZE_SCALE_IPHONE6(27)));
    }];

}

//更多邻居
-(void)moreKnockAction {
    
    MoreNeighbourViewController * moreNeighbourVC = [[MoreNeighbourViewController alloc] init];
    
    [self.navigationController pushViewController:moreNeighbourVC animated:YES];
}

//约
-(void)trystView {
    
    UIImageView * trystImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"983"]];
    [self.view addSubview:trystImv];
    [trystImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreKnockBT.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(47)));
    }];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(275), SIZE_SCALE_IPHONE6(150));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.trystCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.trystCollectionView.backgroundColor = [UIColor clearColor];
    self.trystCollectionView.pagingEnabled = YES;
    self.trystCollectionView.showsHorizontalScrollIndicator = NO;
    self.trystCollectionView.delegate = self;
    self.trystCollectionView.dataSource = self;
    self.trystCollectionView.tag = 9997;
    
    [self.view addSubview:self.trystCollectionView];
    
    [self.trystCollectionView registerClass:[TrystCollectionViewCell class] forCellWithReuseIdentifier:@"CELL_tryst"];
    
    [self.trystCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreKnockBT.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(275), SIZE_SCALE_IPHONE6(150)));
    }];
    
    //更多
    _moretrystBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_moretrystBT setBackgroundImage:[UIImage imageNamed:@"组-979"] forState:(UIControlStateNormal)];
    [self.view addSubview:_moretrystBT];
    
    [_moretrystBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.trystCollectionView.mas_bottom).offset(SIZE_SCALE_IPHONE6(-5));
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];
    
    [self.moretrystBT addTarget:self action:@selector(moretrystAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    //发布活动
    _publishBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    _showBT.backgroundColor = [UIColor redColor];
    [_publishBT setImage:[UIImage imageNamed:@"组-981"] forState:(UIControlStateNormal)];
    [self.view addSubview:_publishBT];
    
    [_publishBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreKnockBT.mas_bottom).offset(SIZE_SCALE_IPHONE6(93));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-23));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(62), SIZE_SCALE_IPHONE6(68)));
    }];
    
    [_publishBT addTarget:self action:@selector(publishAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //左划
    UIImageView * leftImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-986"]];
    [self.view addSubview:leftImv];
    
    //右划
    UIImageView * rightImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-985"]];
    [self.view addSubview:rightImv];
    
    [leftImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreKnockBT.mas_bottom).offset(SIZE_SCALE_IPHONE6(85));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(18), SIZE_SCALE_IPHONE6(27)));
    }];
    
    [rightImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftImv.mas_top);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(18), SIZE_SCALE_IPHONE6(27)));
    }];
    
    
    
}

//发布活动
-(void)publishAction {
    
    PublishActivityViewController * publishVC = [[PublishActivityViewController alloc] init];
    publishVC.citizenModel = self.myModel;
    [self presentViewController:publishVC animated:YES completion:nil];
    
}

//更多约
-(void)moretrystAction {
    MoreTrystViewController * moreTrystVC = [[MoreTrystViewController alloc] init];
    
    [self.navigationController pushViewController:moreTrystVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView.tag == 9999) {
        return self.showDataArray.count;
    }else if (collectionView.tag == 9998) {
        
//        NSLog(@"%ld", self.knockDataArray.count);
        return ((self.knockDataArray.count + 3)/4);
    }else {
        return self.trystDataArray.count;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 9999) {
        return 1;
    }else if (collectionView.tag == 9998) {
        if ((section + 1) == (self.knockDataArray.count + 3)/4){
            return self.knockDataArray.count % 4;
        }else {
            return 4;
        }
    }else {
        return 1;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag == 9999) {
        
        UPerson * showModel = [UPerson new];
        showModel = self.showDataArray[indexPath.section];
        
        ShowCollectionViewCell * cell = [self.showCollectionView dequeueReusableCellWithReuseIdentifier:@"CELL_show" forIndexPath:indexPath];
        cell.nameLabel.text = showModel.UNickName;
        cell.knockLabel.text = [NSString stringWithFormat:@"敲门%@",showModel.knockNum];
        cell.knockedLabel.text = [NSString stringWithFormat:@"被敲门%@",showModel.knockedNum];
        [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.156.227:8080/AppImages/%@",showModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        cell.introduceLabel.text = showModel.USignaTure;

        return cell;
    }else if (collectionView.tag == 9998) {
        UPerson * knockModel = [UPerson new];
        
        knockModel = self.knockDataArray[indexPath.row];
        
        KnockCollectionViewCell * cell = [self.knockCollectionView dequeueReusableCellWithReuseIdentifier:@"CELL_knock" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor yellowColor];
        [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.156.227:8080/AppImages/%@",knockModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        cell.nameLabel.text = knockModel.UNickName;

        if([knockModel.USex isEqualToString:@"00_011_2"]){
            cell.genderImv.image = [UIImage imageNamed:@"964"];
        }else{
            cell.genderImv.image = [UIImage imageNamed:@"963"];
            
        }
        
        
        cell.introducelabel.text = knockModel.USignaTure;
        
        cell.knockBT.UID = knockModel.UID;
        
        //点击敲门
        [cell.knockBT addTarget:self action:@selector(knockAction:) forControlEvents:(UIControlEventTouchUpInside)];
        

        return cell;
    }else {
        TrystCollectionViewCell * cell = [self.trystCollectionView dequeueReusableCellWithReuseIdentifier:@"CELL_tryst" forIndexPath:indexPath];
        
        TrystModel * trystModel = [TrystModel new];
//        NSLog(@"%@", self.trystDataArray);
        
        trystModel = self.trystDataArray[indexPath.section];

        //分割图片
        NSArray * array = [trystModel.picID componentsSeparatedByString:@";"];
        
        [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.156.227:8080/AppImages/%@", array[0]]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        cell.activeLabel.text = trystModel.Name;
        cell.placeLabel.text = trystModel.Area;
        cell.timeLabel.text = trystModel.beginDate;
        cell.holdLabel.text = [NSString stringWithFormat:@"发起人：%@", trystModel.Admin];
        cell.numLabel.text = [NSString stringWithFormat:@"已报名：%d",trystModel.PersonNum];
        cell.joinBT.GroupID = trystModel.GroupID;
        
        [cell.joinBT addTarget:self action:@selector(joinActiveAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }

}

//点击敲门
-(void)knockAction:(HeadButton *)sender {
    
    TalkViewController * talkVC = [[TalkViewController alloc] init];
    talkVC.FID = sender.UID;
    
    [self.navigationController pushViewController:talkVC animated:YES];
    
    
}

-(void)joinActiveAction:(HeadButton *)sender{
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dictory setValue:sender.GroupID forKey:@"GroupID"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/group/join" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            PromptViewController * promptVC = [[PromptViewController alloc] init];
            promptVC.UID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"];
            promptVC.GroupID = sender.GroupID;
            
            [self.navigationController pushViewController:promptVC animated:YES];
            //            [self presentViewController:promptVC animated:YES completion:nil];
            
        }else{
            [self showAlert:dict[@"message"]];
        }
        
    } failed:^{
        NSLog(@"数据加载出错");
    }];

    
}



//点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag == 9999) {
        PersonShowViewController * personShowVC = [[PersonShowViewController alloc] init];
        personShowVC.personModel = self.showDataArray[indexPath.row];
        [self.navigationController pushViewController:personShowVC animated:YES];
        
    }else if (collectionView.tag == 9998) {
        PersonShowViewController * personShowVC = [[PersonShowViewController alloc] init];
        personShowVC.personModel = self.knockDataArray[indexPath.row];
        [self.navigationController pushViewController:personShowVC animated:YES];
        
    }else {
        
        ActivityDetailViewController * activityVC = [[ActivityDetailViewController alloc] init];
        activityVC.activityModel = self.trystDataArray[indexPath.section];
        
        [self.navigationController pushViewController:activityVC animated:YES];
        
        
    }
    
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
