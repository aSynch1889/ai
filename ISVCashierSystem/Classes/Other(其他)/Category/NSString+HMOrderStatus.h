//
//  NSString+HMOrderStatus.h
//  HealthMall
//
//  Created by healthmall005 on 16/1/4.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HMOrderStatus)
/**
 *  养生馆订单状态处理(场馆和养生馆订单通用)
 *
 *  @param status 养生馆订单状态
 *
 *  @return 返回的状态字符串
 */
+ (NSString *)regimenOrderStatusHandleWithStatus:(NSUInteger )status;

/**
 *  根据类型返回字符串
 *
 *  @param ordertype 收支类型
 *
 *  @return 字符串
 */
+ (NSString *)useOrdertypeWith:(HMInOrOutStatus )ordertype;
@end
