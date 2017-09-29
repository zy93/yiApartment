//
//  OutletsViewController.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BaseTitleViewController.h"

@interface OutletsViewController : BaseTitleViewController

@property(nonatomic, strong)NSString * FID;
@property(nonatomic, strong)NSMutableArray * addArray; //总共加的商品数
@property(nonatomic, strong)NSMutableArray * showArray; //条上展示的商品数

@property(nonatomic, assign)NSInteger justKind; //跳转的类型(判断是否显示返回键)

@end
