//
//  GXNetWorkManager.h
//  aaaaaaa
//
//  Created by 黄冬冬 on 16/2/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#import "XPServiceModel.h"
@interface GXNetWorkManager : NSObject

+ (GXNetWorkManager *)shareInstance;

//获取用户数据
- (void)getInfoWithInfo:(NSMutableDictionary *)dic path:(NSString *)path success:(void (^)(NSMutableDictionary *))success failed:(void (^)())failed;

//上传图片
-(void)upLoadImage:(NSData *)imageData path:(NSString *)path success:(void (^)(NSMutableDictionary *))success failed:(void (^)())failed;

#pragma mark - 易联港提供的支持:
- (void)GETWOTRequestWithParam:(NSDictionary *)dic path:(NSString *)path success:(void (^)(NSMutableDictionary *responseDic))success failed:(void (^)())failed;
- (void)POSTWOTRequestWithParam:(NSDictionary *)dic path:(NSString *)path success:(void (^)(NSMutableDictionary *responseDic))success failed:(void (^)())failed;


@end
