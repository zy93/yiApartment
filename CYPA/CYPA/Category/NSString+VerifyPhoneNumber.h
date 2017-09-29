//
//  NSString+VerifyPhoneNumber.h
//  ZTLife
//
//  Created by Leo on 15/12/8.
//  Copyright © 2015年 ZThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VerifyPhoneNumber)

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//获取时间戳*随机数作为 uid
+(NSString *)timeStamp;

@end
