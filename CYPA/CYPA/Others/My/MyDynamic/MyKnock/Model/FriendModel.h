//
//  FriendModel.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/18.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject

//@property(nonatomic, strong)NSString * UID;
@property(nonatomic, assign)int UID;
@property(nonatomic, strong)NSString * FID;
@property(nonatomic, strong)NSString * GroupID;
@property(nonatomic, assign)int Ftype;
@property(nonatomic, assign)int State;
@property(nonatomic, strong)NSString * UNickName;
@property(nonatomic, strong)NSString * USex;
@property(nonatomic, strong)NSString * UAge;
@property(nonatomic, strong)NSString * UHeadPortrait;
@property (nonatomic,strong)NSString * Area;
@property (nonatomic,strong)NSString * ApartmentName;
@property(nonatomic, strong)NSString * UConstellation;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
