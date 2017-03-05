//
//  UIImage+ISVWatermark.m
//  ISV
//
//  Created by aaaa on 16/1/9.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "UIImage+ISVWatermark.h"
#import "UIImage+ISVExtension.h"

// 误差值
#define kWatermarkErrorValue(word) ((IsLetter([word characterAtIndex:0])) ? 10.0 : 2.0)

@implementation UIImage (ISVWatermark)

/**
 *  生成文字图片
 *  @param word
 */
+ (UIImage *)wordImageWith:(NSString *)word size:(CGSize)size backgroundColor:(UIColor *)backgroundColor
{
    
    UIImage *iamge = [UIImage imageWithColor:backgroundColor size:size];
    CGFloat width = 30.0;
    CGRect rect = CGRectMake((size.width - width + kWatermarkErrorValue(word))*0.5, (size.width - width)*0.5, width, width);// 2.0误差
    return [iamge initWithStringWaterMark:word inRect:rect color:[UIColor whiteColor] font:[UIFont systemFontOfSize:width-4.0]];
}
/**
 *  根据文字生成图片
 */
- (UIImage *)initWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font
{

    UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".

    //原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    //文字颜色
    [color set];
    
    //水印文字
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, color, NSForegroundColorAttributeName, nil];
    [markString drawInRect:rect withAttributes:attrs];
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

/**
 * 加半透明水印
 */
- (UIImage *)initWithMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect;
{
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    //rect参数为水印图片的位置
    [maskImage drawInRect:rect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
@end
