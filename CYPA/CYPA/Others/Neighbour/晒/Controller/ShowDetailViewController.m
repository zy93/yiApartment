//
//  ShowDetailViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/7.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "Header.h"
@interface ShowDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(strong, nonatomic)UIImageView * headImv;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * showContent;
@property(nonatomic, strong)UIImageView * genderImv;
@property(nonatomic, strong)UILabel * areaLabel;
@property(nonatomic, strong)NSString * imageString;
@property(nonatomic, strong)UICollectionView * collectionView;

@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];

}

-(void)setupViews {
 
    //头像
    _headImv = [[UIImageView alloc] init];
    _headImv.layer.cornerRadius = SIZE_SCALE_IPHONE6(22);
    _headImv.layer.masksToBounds = YES;
//    _headImv.backgroundColor = [UIColor cyanColor];
    [_headImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.57.156.227:8080/AppImages/%@", self.personModel.UHeadPortrait]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    [self.view addSubview:self.headImv];
    
    [_headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(15));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(44), SIZE_SCALE_IPHONE6(44)));
    }];
    
    //名字
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(15)];
    _nameLabel.text = self.personModel.UNickName;
    //    _nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _nameLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImv.mas_top);
        make.left.mas_equalTo(self.headImv.mas_right).offset(SIZE_SCALE_IPHONE6(5));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //性别
    _genderImv = [[UIImageView alloc] init];
//    _genderImv.backgroundColor = [UIColor blackColor];

    if([self.personModel.USex isEqualToString:@"00_011_2"]){
        _genderImv.image = [UIImage imageNamed:@"964"];
    }else{
        _genderImv.image = [UIImage imageNamed:@"963"];

    }
    [self.view addSubview:_genderImv];
    
    [_genderImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_top);
        make.left.mas_equalTo(_nameLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(15), SIZE_SCALE_IPHONE6(15)));
    }];
    
    //地点
    _areaLabel = [[UILabel alloc] init];
    _areaLabel.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(13)];
    _areaLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _areaLabel.text = self.personModel.Area;
//    _areaLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_areaLabel];
    
    [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.nameLabel.mas_bottom);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //发布内容
    _showContent = [[UILabel alloc] init];
    _showContent.font = [UIFont systemFontOfSize:SIZE_SCALE_IPHONE6(13)];
    _showContent.textColor = [UIColor colorWithHexString:@"666666"];
    _showContent.text = self.personModel.UShowCont;
//    _showContent.backgroundColor = [UIColor grayColor];
    //    _showContent.numberOfLines = 0;
    [self.view addSubview:_showContent];
    
    [_showContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(17));
        make.left.mas_equalTo(_headImv.mas_right).offset(SIZE_SCALE_IPHONE6(15));
        make.right.mas_equalTo(_areaLabel.mas_right);
        //        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(55));
        
    }];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(72.5), SIZE_SCALE_IPHONE6(72.5));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL_photo"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_showContent.mas_bottom).offset(SIZE_SCALE_IPHONE6(20));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(74));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-50));
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(0));
    }];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CELL_photo" forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组-3"]];
//    NSArray * array = [self.personModel.UShowPic componentsSeparatedByString:@","];
//    NSString * string = array[indexPath.row];
//    
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"/uploadFiles/uploadImgs/%@",string]]];
    
    return cell;
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
