//
//  UIImage+ISVScale.h
//  ISV
//
//  Created by aaaa on 17/3/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ISVScale)

// 按原图比例返回限定大小的图片（未剪切）
- (UIImage *)getScaleImage:(CGSize)size;

// 按原图比例返回限定大小的图片（剪切）
- (UIImage *)getScaleImageClip:(CGSize)size;

// 指定最大宽度，按原图比例返回限定大小的图片（未剪切）
- (UIImage *)imageByScalingToMaxWidth:(CGFloat)maxWidth;

// 按原图比例返回限定大小的图片2（未剪切）
- (UIImage *)imageByScalingAndCroppingWithTargetSize:(CGSize)targetSize;

UIImage *scaleImage(UIImage *image, CGFloat width);

UIImage *scaleImage2(UIImage *image, CGFloat width, CGFloat height);

@end
