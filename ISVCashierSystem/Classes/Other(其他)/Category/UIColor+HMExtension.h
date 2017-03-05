//
//  UIColor+HMExtension.h
//  HealthMall
//
//  Created by qiuwei on 15/11/3.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HMExtension)

/**
 *  用16进制颜色字符串获取UIColor类型
 *
 *  @param stringToConvert 要转成颜色的十六进制字符,以#开始
 *  @param alpha           透明度
 *
 *  @return UIColor实例
 */
+ (UIColor *)colorWithHexColor:(NSString *)stringToConvert alpha:(CGFloat)alpha;

/**
 *  同上,只是透明度默认为1
 */
+ (UIColor *)colorWithHexColor:(NSString *)stringToConvert;

/**
 *  获取一个随机的颜色
 */
+ (UIColor *)randomColor;

+ (UIColor *)color:(UIColor *)color_ withAlpha:(float)alpha_;
/**
 *  根据订单状态返回不同颜色
 *
 *  @param status 订单状态
 *
 *  @return 颜色
 */
+ (UIColor *)OrderStatusColorHandleWithStatus:(NSUInteger )status;
@end
