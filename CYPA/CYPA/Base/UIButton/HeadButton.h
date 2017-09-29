//
//  HeadButton.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/10.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface HeadButton : UIButton

@property(nonatomic, strong)NSString * UID;
@property(nonatomic, strong)NSString * FID;
@property(nonatomic, strong)NSString * GroupID;
//@property (nonatomic,assign)int BillID;
@property (nonatomic,strong)NSString * BillID;
@property(nonatomic, strong)NSString * FeeItem;
@property(nonatomic, strong)NSString * Amount;
//shopBT
@property(nonatomic, strong)ProductModel * productModel;
@property(nonatomic, assign)NSInteger isSelected;

@property(nonatomic, strong)NSIndexPath * index;


@end
