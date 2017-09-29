//
//  CheckModel.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/15.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckModel : NSObject

@property(nonatomic, strong)NSString * BusiDate;
@property(nonatomic, strong)NSString * TotalFee;
@property (nonatomic,strong)NSString * BusinessFlow;
//@property(nonatomic, assign)int BillID;
@property(nonatomic, strong)NSString * BillID;
@property(nonatomic, strong)NSString * FeeItem;
@property(nonatomic, strong)NSString * Amount;
@property(nonatomic, strong)NSString * BillDesc;

//- (instancetype)initWithDic:(NSDictionary *)dic;


@end
