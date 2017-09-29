//
//  OutletsDetailViewController.h
//  CYPA
//
//  Created by HDD on 16/8/12.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "ProductModel.h"

typedef void(^addShop)(ProductModel *);

@interface OutletsDetailViewController : BaseTitleViewController

@property(nonatomic, strong)ProductModel * productModel;

@property(nonatomic, strong)addShop addShop;

@end
