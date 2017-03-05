//
//  NSString+ISVDate.h
//  ISV
//
//  Created by aaaa on 15/11/20.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *GLOBAL_TIMEFORMAT = @"yyyy-MM-dd HH:mm:ss";
static NSString *GLOBAL_TIMEFORMAT_yyyyMMddHHmm = @"yyyy-MM-dd HH:mm";
static NSString *GLOBAL_TIMEFORMAT_MMddHHmm = @"MM-dd HH:mm";
static NSString *GLOBAL_TIMEFORMAT_MMddHHmm_ch = @"MM月dd日 HH:mm";

@interface NSString (ISVDate)

/**
 *  将ISO8601格式时间转为NSDate
 *
 *  @return NSDate时间对象
 */
- (NSDate *)dateByISO8601;

/**
 *  将字符串按formatter转成NSDate
 *
 *  @return NSDate时间对象
 */
- (NSDate *)dateByFormatter:(NSString *)formatterStr;

/**
 *  将ISO8601格式时间转为人性化时间 如 “刚刚”，“一分钟前”，“一小时前”等
 *
 *  @return 人性化时间字符串
 */
- (NSString *)timeStringByISO8601;

/**
 *  将ISO8601格式时间转为格林时间 固定为: 2015-12-06 11:05:13
 *
 *  @return 格林时间字符串
 */
- (NSString *)timeFormatStringByISO8601;

/**
 *  将ISO8601格式时间转为 人性化的 格林时间 
 *  如: 时间如果是今年的，则显示规则比如09-19 20:50；若非今年，则显示为2017-09-19 20:50
 *
 *  @return 格林时间字符串
 */
- (NSString *)timeFormatStringByISO8601ForHum;

/**
 *  将ISO8601格式时间转为格林时间 如 2015-12-06 11:05:13
 *  @param formatter 你希望的格式 默认为：@"yyyy-MM-dd HH:mm:ss"
 *  @return 格林时间字符串
 */
- (NSString *)timeFormatStringByISO8601WithFormatter:(NSString *)formatter;

/**
 *  把NSDate转为人性化时间 如 “刚刚”，“一分钟前”，“一小时前”等
 *
 *  @param date NSDate时间对象
 */
- (NSString *)timeStringFromDate:(NSDate *)date;

/**
 *
 *  把NSDate转为人性化时间 如 “刚刚”，“一分钟前”，“一小时前”等
 *
 *  @param date NSDate时间对象
 *  @param formatter 你希望的格式 默认为：@"yyyy-MM-dd HH:mm:ss"
 */
- (NSString *)timeStringFromDate:(NSDate *)date formatter:(NSString *)formatter;

/**
 *
 *  把NSDate转为格林时间 如 2015-12-06 11:05:13
 *
 *  @param date NSDate时间对象
 *  @param formatter 你希望的格式 默认为：@"yyyy-MM-dd HH:mm:ss"
 */
- (NSString *)timeFormatterStringFromDate:(NSDate *)date formatter:(NSString *)formatter;

/**
 *  获取当前时间
 *
 *  @return 返回的时间字符串
 */
+ (NSString *)getCurrentTime;
@end
