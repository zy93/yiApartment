//
//  XPBaseModel.h
//  CYPA
//
//  Created by 黄冬冬 on 16/2/27.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPBaseModel : NSObject
@property(nonatomic, assign)int number;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
