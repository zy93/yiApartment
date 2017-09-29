//
//  ContractModel.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContractModel : NSObject

@property(nonatomic, strong)NSString * ContractID;
@property(nonatomic, strong)NSString * ContractNo;
@property(nonatomic, strong)NSString * Area;
@property(nonatomic, strong)NSString * ApartmentName;
@property(nonatomic, strong)NSString * RoomNo;
@property(nonatomic, strong)NSString * BeginDate;
@property(nonatomic, strong)NSString * EndDate;
@property(nonatomic, strong)NSString * FreeEndDate;
@property(nonatomic, strong)NSString * Rent;
@property(nonatomic, strong)NSString * RoomRemark;
@property(nonatomic, strong)NSString * RoomRemarkPic;
@property(nonatomic, strong)NSString * ContractPic;


@end
