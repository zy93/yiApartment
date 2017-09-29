//
//  NSDate+ZTCurrentDate.h
//  ZTLife
//
//  Created by Leo on 15/12/12.
//  Copyright © 2015年 ZThink. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (ZTCurrentDate)

/**
 *   获取当前时间
 *
 *  @return  获取当前时间
 */
+ (NSString *)getCurrentDate;


/**
 *  date 转字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date;

/**
 *  字符串转date
 */
+ (NSDate *)convertDateFromString:(NSString*)dateStr;

/**
 * date转年月日
 */
+ (NSString *)yearsDate:(NSDate *)timesDate;

@end
