//
//  OrderModel.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property(nonatomic, assign)int OrderID;
@property(nonatomic, assign)double TotalFee;
@property(nonatomic, strong)NSString * OrderTime; //下单时间
@property(nonatomic, strong)NSString * UNickName;
@property(nonatomic, strong)NSString * State;
@property(nonatomic, strong)NSString * Remark;
@property(nonatomic, strong)NSString * ProName;
@property(nonatomic, strong)NSString * PicPath;
@property(nonatomic, assign)double RealPrice;
@property(nonatomic, strong)NSString * Unit;
@property(nonatomic, assign)int Number;



- (instancetype)initWithDic:(NSDictionary *)dic;


@end
