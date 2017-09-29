//
//  NewsModel.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/20.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property(nonatomic, strong)NSString * Content;
@property(nonatomic, strong)NSString * CreateTime;

@property(nonatomic, assign)BOOL isExpand; //是否展开


@end
