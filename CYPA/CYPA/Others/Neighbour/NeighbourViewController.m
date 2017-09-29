//
//  NeighbourViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/15.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "NeighbourViewController.h"
#import "Header.h"

@interface NeighbourViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

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
@property(nonatomic, strong)NSMutableArray *joinedArray;  //已参加的活动
@property(nonatomic, assign)BOOL isJoined; //是否加入

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIView *contentView; //滑动的view
@property(nonatomic, strong)UIButton *backIndexBT; //回到首页

@end

@implementation NeighbourViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"state"] isEqualToString:@""]) {
        
        VistorView * view1 = [[VistorView alloc] init];
        self.view = view1;
    }else{
     
        [self makeData];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(667));
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    _scrollView.delegate = self;
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(667))];;
    [_scrollView addSubview:_contentView];
    
//    [self afn];
    
    [self checkNetWork];
    [self showView];
    [self knockView];
    [self trystView];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UID"]) {
        //获取已参加的活动
        [self getJoinedActivity];
    }
    
}

//获取已参加的活动
-(void)getJoinedActivity {
    self.joinedArray = [NSMutableArray array];
    
    NSMutableDictionary * dictory = [[NSMutableDictionary alloc] init];
    [dictory setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dictory setObject:@"1" forKey:@"Type"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/group/listMyGroup" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                TrystModel * model = [[TrystModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.joinedArray addObject:model];
            }
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        [self.trystCollectionView reloadData];
        
    } failed:^{
        NSLog(@"加载数据失败");
        
    }];
    
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
//            [self showAlertWithString:dict[@"message"]];
        }
    } failed:^{
        NSLog(@"获取用户信息失败");
    }];
    
    
    //最新晒的信息
    NSMutableDictionary * dictory1 = [NSMutableDictionary dictionary];
    [dictory1 setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"ApartmentID"] forKey:@"ApartmentID"];
    [[GXNetWorkManager shareInstance] getInfoWithInfo: dictory1 path:@"/user/getNeighborShowList" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                UPerson * showModel = [UPerson new];
                [showModel setValuesForKeysWithDictionary:dic];
                [self.showDataArray addObject:showModel];
            }
            
        }else{
//            [self showAlertWithString:dictory[@"message"]];
        }
        //刷新UI
        [self.showCollectionView reloadData];
    } failed:^{
         NSLog(@"加载数据失败");
        
    }];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"1" forKey:@"Type"];
    
    [dic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"UID"] forKey:@"UID"];
    [dic setValue:@"100" forKey:@"PageNum"];
    
    //最热公民列表信息
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dic path:@"/friend/getList" success:^(NSMutableDictionary * dict) {
        
//        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                UPerson * knockModel = [UPerson new];
                [knockModel setValuesForKeysWithDictionary:dic];
                [self.knockDataArray addObject:knockModel];
            }
            
        }else {
            NSLog(@"获取数据失败");
        }
        
        [self.knockCollectionView reloadData];
        
    } failed:^{
//        [self showAlertWithString:@"数据加载出错"];
    }];
//    //约
    NSMutableDictionary * dictory2 = [NSMutableDictionary dictionary];
    [dictory2 setValue:@"0" forKey:@"type"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory2 path:@"/group/getList" success:^(NSMutableDictionary *dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                TrystModel * trystModel = [[TrystModel alloc] init];
                [trystModel setValuesForKeysWithDictionary:dic];
                [self.trystDataArray addObject:trystModel];
            }
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        
        [self.trystCollectionView reloadData];
        
    } failed:^{
//        [self showAlertWithString:@"数据加载出错"];
    }];
    
    
}

