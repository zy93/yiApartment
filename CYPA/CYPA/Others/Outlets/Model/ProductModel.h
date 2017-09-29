//
//  ProductModel.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/22.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject

//@property(nonatomic, strong)NSString * ProductID;
@property(nonatomic, assign)int ProductID;
@property(nonatomic, strong)NSString * ProName;
@property(nonatomic, strong)NSString * PicPath;
@property(nonatomic, assign)double Price;
//@property(nonatomic, strong)NSString * Price;
@property(nonatomic, assign)double RealPrice;
@property(nonatomic, strong)NSString * Unit;
@property(nonatomic, assign)int Count;
@property(nonatomic, assign)int Number;
@property(nonatomic, strong)NSString *Desc;
@property(nonatomic, strong)NSString *DetailPic; //商品详情图



- (instancetype)initWithDic:(NSDictionary *)dic;


@end
