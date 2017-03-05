//
//  NSDate+HMExtension.m
//  HealthMall
//
//  Created by qiuwei on 15/12/6.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "NSDate+HMExtension.h"

@implementation NSDate (HMExtension)

+ (HMDate)currentDateAndTime
{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSWeekdayCalendarUnit) fromDate:nowDate];
    
    HMDate date = {[comps year], [comps month], [comps day], [comps hour], [comps minute], [comps second], [comps weekday]};
    
    return date;
}

+ (NSComparisonResult)compareNowTimeWithDay:(NSString *)timeString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *orderDate = [formatter dateFromString:timeString];
    
    NSDate *now = [NSDate date];
    
    NSComparisonResult result = [orderDate compare:now];
    
    if (result == NSOrderedDescending) {
        NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"Date1 is in the past");
        return -1;
    }
    NSLog(@"Both dates are the same");
    return 0;
}

@end
