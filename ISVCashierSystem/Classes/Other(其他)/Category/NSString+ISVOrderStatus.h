//
//  NSString+ISVOrderStatus.h
//  ISV
//
//  Created by ISV005 on 16/1/4.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ISVOrderStatus)
/**
 *  钱xx订单状态处理(掌柜和钱xx订单通用)
 *
 *  @param status 钱xx订单状态
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
+ (NSString *)useOrdertypeWith:(ISVInOrOutStatus )ordertype;
@end
