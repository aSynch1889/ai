//
//  NSDate+HMExtension.h
//  HealthMall
//
//  Created by qiuwei on 15/12/6.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HMExtension)

+ (HMDate)currentDateAndTime;
/**
 *  比较时间字符串与当前时间
 *
 *  @param timeString 时间字符串
 *
 *  @return 比较结果
 */
+ (NSComparisonResult)compareNowTimeWithDay:(NSString *)timeString;
@end
