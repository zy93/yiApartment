//
//  NewsTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)UICollectionView * collectionView;
@property(nonatomic, strong)UILabel *dataLabel;
@property(nonatomic, strong)UILabel *contentLabel;
@property(nonatomic, strong)UILabel *knockNumLabel;
@property(nonatomic, strong)UILabel *giftLabel;

@end

@implementation NewsTableViewCell
- (void)awakeFromNib {
    // Initialization code
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

//布局
-(void)setupViews {
  
    self.dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 50)];
    self.dataLabel.text = @"2016/1/1 13:13";
    self.dataLabel.numberOfLines = 2;
//    self.dataLabel.backgroundColor = [UIColor yellowColor];
    self.dataLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.dataLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.dataLabel.frame.origin.y, self.frame.size.width - 110, 50)];
    self.contentLabel.text = @"细数门前落叶，聆听窗外雨声，涉水而过的声音在此响起，你被雨淋湿的心，是否依旧。";
    self.contentLabel.numberOfLines = 2;
    [self addSubview:self.contentLabel];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 80);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.dataLabel.frame) + 5, CGRectGetWidth(self.frame), 100) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [self addSubview:self.collectionView];
    
    self.knockNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 200, CGRectGetMaxY(self.collectionView.frame)+5, 100, 30)];
    self.knockNumLabel.text = @"被敲门：12";
    [self addSubview:self.knockNumLabel];
    
    self.giftLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.knockNumLabel.frame)+10, CGRectGetMinY(self.knockNumLabel.frame), 100, 30)];
    self.giftLabel.text = @"礼物数：12";
    [self addSubview:self.giftLabel];
    
    
}

//collectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