-(void)showView {

    UIImageView * showImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-983"]];
    [_contentView addSubview:showImv];
    [showImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(20));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(47)));
    }];

    //回到首页
    self.backIndexBT = [UIButton buttonTitle:@"回到首页" setBackground:nil andImage:nil titleColor:[UIColor colorWithHexString:@"FFFFFF"] titleFont:15];
    [self.view addSubview:self.backIndexBT];
    [self.backIndexBT addTarget:self action:@selector(backToIndexAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.backIndexBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showImv.mas_top);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];

    
    //最新晒
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = @"最新晒";
    _titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [_contentView addSubview:_titleLabel];
    
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
    
    [_contentView addSubview:self.showCollectionView];
    
    [self.showCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(250), SIZE_SCALE_IPHONE6(75)));
    }];
    
    [self.showCollectionView registerClass:[ShowCollectionViewCell class] forCellWithReuseIdentifier:@"CELL_show"];
    
    //我要晒
    _showBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    _showBT.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [_showBT setImage:[UIImage imageNamed:@"组-982"] forState:(UIControlStateNormal)];
    [_contentView addSubview:_showBT];
    
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
    [_contentView addSubview:_moreShowBT];
    
    [_moreShowBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showCollectionView.mas_bottom).offset(SIZE_SCALE_IPHONE6(-5));
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];
    
    [self.moreShowBT addTarget:self action:@selector(moreShowAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

//返回首页
-(void)backToIndexAction{
    RootTabBarController *rootVC =  (RootTabBarController *)self.tabBarController;
    rootVC.selectedIndex = 2;
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

//敲
-(void)knockView {

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(160), SIZE_SCALE_IPHONE6(80));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.knockCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
//    layout.minimumInteritemSpacing = 13;
    self.knockCollectionView.backgroundColor = [UIColor clearColor];
    self.knockCollectionView.pagingEnabled = YES;
    self.knockCollectionView.showsHorizontalScrollIndicator = NO;
    self.knockCollectionView.delegate = self;
    self.knockCollectionView.dataSource = self;
    self.knockCollectionView.tag = 9100;

    [_contentView addSubview:self.knockCollectionView];

    [self.knockCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreShowBT.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-28));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(182));
    }];
    
    [self.knockCollectionView registerClass:[KnockCollectionViewCell class] forCellWithReuseIdentifier:@"CELL_knock"];
    
    UIImageView * knockImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-984"]];
    [_contentView addSubview:knockImv];
    [knockImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreShowBT.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(47)));
    }];
    
    
    //更多
    _moreKnockBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_moreKnockBT setBackgroundImage:[UIImage imageNamed:@"组-979"] forState:(UIControlStateNormal)];
    [_contentView addSubview:_moreKnockBT];
    
    [_moreKnockBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.knockCollectionView.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(30));
    }];
    
    [self.moreKnockBT addTarget:self action:@selector(moreKnockAction) forControlEvents:(UIControlEventTouchUpInside)];

    
    //左划
    UIImageView * leftImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-986"]];
    [_contentView addSubview:leftImv];
    
    //右划
    UIImageView * rightImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-985"]];
    [_contentView addSubview:rightImv];
    
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
    [_contentView addSubview:trystImv];
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
    
    [_contentView addSubview:self.trystCollectionView];
    
    [self.trystCollectionView registerClass:[TrystCollectionViewCell class] forCellWithReuseIdentifier:@"CELL_tryst"];
    
    [self.trystCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreKnockBT.mas_bottom).offset(SIZE_SCALE_IPHONE6(25));
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(275), SIZE_SCALE_IPHONE6(150)));
    }];
    
    //更多
    _moretrystBT = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_moretrystBT setBackgroundImage:[UIImage imageNamed:@"组-979"] forState:(UIControlStateNormal)];
    [_contentView addSubview:_moretrystBT];
    
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
    [_contentView addSubview:_publishBT];
    
    [_publishBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moreKnockBT.mas_bottom).offset(SIZE_SCALE_IPHONE6(93));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-23));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(62), SIZE_SCALE_IPHONE6(68)));
    }];
    
    [_publishBT addTarget:self action:@selector(publishAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //左划
    UIImageView * leftImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-986"]];
    [_contentView addSubview:leftImv];
    
    //右划
    UIImageView * rightImv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-985"]];
    [_contentView addSubview:rightImv];
    
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
    }else if (collectionView.tag == 9100) {
        return ((self.knockDataArray.count + 3)/4);
    }else {
        return self.trystDataArray.count;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 9999) {
        return 1;
    }else if (collectionView.tag == 9997) {
        return 1;
    }else {
        if (section == self.knockDataArray.count / 4){
            return self.knockDataArray.count % 4;
        }else {
            return 4;
        }
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
        [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,showModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        cell.introduceLabel.text = showModel.USignaTure;

        return cell;
    }else if (collectionView.tag == 9997){
        TrystCollectionViewCell * cell = [self.trystCollectionView dequeueReusableCellWithReuseIdentifier:@"CELL_tryst" forIndexPath:indexPath];
        
        TrystModel * trystModel = [TrystModel new];
        
        trystModel = self.trystDataArray[indexPath.section];

        //分割图片
        NSArray * array = [trystModel.picID componentsSeparatedByString:@";"];
        
        [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL, array[0]]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        cell.activeLabel.text = trystModel.Name;
        cell.placeLabel.text = trystModel.Area;
        cell.timeLabel.text = trystModel.beginDate;
        cell.holdLabel.text = [NSString stringWithFormat:@"发起人：%@", trystModel.Admin];
        cell.numLabel.text = [NSString stringWithFormat:@"已报名：%d",trystModel.PersonNum];
        
        _isJoined = NO;
        
        NSLog(@"++++%@", [NSString stringWithFormat:@"%@", trystModel.GroupID]);
        for (TrystModel * model in self.joinedArray) {
            if (model.GroupID == trystModel.GroupID) {
                _isJoined = YES;
            }
        }
        cell.joinBT.GroupID = trystModel.GroupID;

        if (_isJoined) {
            [cell.joinBT setTitle:@"已加入" forState:(UIControlStateNormal)];
//            cell.joinBT.userInteractionEnabled = NO;
        } else {
            [cell.joinBT setTitle:@"加入活动" forState:(UIControlStateNormal)];
            [cell.joinBT addTarget:self action:@selector(joinActiveAction:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
        return cell;
    }else  {
        UPerson * knockModel = [UPerson new];
        knockModel = self.knockDataArray[indexPath.row];
        KnockCollectionViewCell * cell = [self.knockCollectionView dequeueReusableCellWithReuseIdentifier:@"CELL_knock" forIndexPath:indexPath];
        [cell.headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageURL,knockModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
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
            [self showAlertWithString:dict[@"message"]];
        }
        [self.trystCollectionView reloadData];
        
    } failed:^{
        NSLog(@"数据加载出错");
    }];

    
}



//点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag == 9999) {
        PersonShowViewController * personShowVC = [[PersonShowViewController alloc] init];
        UPerson * showModel = [UPerson new];
        showModel = self.showDataArray[indexPath.section];
        
        personShowVC.UID = showModel.UID;
        [self.navigationController pushViewController:personShowVC animated:YES];
        
    }else if (collectionView.tag == 9100) {
        PersonShowViewController * personShowVC = [[PersonShowViewController alloc] init];
        UPerson * knockModel = [UPerson new];
        knockModel = self.knockDataArray[indexPath.row];
        personShowVC.UID = knockModel.UID;
        [self.navigationController pushViewController:personShowVC animated:YES];
        
    }else {
        TrystModel * model = self.trystDataArray[indexPath.section];
        
        ActivityDetailViewController * activityVC = [[ActivityDetailViewController alloc] init];
        activityVC.GroupID = model.GroupID;
        
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
