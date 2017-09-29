//
//  GXNetWorkManager.m
//  aaaaaaa
//
//  Created by 黄冬冬 on 16/2/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "GXNetWorkManager.h"
#import <AFNetworking.h>
#import "Header.h"

@implementation GXNetWorkManager


+ (GXNetWorkManager *)shareInstance
{
    static GXNetWorkManager *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[GXNetWorkManager alloc] init];
    });
    return helper;
}


//获取用户的信息
- (void)getInfoWithInfo:(NSMutableDictionary *)dic path:(NSString *)path success:(void (^)(NSMutableDictionary *))success failed:(void (^)())failed{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString * string = [NSString stringWithFormat:@"%@%@", BaseURL,path];
    
    [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed();
        
    }];
    
}

//上传图片
-(void)upLoadImage:(NSData *)imageData path:(NSString *)path success:(void (^)(NSMutableDictionary *))success failed:(void (^)())failed{
    
    NSString * string = [NSString stringWithFormat:@"%@%@",BaseURL,path];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager POST:string parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        
        NSString * currentDate = [formatter stringFromDate:[NSDate date]];
        NSString * fileName = [NSString stringWithFormat:@"%@.jpg", currentDate];
//        NSLog(@"%@", fileName);
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed();
        NSLog(@"失败");
    }];

}


- (void)GETWOTRequestWithParam:(NSDictionary *)dic path:(NSString *)path success:(void (^)(NSMutableDictionary *))success failed:(void (^)())failed
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSString * string = [NSString stringWithFormat:@"%@%@", WOTURL,path];
    
    [manager GET:string parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed();

    }];
    
}

-(void)POSTWOTRequestWithParam:(NSDictionary *)dic path:(NSString *)path success:(void (^)(NSMutableDictionary *))success failed:(void (^)())failed
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString * string = [NSString stringWithFormat:@"%@%@", WOTURL,path];
    
    [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed();
    }];
}


@end
