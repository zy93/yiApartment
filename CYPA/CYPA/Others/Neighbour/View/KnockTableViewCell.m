//
//  KnockTableViewCell.m
//  CYPA
//
//  Created by 黄冬冬 on 16/1/18.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "KnockTableViewCell.h"
#import "Header.h"


@interface KnockTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong)UICollectionView * collectionView;
//@property(nonatomic, strong)UIView *showView;
@property(nonatomic, strong)UIImageView *showView;
@property(nonatomic, strong)UILabel *aLabel;
@property(nonatomic, strong)UIButton *moreButton;


@end

@implementation KnockTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    
    self.showView = [[UIImageView alloc] init];
      self.showView.image = [UIImage imageNamed:@"矩形-1-拷贝"];
//    self.showView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_showView];

    
//    self.aLabel = [[UILabel alloc] init];
//    _aLabel.text = @"敲";
//    [_aLabel setTintColor:[UIColor whiteColor]];
//    _aLabel.textAlignment = NSTextAlignmentCenter;
//    _aLabel.backgroundColor = [UIColor greenColor];
//    [_aLabel setFont:[UIFont systemFontOfSize:22]];
//    [self.contentView addSubview:self.aLabel];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((self.frame.size.width - 0)*0.5, 80);
//    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 50, CGRectGetWidth(self.frame), 200) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"KnockCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
    [self.contentView addSubview:self.collectionView];
    
    self.moreButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.moreButton setTitle:@"更多邻友 >>" forState:(UIControlStateNormal)];
    [self.moreButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.moreButton.backgroundColor = [UIColor grayColor];
    [self.moreButton setAlpha:0.3];
    
    [self.moreButton addTarget:self action:@selector(moreButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.moreButton];
    
}

-(void)layoutSubviews {
    
//    self.aLabel.frame = CGRectMake(self.frame.size.width - 70, 10, 30, 30);
    
    
//    self.showView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 30);
    [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.height.mas_equalTo(184.5);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(26);
    }];
    
//    self.collectionView.frame = CGRectMake(20, 40, CGRectGetWidth(self.frame) - 40, self.frame.size.height - 50);
//    self.moreButton.frame = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30);
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.height.mas_equalTo(29);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    
}

-(void)moreButtonClicked:(UIButton *)sender {
    
}

//collectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KnockCollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor cyanColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.passId();
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
