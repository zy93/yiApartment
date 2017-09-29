//
//  DrinkingWater.h
//  CYPA
//
//  Created by 张雨 on 2017/5/4.
//  Copyright © 2017年 HDD. All rights reserved.
//

#import "BaseDevice.h"

typedef void(^DrinkingResponse)(NSDictionary *dic);

@interface DrinkingWater : BaseDevice

@property (nonatomic, strong) NSNumber *balance;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *TDS;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSNumber *fluxSum;
@property (nonatomic, strong) NSNumber *fluxPulse;

@property (nonatomic, strong) DrinkingResponse moneyBlock;
@property (nonatomic, strong) DrinkingResponse controlBlock;
@property (nonatomic, strong) DrinkingResponse deviceIdBlock;
@property (nonatomic, strong) DrinkingResponse priceBlock;
@property (nonatomic, strong) DrinkingResponse pulseBlock;

/**
 饮水机充值

 @param number 充值金额
 */
-(void)rechargeWithMoney:(CGFloat)money withResponse:(DrinkingResponse)block;

/**
 查询余额
 */
-(void)getBalance;

/**
 开关控制

 @param isOn 开or关
 */
-(void)controlWith:(BOOL)isOn withResponse:(DrinkingResponse)block;

/**
 获取TDS（水质）数值
 */
-(void)getTDS;

/**
 设置设备编号
 
 @param deviceId 设备编号
 */
-(void)setDeviceIDWithType:(NSString *)type number:(NSString *)number withResponse:(DrinkingResponse)block;

/**
 获取设备编号
 */
-(void)getDeviceID;

/**
 设置价格

 @param price 价格
 */
-(void)setPriceWithPrice:(NSString *)price withResponse:(DrinkingResponse)block;

/**
 获取价格
 */
-(void)getPrice;

/**
 设置流量计脉冲数值

 @param pulse 流量计脉冲数值
 */
-(void)setFluxPulseWithPulse:(NSString *)pulse withResponse:(DrinkingResponse)block;

/**
 获取流量计脉冲数值
 */
-(void)getFluxPulse;

/**
 获取售水总流量
 */
-(void)getFluxSum;

@end
