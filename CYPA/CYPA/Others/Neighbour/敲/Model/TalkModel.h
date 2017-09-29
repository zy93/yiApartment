//
//  TalkModel.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/9.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TalkModel : NSObject

@property (nonatomic,assign)int msgTo; //收件人
@property (nonatomic,assign)int msgFrom;//发件人
@property(nonatomic, assign)int msgid; //本人id

//@property (nonatomic, strong)NSString * msgTo;
//@property (nonatomic,strong)NSString * msgFrom;
@property (nonatomic,strong)NSString * content;
@property (nonatomic,strong)NSString * createtime;
@property (nonatomic,strong)NSString * UHeadPortrait;
@property (nonatomic,strong)NSString * UNickName;
@property (nonatomic,strong)NSString * USex;
@property (nonatomic,strong)NSString * UAge;
@property (nonatomic,strong)NSString * Area;
@property (nonatomic,assign)int State;

@property(nonatomic, strong)NSString * UID;
@property(nonatomic, strong)NSString * UConstellation;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
