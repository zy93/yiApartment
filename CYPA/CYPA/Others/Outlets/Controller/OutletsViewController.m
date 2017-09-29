//
//  OutletsViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "OutletsViewController.h"
#import "Header.h"
#import "OutletsDetailViewController.h"


@interface OutletsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, NextViewControllerDelegate>

@property(nonatomic, strong)UICollectionView * showCollectionView;
@property(nonatomic, strong)UICollectionView * addCollectionView;
@property(nonatomic, strong)NSMutableArray * dataArray;
//@property(nonatomic, strong)NSMutableArray * addArray;
//@property(nonatomic, strong)NSMutableArray * showArray;

@property(nonatomic, strong)UILabel * shopNumLabel;
@property(nonatomic, assign)NSInteger different;  //判断是否购物车里有相同的商品
@property(nonatomic, assign)NSInteger count;

@property(nonatomic, strong)UIButton *backIndexBT; //回到首页

@end

@implementation OutletsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self makeData];
    
    [self.showCollectionView reloadData];
    [self.addCollectionView reloadData];
    self.shopNumLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)self.addArray.count];
    if (self.showArray.count == 0) {
        self.addCollectionView.hidden = YES;
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    //    [self checkNetWork];
    
}

-(void)makeData {
    
    self.dataArray = [NSMutableArray array];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:nil path:@"/order/listProduct" success:^(NSMutableDictionary * dict) {
        //        NSLog(@"%@", dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {
            for (NSDictionary * dic in dict[@"data"]) {
                ProductModel * model = [ProductModel new];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.dataArray addObject:model];
            }
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        [self.showCollectionView reloadData];
        
    } failed:^{
        NSLog(@"获取商品列表失败");
        //        [self showAlertWithString:@"获取商品列表失败"];
    }];
}


