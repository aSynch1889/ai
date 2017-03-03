//
//  UIImage+ISVExtension.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/3.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "UIImage+ISVExtension.h"
// 获取占位图
#define kPlaceholderImageBGColor ISVRGB(216, 216, 216)
#define kPlaceholderCenterImageName @"icon_Placeholder_healthMall"

@implementation UIImage (ISVExtension)

/**
 *  返回原始图片
 */
+ (nullable UIImage *)imageNamedForOriginal:(nullable NSString *)name
{
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  保持原来的长宽比，生成一个缩略图
 */
- (nullable UIImage *)thumbnailWithImageWithSize:(CGSize)asize;

{
    
    if (nil == self) {
        return nil;
    }
    UIImage *newimage;
    CGSize oldsize = self.size;
    
    CGRect rect;
    
    if (asize.width/asize.height > oldsize.width/oldsize.height) {
        
        rect.size.width = asize.height*oldsize.width/oldsize.height;
        
        rect.size.height = asize.height;
        
        rect.origin.x = (asize.width - rect.size.width)/2;
        
        rect.origin.y = 0;
        
    } else{
        
        rect.size.width = asize.width;
        
        rect.size.height = asize.width*oldsize.height/oldsize.width;
        
        rect.origin.x = 0;
        
        rect.origin.y = (asize.height - rect.size.height)/2;
        
    }
    
    UIGraphicsBeginImageContext(asize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
    
    [self drawInRect:rect];
    
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newimage;
    
}
// 对一个图片进行圆形裁剪
- (UIImage *)roundClipImage
{
    CGFloat imageWH = (int)MIN(self.size.width, self.size.height);
    return [self roundClipImageWithSize:imageWH];
    
}

// 对一个图片进行圆形裁剪，自定义宽度
- (UIImage *)roundClipImageWithSize:(CGFloat)sizeWH
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sizeWH, sizeWH), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, sizeWH, sizeWH)];
    [path addClip];// 剪裁
    [self drawInRect:CGRectMake(0, 0, sizeWH, sizeWH)];
    UIImage *roundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return roundImage;
    
    //    //创建图片上下文
    //    UIGraphicsBeginImageContextWithOptions( CGSizeMake(self.size.width, self.size.height), NO, 0);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //
    //    //绘制圆形头像范围
    //    CGContextAddEllipseInRect(context, CGRectMake(0, 0, self.size.width, self.size.height));
    //    //剪切可视范围
    //    CGContextClip(context);
    //    //绘制头像
    //    [self drawInRect:CGRectMake(0, 0, sizeWH, sizeWH)];
    ////    [self drawAtPoint:CGPointZero];
    //
    //    //取出整个图片上下文的图片
    //    UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return iconImage;
    
}

// 对一个图片进行圆形剪裁,可添加边框效果
- (UIImage *)roundClipImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 2.开启上下文
    CGFloat imageW = self.size.width + 2 * borderWidth;
    CGFloat imageH = self.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [self drawInRect:CGRectMake(borderWidth, borderWidth, self.size.width, self.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  获取没有缓存的UIImage对象
 */
//+ (nullable UIImage *)noCacheImageNamed:(nullable NSString *)imageName
//{
//    NSString *imageFile = [[NSString alloc] initWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], imageName];
//    return [[UIImage alloc] initWithContentsOfFile:imageFile];
//}

/**
 *  根据颜色和尺寸生成UIImage对象
 */
+ (nullable UIImage *)imageWithColor:(nullable UIColor *)color size:(CGSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 4 * size.width, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = [UIImage imageWithCGImage:imageMasked];
    
    CGImageRelease(imageMasked);
    
    return image;
}
//创建1像素的图片UIImage
+ (nullable UIImage *)createImageWithColor:(nullable UIColor *)color

{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

// 把View生成图片（截图）
+ (nullable UIImage *)getImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (nullable UIImage *)drawWithSize:(CGSize)size otherImage:(nullable UIImage *)otherImage inRect:(CGRect)rect
{
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    // 将自己画上去
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    [otherImage drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  获取占位图
 */
+ (nullable UIImage *)placeholderImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 画背景
    CGContextSetFillColorWithColor(context, [kPlaceholderImageBGColor CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    // 画中间猫头
    UIImage *centerImage = [UIImage imageNamed:kPlaceholderCenterImageName];
    CGFloat centerImageW = size.width * 0.35;
    CGFloat centerImageH = centerImageW * centerImage.size.height / centerImage.size.width;
    
    CGRect rect = CGRectMake((size.width - centerImageW) * 0.5, (size.height - centerImageH) * 0.5, centerImageW, centerImageH);
    [centerImage drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  旋转图片
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    return [self imageRotatedByDegrees:degrees size:rotatedSize];
}

- (nullable UIImage *)imageRotatedByDegrees:(CGFloat)degrees size:(CGSize)rotatedSize
{
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end
