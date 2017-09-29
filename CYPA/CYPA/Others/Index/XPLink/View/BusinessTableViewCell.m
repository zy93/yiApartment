//
//  BusinessTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/2/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BusinessTableViewCell.h"
#import "Header.h"
#import "BussnessPatenerModel.h"
#import "UIImageView+WebCache.h"

@interface BusinessTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)NSMutableArray *modelArray;


@end

@implementation BusinessTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    NSLog(@"%@", self.dataArray);
    //商家collectionView
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(63), SIZE_SCALE_IPHONE6(63));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SIZE_SCALE_IPHONE6(41), SIZE_SCALE_IPHONE6(10), SIZE_SCALE_IPHONE6(292), SIZE_SCALE_IPHONE6(220)) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [self addSubview:self.collectionView];
    
    UIImageView * linkBusiness = [[UIImageView alloc] init];
    linkBusiness.frame = CGRectMake(SIZE_SCALE_IPHONE6(74), SIZE_SCALE_IPHONE6(72), SIZE_SCALE_IPHONE6(143), SIZE_SCALE_IPHONE6(72));
    linkBusiness.image = [UIImage imageNamed:@"未标题-1"];
    [self.collectionView addSubview:linkBusiness];
    
}

//collectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 12;
//    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    BussnessPatenerModel * model = [BussnessPatenerModel new];

    //判断如果商家数大于10,则显示前10个,小于10,则超过的从第一个重复显示
    if (self.dataArray.count != 0) {
        if (indexPath.row > self.dataArray.count) {
            
            if (indexPath.row > 6) {
                model = self.dataArray[(indexPath.row - 2)% self.dataArray.count];
            }else{
                model = self.dataArray[indexPath.row % self.dataArray.count];
            }
        } else {
            if (indexPath.row > 6) {
                model = self.dataArray[indexPath.row - 2];
            }else{
                model = self.dataArray[indexPath.row];
            }
        }
    }

    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;

    UIImageView * imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseImageURL, model.Pic]] placeholderImage:[UIImage imageNamed:@"组-423"]];
    cell.backgroundView = imageView;
    
    NSLog(@"%@", model.Pic);
    
    cell.backgroundColor = [UIColor cyanColor];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSArray * array2 = @[@"美食", @"电影", @"团购",@"外卖", @"旅行", @"丽人", @"购物", @"出行", @"生活服务"];
    
    BussnessPatenerModel * model = [BussnessPatenerModel new];
    
    //判断如果商家数大于10,则显示前10个,小于10,则超过的从第一个重复显示
    if (self.dataArray.count != 0) {
        if (indexPath.row > self.dataArray.count) {
            
            if (indexPath.row > 6) {
                model = self.dataArray[(indexPath.row - 2)% self.dataArray.count];
            }else{
                model = self.dataArray[indexPath.row % self.dataArray.count];
            }
        } else {
            if (indexPath.row > 6) {
                model = self.dataArray[indexPath.row - 2];
            }else{
                model = self.dataArray[indexPath.row];
            }
        }
    }
    
//    NSArray * array2 = @[@"https://www.starbucks.com.cn/", @"http://www.tsinova.com/", @"http://bj.daojia.com/",@"http://www.freshoutlets.com/index.htm", @"http://www.helijia.com/index.html", @"", @"", @"http://weixin.beequick.cn/", @"http://www.womai.com/", @"", @"", @""];
    self.passId(model.Url);
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
