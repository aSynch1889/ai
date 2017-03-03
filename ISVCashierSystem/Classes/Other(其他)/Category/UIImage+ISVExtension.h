//
//  UIImage+ISVExtension.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/3.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ISVExtension)

/**
 *  返回原始图片
 *
 *  @param name 图片名称
 *
 *  @return 原始图片
 */
+ (nullable UIImage *)imageNamedForOriginal:(nullable NSString *)name;

/**
 *  保持原来的长宽比，生成一个缩略图
 */
- (nullable UIImage *)thumbnailWithImageWithSize:(CGSize)asize;

/**
 *  对一个图片进行圆形裁剪
 *
 *  @param image 要裁剪的图片
 *
 *  @return 裁剪好的图片(使用这个方法裁剪出来的圆的半径为传入图片的宽度的一半)
 */
- (nullable UIImage *)roundClipImage;

/**
 *  对一个图片进行圆形裁剪，自定义宽度
 */
- (nullable UIImage *)roundClipImageWithSize:(CGFloat)size;
/**
 *  对一个图片进行圆形剪裁,可添加边框效果
 *
 *  @param image       要剪裁的图片
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 剪裁后的带边框的图片
 */
- (nullable UIImage *)roundClipImageWithBorderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;

/**
 *  获取没有缓存的UIImage对象
 *
 *  @param imageName 图片名称
 *
 *  @return UIImage对象
 */
//+ (nullable UIImage *)noCacheImageNamed:(nullable NSString *)imageName;

/**
 *  根据颜色和尺寸生成UIImage对象
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return UIImage对象
 */
+ (nullable UIImage *)imageWithColor:(nullable UIColor *)color size:(CGSize)size;

/**
 *  创建1像素的图片UIImage
 */
+ (nullable UIImage *)createImageWithColor:(nullable UIColor *)color;

/**
 *  把View生成图片（截图）
 */
+ (nullable UIImage *)getImageFromView:(nullable UIView *)view;

/**
 *  把另一个图片画到自己（图片）的身上
 *
 *  @param otherImage 另一个图片
 *  @param rect       范围
 *
 *  @return UIImage对象
 */
- (nullable UIImage *)drawWithSize:(CGSize)size otherImage:(nullable UIImage *)otherImage inRect:(CGRect)rect;

/**
 *  获取占位图
 *  @param size 大小
 *  @return UIImage对象
 */
+ (nullable UIImage *)placeholderImageWithSize:(CGSize)size;

/**
 *  旋转图片
 *  @param degrees 角度 30/90/180
 */
- (nullable UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

- (nullable UIImage *)imageRotatedByDegrees:(CGFloat)degrees size:(CGSize)size;

/**
 *  图片旋转问题修复
 *
 *  @param aImage 需要修复的图片
 *
 *  @return 修正后的图片
 */
+ (nullable UIImage *)fixOrientation:(nullable UIImage *)aImage;
@end