-(void)setupViews{
    
    self.different = 0;
    self.addArray = [NSMutableArray array];
    self.showArray = [NSMutableArray array];
    
    UILabel * topLabel = [[UILabel alloc] init];
    topLabel.text = @"最热商品";
    [self.view addSubview:topLabel];
    //回到首页
    self.backIndexBT = [UIButton buttonTitle:@"回到首页" setBackground:nil andImage:nil titleColor:[UIColor colorWithHexString:@"FFFFFF"] titleFont:15];
    [self.view addSubview:self.backIndexBT];
    [self.backIndexBT addTarget:self action:@selector(backToIndexAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.backIndexBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleImv);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(43.5)));
    }];
    
    if (self.justKind == 1) {
        self.backBT.hidden = NO;
        self.backIndexBT.hidden = YES;
    } else {
        self.backBT.hidden = YES;
        self.backIndexBT.hidden = NO;
    }
    
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(102.5), SIZE_SCALE_IPHONE6(175));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = SIZE_SCALE_IPHONE6(12);
    layout.minimumInteritemSpacing = SIZE_SCALE_IPHONE6(10);
    
    _showCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    _showCollectionView.backgroundColor = [UIColor clearColor];
    _showCollectionView.showsVerticalScrollIndicator = NO;
    _showCollectionView.delegate = self;
    _showCollectionView.dataSource = self;
    _showCollectionView.tag = 1200;
    [self.view addSubview:_showCollectionView];
    
    [self.showCollectionView registerClass:[OutletsCollectionViewCell class] forCellWithReuseIdentifier:@"CELL_outlets"];
    
    [self.showCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLabel.mas_bottom).offset(SIZE_SCALE_IPHONE6(10));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(20));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-20));
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-125));
    }];
    
    
    UICollectionViewFlowLayout * layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.itemSize = CGSizeMake(SIZE_SCALE_IPHONE6(42), SIZE_SCALE_IPHONE6(42));
    layout1.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout1.minimumLineSpacing = SIZE_SCALE_IPHONE6(12.5);
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _addCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout1];
    _addCollectionView.backgroundColor = [UIColor colorWithHexString:@"BBBBBB"];
    _addCollectionView.showsHorizontalScrollIndicator = NO;
    _addCollectionView.delegate = self;
    _addCollectionView.dataSource = self;
    _addCollectionView.tag = 1201;
    _addCollectionView.hidden = YES;
    [self.view addSubview:_addCollectionView];
    
    [self.addCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL_add"];
    
    [self.addCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(42.5));
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(0));
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(0));
        make.bottom.mas_equalTo(SIZE_SCALE_IPHONE6(-80));
    }];
    
    UIButton * payButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [payButton setTitle:@"结算" forState:(UIControlStateNormal)];
    payButton.backgroundColor = [UIColor colorWithHexString:@"fc4d01"];
    payButton.layer.cornerRadius = 3;
    payButton.layer.masksToBounds = YES;
    payButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:payButton];
    
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.addCollectionView.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
    
    [payButton addTarget:self action:@selector(payAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton * myOrderButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [myOrderButton setTitle:@"我的订单" forState:(UIControlStateNormal)];
    myOrderButton.backgroundColor = [UIColor colorWithHexString:@"fc4d01"];
    myOrderButton.layer.cornerRadius = 3;
    myOrderButton.layer.masksToBounds = YES;
    myOrderButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:myOrderButton];
    
    [myOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-40));
        make.top.mas_equalTo(self.addCollectionView.mas_bottom).offset(SIZE_SCALE_IPHONE6(5));
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(80), SIZE_SCALE_IPHONE6(25)));
    }];
    
    [myOrderButton addTarget:self action:@selector(myOrderAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIImageView * shopImv = [[UIImageView alloc] init];
    shopImv.image = [UIImage imageNamed:@"iconfont-gouwufangrugouwuche"];
    [self.view addSubview:shopImv];
    
    [shopImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payButton.mas_top);
        make.height.mas_equalTo(payButton.mas_height);
        make.width.mas_equalTo(payButton.mas_height);
        make.right.mas_equalTo(payButton.mas_left).offset(SIZE_SCALE_IPHONE6(-40));
    }];
    
    self.shopNumLabel = [[UILabel alloc] init];
    self.shopNumLabel.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    self.shopNumLabel.layer.cornerRadius = SIZE_SCALE_IPHONE6(5);
    self.shopNumLabel.layer.masksToBounds = YES;
    self.shopNumLabel.font = [UIFont systemFontOfSize:13];
    self.shopNumLabel.textColor = [UIColor whiteColor];
    self.shopNumLabel.textAlignment = NSTextAlignmentCenter;
    self.shopNumLabel.hidden = YES;
    [self.view addSubview:self.shopNumLabel];
    
    [self.shopNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(shopImv.mas_right);
        make.top.mas_equalTo(shopImv.mas_top);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(10), SIZE_SCALE_IPHONE6(10)));
    }];
    
}

//返回首页
-(void)backToIndexAction{
    RootTabBarController *rootVC =  (RootTabBarController *)self.tabBarController;
    rootVC.selectedIndex = 2;
}


//结算
-(void)payAction{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"state"] isEqualToString:@""]) {
        
        [self showAlertWithString:@"只有新派公民才可以购买哦"];
        
    }else{
        OutLetsPayViewController * payVC = [[OutLetsPayViewController alloc] init];
        payVC.addArray = self.addArray;
        payVC.showArray = self.showArray;
        payVC.FID = self.FID;
        
        [self.navigationController pushViewController:payVC animated:YES];

    }
    
}

