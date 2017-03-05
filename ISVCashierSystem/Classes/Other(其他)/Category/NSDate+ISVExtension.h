//
//  NSDate+ISVExtension.h
//  ISV
//
//  Created by aaaa on 15/12/6.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ISVExtension)

+ (ISVDate)currentDateAndTime;
/**
 *  比较时间字符串与当前时间
 *
 *  @param timeString 时间字符串
 *
 *  @return 比较结果
 */
+ (NSComparisonResult)compareNowTimeWithDay:(NSString *)timeString;
@end
