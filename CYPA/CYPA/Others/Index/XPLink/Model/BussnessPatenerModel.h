//
//  BussnessPatenerModel.h
//  CYPA
//
//  Created by HDD on 16/7/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BussnessPatenerModel : NSObject
@property(nonatomic, strong)NSString * Pic;
@property(nonatomic, strong)NSString * Url;
@property(nonatomic, strong)NSString * Name;
@property(nonatomic, strong)NSString * SupDesc;
@property(nonatomic, strong)NSString * ShowSite; //显示的位置 1 上部图 2 中间图
@property(nonatomic,strong)NSString * ContactPhone;
@end
