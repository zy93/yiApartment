//
//  NSDate+ZTCurrentDate.m
//  ZTLife
//
//  Created by Leo on 15/12/12.
//  Copyright © 2015年 ZThink. All rights reserved.
//

#import "NSDate+ZTCurrentDate.h"

@implementation NSDate (ZTCurrentDate)

// 获取当前时间

+ (NSString *)getCurrentDate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSSS";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    
    return str;
}


#pragma mark - 日期与字符串的互转
+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormattor = [[NSDateFormatter alloc] init];
    [dateFormattor setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormattor stringFromDate:date];
}

+ (NSDate *)convertDateFromString:(NSString*)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [formatter dateFromString:dateStr];
}

+ (NSString *)yearsDate:(NSDate *)timesDate {
    
    NSDateFormatter *dateFormattor = [[NSDateFormatter alloc] init];
    [dateFormattor setDateFormat:@"yyyy年MM月dd日"];
    return [dateFormattor stringFromDate:timesDate];

}

@end
