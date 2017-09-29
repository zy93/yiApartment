//
//  TrystModel.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/9.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "UPerson.h"
@interface TrystModel : NSObject

//@property(nonatomic, assign)int GroupID;
@property (nonatomic,strong)NSString * GroupID;
@property(nonatomic, strong)NSString * Name;
@property(nonatomic, strong)NSString * Intro;
@property(nonatomic, strong)NSString * Notice;
@property(nonatomic, strong)NSString * picID;
@property(nonatomic, strong)NSString * beginDate;
@property(nonatomic, strong)NSString * Area;
@property(nonatomic, strong)NSString * Admin;
@property(nonatomic, assign)int State;
@property(nonatomic, strong)NSString * UHeadPortrait;
@property (nonatomic,assign)int PersonNum;
@property(nonatomic, strong)NSString * USex;
@property (nonatomic,strong)NSString * UAge;
@property(nonatomic, assign)int PersonCount;
@property(nonatomic, strong)NSString * BeginDate;
//@property(nonatomic, strong)NSString * ;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