//我的订单
-(void)myOrderAction {
    
    MyOrderViewController * orderVC = [[MyOrderViewController alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
    
}


//collectionView  delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView.tag == 1200) {
        return self.dataArray.count;
    }else{
        return self.showArray.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag == 1200) {
        ProductModel * model = self.dataArray[indexPath.row];
        OutletsCollectionViewCell * cell = [self.showCollectionView dequeueReusableCellWithReuseIdentifier:@"CELL_outlets" forIndexPath:indexPath];
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
            cell.hotImv.hidden = NO;
        }else{
            cell.hotImv.hidden = YES;
        }
        NSString * string = [NSString stringWithFormat:@"%@%@", BaseImageURL, model.PicPath];
        NSString * url = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        [cell.productImv sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        cell.proNameLabel.text = model.ProName;
        cell.realPriceLabel.text = [NSString stringWithFormat:@"￥ %.1f",model.RealPrice];
        cell.UnitLabel.text = model.Unit;
        
        cell.pricelabel.text = [NSString stringWithFormat:@"￥ %.1f%@", model.Price, model.Unit];
        //    cell.pricelabel.text = [NSString stringWithFormat:@"%d",model.Price];
        
        cell.shopBT.productModel = model;
        [cell.shopBT addTarget:self action:@selector(addShopAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }else{
        
        UICollectionViewCell * cell = [self.addCollectionView dequeueReusableCellWithReuseIdentifier:@"CELL_add" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor yellowColor];
        
        ProductModel * model = self.showArray[indexPath.row];
        UIImageView * imv = [[UIImageView alloc] init];

        NSString * string = [NSString stringWithFormat:@"%@%@", BaseImageURL, model.PicPath];
        NSString * url = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [imv sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholdPicture]];
        cell.backgroundView = imv;
        
        //角标提示
        UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
        button.layer.cornerRadius = 7.5;
        [cell.contentView addSubview:button];
        
        int count = 0;
        
        for (ProductModel * model1 in self.addArray) {
            if (model1.ProductID == model.ProductID) {
                count += 1;
            }
        }
        
        [button setTitle:[NSString stringWithFormat:@"%d", count] forState:normal];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cell.mas_top);
            make.right.mas_equalTo(cell.mas_right);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        return cell;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel * model = self.dataArray[indexPath.row];
    
    if (collectionView.tag == 1200) {
        
        //跳转页面详情
        OutletsDetailViewController * outletsDetailVC = [[OutletsDetailViewController alloc] init];
        outletsDetailVC.productModel = model;
        
        outletsDetailVC.addShop = ^(ProductModel * pModel){
            self.addCollectionView.hidden = NO;
            
            for (ProductModel * model in self.showArray) {
                if (pModel.ProductID == model.ProductID) {
                    self.different = 1;
                    break;
                }
            }
            
            if (self.different == 0) {
                [self.showArray addObject:pModel];
            }
            self.different = 0;
            [self.addArray addObject:pModel];
            [self.addCollectionView reloadData];
            self.shopNumLabel.hidden = NO;
            self.shopNumLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.addArray.count];
            
        };
        
        [self.navigationController pushViewController:outletsDetailVC animated:YES];

    }
    
    
    
}


//点击图片添加到购物车
-(void)addShopwithModel:(ProductModel *)productModel{
    self.addCollectionView.hidden = NO;
    
    for (ProductModel * model in self.showArray) {
        if (productModel.ProductID == model.ProductID) {
            self.different = 1;
            break;
        }
    }
    
    if (self.different == 0) {
        [self.showArray addObject:productModel];
    }
    self.different = 0;
    [self.addArray addObject:productModel];
    [self.addCollectionView reloadData];
    self.shopNumLabel.hidden = NO;
    self.shopNumLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.addArray.count];
    
}

//添加到购物车
-(void)addShopAction:(HeadButton *)sender {
    self.addCollectionView.hidden = NO;
    
    for (ProductModel * model in self.showArray) {
        if (sender.productModel.ProductID == model.ProductID) {
            self.different = 1;
            break;
        }
    }
    
    if (self.different == 0) {
        [self.showArray addObject:sender.productModel];
    }
    self.different = 0;
    [self.addArray addObject:sender.productModel];
    [self.addCollectionView reloadData];
    self.shopNumLabel.hidden = NO;
    self.shopNumLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.addArray.count];
    
}

//代理传值
-(void)passValue:(NSMutableArray *)showArray dataArray:(NSMutableArray *)addArray{
    
    self.addArray = addArray;
    self.showArray = showArray;

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
