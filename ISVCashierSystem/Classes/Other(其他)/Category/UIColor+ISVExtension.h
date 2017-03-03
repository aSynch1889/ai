//
//  UIColor+ISVExtension.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/3.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ISVExtension)
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
@end
