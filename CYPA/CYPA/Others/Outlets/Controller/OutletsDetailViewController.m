//
//  OutletsDetailViewController.m
//  CYPA
//
//  Created by HDD on 16/8/12.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "OutletsDetailViewController.h"
#import "OrderView.h"
#import "Header.h"

@interface OutletsDetailViewController ()

@property(nonatomic, strong)OrderView * topOrderView; //轮播图
@property(nonatomic, strong)UILabel *nameLabel; //商品名称
@property(nonatomic, strong)UILabel *priceLabel;//价格
@property(nonatomic, strong)UIButton *addShopCart; //加入购物车
@property(nonatomic, strong)TopLabel *introLabel;//商品介绍
@property(nonatomic, strong)NSMutableArray *imageArray; //轮播图


@end

@implementation OutletsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];

    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
}

-(void)setupViews {
    
    //轮播图
    _imageArray = [NSMutableArray array];
//    [array addObject:[NSString stringWithFormat:@"%@/index/img/1.png", BaseURL]];
//    [array addObject:[NSString stringWithFormat:@"%@/index/img/2.png", BaseURL]];
//    [array addObject:[NSString stringWithFormat:@"%@/index/img/3.png", BaseURL]];
    
    NSArray *array = [_productModel.DetailPic componentsSeparatedByString:@","].mutableCopy;
    for (NSString *imagePath in array) {
        NSString * image = [NSString stringWithFormat:@"%@/odm/%@", BaseImageURL, imagePath];
        [self.imageArray addObject:image];
    }
    
    self.topOrderView = [[OrderView alloc] init];
    self.topOrderView.frame = CGRectMake(0, SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(200));
    //    self.orderView.backgroundColor = [UIColor cyanColor];
    [self.topOrderView bindImageArray:self.imageArray];
    self.topOrderView.pc.hidden = YES;
    [self.view addSubview:self.topOrderView];
 
//    UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SIZE_SCALE_IPHONE6(60), SIZE_SCALE_IPHONE6(375), SIZE_SCALE_IPHONE6(200))];
//    NSString * picString = [NSString stringWithFormat:@"%@/%@", BaseImageURL, _productModel.PicPath];
//    NSString * url = [picString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [topImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholdPicture]];
//    [self.view addSubview:topImageView];
    
    
    UIView * middleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topOrderView.frame) + 5, kScreen_Width, SIZE_SCALE_IPHONE6(90))];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:middleView];
    
    //商品名称
    _nameLabel = [UILabel labelText:_productModel.ProName andFont:18 andColor:[UIColor colorWithHexString:@"3E3A39"]];
    _nameLabel.frame = CGRectMake(10, 0, kScreen_Width - 20, 40);
    [middleView addSubview:_nameLabel];
    
    //价格
    UILabel * pLable = [UILabel labelText:@"￥" andFont:13 andColor:[UIColor colorWithHexString:@"DE1848"]];
    [middleView addSubview:pLable];
    [pLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(middleView.mas_bottom).offset(-10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(15);
    }];
    
    _priceLabel = [UILabel labelText:[NSString stringWithFormat:@"%.1f", _productModel.RealPrice] andFont:25 andColor:[UIColor colorWithHexString:@"DE1848"]];
    [middleView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(middleView.mas_bottom).offset(-10);
        make.left.mas_equalTo(pLable.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    //加入购物车
    _addShopCart = [UIButton buttonTitle:@"加入购物车" setBackground:[UIColor colorWithHexString:kButtonBGColor] andImage:nil titleColor:[UIColor whiteColor] titleFont:14];
    _addShopCart.layer.cornerRadius = 3;
    [self.view addSubview:_addShopCart];
    
    [self.addShopCart addTarget:self action:@selector(addShopCartAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.addShopCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(_priceLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SIZE_SCALE_IPHONE6(100), SIZE_SCALE_IPHONE6(30)));
    }];
    
    
    //下部
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(middleView.frame) + 1, kScreen_Width, 667)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    //商品详情
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 2, 15)];
    label1.backgroundColor = [UIColor colorWithHexString:kButtonBGColor];
    [bottomView addSubview:label1];
    
    UILabel * label2 = [UILabel labelText:@"商品详情" andFont:14 andColor:[UIColor colorWithHexString:@"888889"]];
    label2.frame = CGRectMake(CGRectGetMaxX(label1.frame) + 5, 10, 100, 15);
    [bottomView addSubview:label2];
    
    _introLabel = [[TopLabel alloc] init];
    _introLabel.text = _productModel.Desc;
    _introLabel.font = [UIFont systemFontOfSize:13];
    _introLabel.numberOfLines = 0;
    _introLabel.textColor = [UIColor colorWithHexString:@"888888"];
    [bottomView addSubview:_introLabel];
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label2.mas_left);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(label2.mas_bottom).offset(10);
    }];
    
    
}

//加入购物车
-(void)addShopCartAction {
    if (_productModel.Number > 0) {
        [MBProgressHUD showSuccess:@"加入购物车成功"];
        
        //block传值
        self.addShop(_productModel);
        
    } else {
        [MBProgressHUD showSuccess:@"商品库存不足"];
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
