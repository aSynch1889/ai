//
//  UIImage+HMWatermark.h
//  HealthMall
//
//  Created by qiuwei on 16/1/9.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HMWatermark)

/**
 *  生成文字图片
 *  @param word
 */
+ (UIImage *)wordImageWith:(NSString *)word size:(CGSize)size backgroundColor:(UIColor *)backgroundColor;

/**
 *  根据文字生成图片
 */
- (UIImage *)initWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;

/**
 * 加半透明水印
 * @param addImage1 水印图片
 * @returns 加好水印的图片
 */
- (UIImage *)initWithMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect;
@end
