//
//  NSString+ISVDate.m
//  ISV
//
//  Created by aaaa on 15/11/20.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "NSString+ISVDate.h"

@implementation NSString (ISVDate)

/**
 *  将ISO8601格式时间转为NSDate  "%Y-%m-%dT%H:%M:%S%z"
 */
- (NSDate *)dateByISO8601
{
    if (!self || self.length == 0) return nil;
    
    struct tm tm;
    time_t t;
    
    strptime([self cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    //    return [NSDate dateWithTimeIntervalSince1970:t]; // 零时区
    return [NSDate dateWithTimeIntervalSince1970:t ] ;//东八区+ [[NSTimeZone localTimeZone] secondsFromGMT]
}

/**
 *  将字符串按formatter转成NSDate
 *
 *  @return NSDate时间对象
 */
- (NSDate *)dateByFormatter:(NSString *)formatterStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatterStr];
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    return [formatter dateFromString:self];
}

/**
 *  根据NSDate时间判断时间间隔 如 “刚刚”，“一分钟前”，“一小时前”等
 */
- (NSString *)timeStringFromDate:(NSDate *)dateObj
{
    return [self timeStringFromDate:dateObj formatter:GLOBAL_TIMEFORMAT_yyyyMMddHHmm];
}

/**
 *  把NSDate转为人性化时间 如 “刚刚”，“一分钟前”，“一小时前”等
 */
- (NSString *)timeStringFromDate:(NSDate *)dateObj formatter:(NSString *)formatter
{
    
    // 现在时间
    NSDate *nowDateObj = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970] ];//+ [[NSTimeZone localTimeZone] secondsFromGMT]
    //    NSLog(@"%@----",nowDateObj);
    
    NSString *timeString = nil;
    NSTimeInterval cha =  0 - [dateObj timeIntervalSinceDate:nowDateObj];
    
    if (cha/3600 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num= [timeString intValue];
        
        if (num <= 1) {
            
            timeString = [NSString stringWithFormat:@"刚刚"];
            
        }else{
            
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
            
        }
        
    }else if (cha/3600 > 1 && cha/86400 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
        
    }else if (cha/86400 > 1){
        
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num = [timeString intValue];
        
        if (num < 2) {
            timeString = [NSString stringWithFormat:@"昨天"];
            
        }else{
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.timeZone = [NSTimeZone systemTimeZone];
            NSString *fm = formatter;
            if (num < 365) {
                    fm = GLOBAL_TIMEFORMAT_MMddHHmm;
            }else{
                if (!fm) {
                    fm = GLOBAL_TIMEFORMAT;
                }
            }
            [dateFormatter setDateFormat:fm];
            timeString = [dateFormatter stringFromDate:dateObj];
            
        }
    }
    return timeString;

}
/**
 *  将ISO8601格式时间转为人性化时间 如 “刚刚”，“一分钟前”，“一小时前”等
 */
- (NSString *)timeStringByISO8601
{
    NSDate *date = [self dateByISO8601];
    return [self timeStringFromDate:date];
}

/**
 *  将ISO8601格式时间转为格林时间 如 2015-12-06 11:05:13
 */
- (NSString *)timeFormatStringByISO8601
{
    return [self timeFormatStringByISO8601WithFormatter:GLOBAL_TIMEFORMAT];
}

/**
 *  将ISO8601格式时间转为 人性化的 格林时间
 *  如: 时间如果是今年的，则显示规则比如09-19 20:50；若非今年，则显示为2017-09-19 20:50
 */
- (NSString *)timeFormatStringByISO8601ForHum
{
    // 现在时间
    NSDate *nowDateObj = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970] ];
    NSString *timeString = nil;
    
    NSDate *date = [self dateByISO8601];
    NSTimeInterval cha =  0 - [date timeIntervalSinceDate:nowDateObj];
    
    timeString = [NSString stringWithFormat:@"%f", cha/86400];
    timeString = [timeString substringToIndex:timeString.length-7];
    
    int num = [timeString intValue];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    NSString *fm = nil;
    if (num < 365) {
        fm = GLOBAL_TIMEFORMAT_MMddHHmm;
    }else{
        fm = GLOBAL_TIMEFORMAT_yyyyMMddHHmm;
    }
    [dateFormatter setDateFormat:fm];
    timeString = [dateFormatter stringFromDate:date];

    return timeString;
}
/**
 *  将ISO8601格式时间转为格林时间 如 2015-12-06 11:05:13
 *  @param formatter 你希望的格式 默认为：@"yyyy-MM-dd HH:mm:ss"
 *  @return 格林时间字符串
 */
- (NSString *)timeFormatStringByISO8601WithFormatter:(NSString *)formatter
{
    NSString *fm = (formatter && formatter.length) ? formatter : GLOBAL_TIMEFORMAT;
    
    NSDate *date = [self dateByISO8601];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:fm];
    
    return [dateFormatter stringFromDate:date];
}
/**
 *
 *  把NSDate转为格林时间 如 2015-12-06 11:05:13
 *
 *  @param date NSDate时间对象
 *  @param formatter 你希望的格式 默认为：@"yyyy-MM-dd HH:mm:ss"
 */
- (NSString *)timeFormatterStringFromDate:(NSDate *)date formatter:(NSString *)formatter
{
    NSString *fm = (formatter && formatter.length) ? formatter : GLOBAL_TIMEFORMAT;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:fm];
    
    return [dateFormatter stringFromDate:date];
}

/**
 *  获取当前时间
 *
 *  @return 返回的时间字符串
 */
+ (NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

@end
