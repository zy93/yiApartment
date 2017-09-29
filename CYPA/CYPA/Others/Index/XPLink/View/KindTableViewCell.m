//
//  KindTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "KindTableViewCell.h"
#import "Header.h"

@interface KindTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong)UICollectionView * collectionView;

@end

@implementation KindTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}



-(void)setupViews{
    
    //分类collectionView
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(72), SIZE_SCALE_IPHONE6(63));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = SIZE_SCALE_IPHONE6(25);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SIZE_SCALE_IPHONE6(51.5), SIZE_SCALE_IPHONE6(5), SIZE_SCALE_IPHONE6(272), SIZE_SCALE_IPHONE6(211)) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView setScrollEnabled:NO];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self addSubview:self.collectionView];
    
    [self.collectionView registerClass:[KindCollectionViewCell class] forCellWithReuseIdentifier:@"CELL_kind"];
}

//collectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KindCollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CELL_kind" forIndexPath:indexPath];
    
    NSArray * array1 = @[@"组-424", @"组-425", @"组-426",@"组-427", @"组-428", @"组-429", @"组-430", @"组-431", @"组-432"];
    NSArray * array2 = @[@"美食", @"电影", @"团购",@"外卖", @"旅行", @"丽人", @"购物", @"出行", @"生活服务"];
    cell.kindImv.image = [UIImage imageNamed:array1[indexPath.row]];
    cell.nameLabel.text = array2[indexPath.row];
    
    return  cell;
}

//点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSArray * array2 = @[@"https://www.starbucks.com.cn/", @"http://www.tsinova.com/", @"http://bj.daojia.com/",@"http://www.freshoutlets.com/index.htm", @"http://www.helijia.com/index.html", @"", @"", @"http://weixin.beequick.cn/", @"http://www.womai.com/", @"", @"", @""];
    
    NSArray * array2 = @[@"美食", @"电影", @"团购",@"外卖", @"旅行", @"丽人", @"购物", @"出行", @"生活服务"];
    
    self.passId(array2[indexPath.row]);
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
