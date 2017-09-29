//
//  MyContractViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "MyContractViewController.h"
#import "Header.h"
@interface MyContractViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)UILabel * myRoomLabel;
@property(nonatomic, strong)UILabel * roomTimeLabel;
@property(nonatomic, strong)UILabel * roomEndLabel;
@property(nonatomic, strong)UILabel * rentLabel;

@property(nonatomic, strong)TopLabel * remarkLabel;

@property(nonatomic, strong)ContractModel * contractModel;

@property(nonatomic, strong)UICollectionView * collectionView1;
@property(nonatomic, strong)UICollectionView * collectionView2;

@end

@implementation MyContractViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self makeData];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    

}
-(void)makeData {
    //获取合同信息
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"CustID"] forKey:@"CustID"];
    //    NSLog(@"%@", dictory);
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/user/myContract" success:^(NSMutableDictionary * dict) {
        
//        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            self.contractModel = [ContractModel new];
            [self.contractModel setValuesForKeysWithDictionary:dict[@"data"]];
            
            _myRoomLabel.text = [NSString stringWithFormat:@"%@%@%@", self.contractModel.Area,self.contractModel.ApartmentName,self.contractModel.RoomNo];
            _roomTimeLabel.text = [NSString stringWithFormat:@"%@至%@", self.contractModel. BeginDate, self.contractModel.EndDate];
            _roomEndLabel.text = [NSString stringWithFormat:@"%@",self.contractModel.EndDate];
            _rentLabel.text = [NSString stringWithFormat:@"%@", self.contractModel.Rent];
            self.remarkLabel.text = [NSString stringWithFormat:@"%@", self.contractModel.RoomRemark];
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        
        [self.collectionView1 reloadData];
        [self.collectionView2 reloadData];
        
    } failed:^{
        NSLog(@"获取用户信息失败");
    }];

}

-(void)setupViews{
    
    //上部view
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(110));
    }];
    
    UILabel * roomLabel = [[UILabel alloc] init];
    roomLabel.text = @"我的房间：";
    roomLabel.font = [UIFont systemFontOfSize:15];
    [topView addSubview:roomLabel];
    
    [roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.myRoomLabel = [[UILabel alloc] init];
    _myRoomLabel.font = [UIFont systemFontOfSize:15];
    _myRoomLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.view addSubview:_myRoomLabel];
    
    [_myRoomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(roomLabel.mas_top);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(100));
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    
    UILabel * roomTimeLabel = [[UILabel alloc] init];
    roomTimeLabel.text = @"合同到期：";
    roomTimeLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:roomTimeLabel];
    
    [roomTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(roomLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.roomTimeLabel = [[UILabel alloc] init];
    _roomTimeLabel.font = [UIFont systemFontOfSize:15];
    _roomTimeLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.view addSubview:_roomTimeLabel];
    
    [_roomTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(roomTimeLabel.mas_top);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(100));
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    UILabel * roomEndLabel = [[UILabel alloc] init];
    roomEndLabel.text = @"实际到期：";
    roomEndLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:roomEndLabel];
    [roomEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(roomTimeLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
   
    _roomEndLabel = [[UILabel alloc] init];
    _roomEndLabel.font = [UIFont systemFontOfSize:15];
    _roomEndLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.view addSubview:_roomEndLabel];

    [_roomEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(roomEndLabel.mas_top);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(100));
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    UILabel * rentLabel = [[UILabel alloc] init];
    rentLabel.text = @"房屋租金：";
    rentLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:rentLabel];
    
    [rentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(roomEndLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    _rentLabel = [[UILabel alloc] init];
    _rentLabel.font = [UIFont systemFontOfSize:15];
    _rentLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    _rentLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_rentLabel];
    [_rentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rentLabel.mas_top);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(100));
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //房屋备案View
    UIView * middleView = [[UIView alloc] init];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(158));
    }];
    
    UILabel * registerLabel = [[UILabel alloc] init];
    registerLabel.text = @"房屋备案：";
    registerLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:registerLabel];
    
    [registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(middleView.mas_top).offset(SIZE_SCALE_IPHONE6(12.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    self.remarkLabel = [[TopLabel alloc] init];
    self.remarkLabel.numberOfLines = 0;
    self.remarkLabel.text = @"    房屋交付时的一些备注";
    self.remarkLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.remarkLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.remarkLabel];
    
    [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(registerLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(37.5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(74), SIZE_SCALE_IPHONE6(74));
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = SIZE_SCALE_IPHONE6(40);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    _collectionView1.backgroundColor = [UIColor clearColor];
    _collectionView1.showsHorizontalScrollIndicator = NO;
    _collectionView1.delegate = self;
    _collectionView1.dataSource = self;
    _collectionView1.tag = 1009;
    [self.view addSubview:_collectionView1];
    
    [self.collectionView1 registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL_photo"];
    
    [self.collectionView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.remarkLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(32.5));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-32.5));
        make.bottom.mas_equalTo(middleView.mas_bottom).offset(SIZE_SCALE_IPHONE6(-20));
    }];

    
    //我的合同view
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(middleView.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UILabel * myContractLabel = [[UILabel alloc] init];
    myContractLabel.text = @"我的合同";
    myContractLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:myContractLabel];
    
    [myContractLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(12.5));
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    UICollectionViewFlowLayout * layout2 = [[UICollectionViewFlowLayout alloc] init];
    layout2.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(165), SIZE_SCALE_IPHONE6(175));
//    layout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout2.minimumLineSpacing = SIZE_SCALE_IPHONE6(10);
    layout2.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _collectionView2 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout2];
    _collectionView2.backgroundColor = [UIColor clearColor];
    _collectionView2.showsHorizontalScrollIndicator = NO;
    _collectionView2.delegate = self;
    _collectionView2.dataSource = self;
    _collectionView2.tag = 1100;
    [self.view addSubview:_collectionView2];
    
    [self.collectionView2 registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL_photo2"];
    
    [self.collectionView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(SIZE_SCALE_IPHONE6(35));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.bottom.mas_equalTo(bottomView.mas_bottom);
    }];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 1009) {
        NSMutableArray * array = [self.contractModel.RoomRemarkPic componentsSeparatedByString:@","].mutableCopy;
        [array removeObject:@""];
        
        return array.count;
    }else{
        NSMutableArray * array = [self.contractModel.ContractPic componentsSeparatedByString:@","].mutableCopy;
        [array removeObject:@""];
        return array.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag == 1009) {
        UICollectionViewCell * cell = [self.collectionView1 dequeueReusableCellWithReuseIdentifier:@"CELL_photo" forIndexPath:indexPath];
        NSMutableArray * array = [self.contractModel.RoomRemarkPic componentsSeparatedByString:@","].mutableCopy;
        [array removeObject:@""];
        UIImageView * imv = [[UIImageView alloc] init];

        NSString * urlString = [NSString stringWithFormat:@"%@odm/%@", BaseImageURL, array[indexPath.row]];
        NSString *url = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        [imv sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        cell.backgroundView = imv;
        
        return cell;
    }else {
        UICollectionViewCell * cell = [self.collectionView2 dequeueReusableCellWithReuseIdentifier:@"CELL_photo2" forIndexPath:indexPath];
        NSMutableArray * array = [self.contractModel.ContractPic componentsSeparatedByString:@","].mutableCopy;
        [array removeObject:@""];
        
        NSString * urlString = [NSString stringWithFormat:@"%@odm/%@", BaseImageURL, array[indexPath.row]];
        NSString *url = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        UIImageView * imv = [[UIImageView alloc] init];
        [imv sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeholdPicture]];
        cell.backgroundView = imv;
        return cell;
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
