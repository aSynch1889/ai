//
//  UIImage+HMScale.m
//  HealthMall
//
//  Created by qiuwei on 15/11/6.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "UIImage+HMScale.h"

@implementation UIImage (HMScale)

// 按原图比例返回限定大小的图片（未剪切）
- (UIImage *)getScaleImage:(CGSize)size
{
    // 排错
    if(size.width==0||size.height==0)
        return self;
    CGSize imgSize=self.size;
    float scale=size.height/size.width;
    float imgScale=imgSize.height/imgSize.width;
    float width=0.0f,height=0.0f;
    if(imgScale<scale&&imgSize.width>size.width){
        width=size.width;
        height=width*imgScale;
    }else if(imgScale>scale&&imgSize.height>size.height){
        height=size.height;
        width=height/imgScale;
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage * image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 按原图比例返回限定大小的图片（剪切）
- (UIImage* )getScaleImageClip:(CGSize)size
{
    // 排错
    if(size.width==0||size.height==0)
        return self;
    CGSize imgSize=self.size;
    UIImageOrientation  orientation=self.imageOrientation;
    CGRect rect;
    if(size.height>=imgSize.height&&size.width>=imgSize.width)
        return self;
    else if(size.height>=imgSize.height&&size.width<imgSize.width)
        rect=CGRectMake((imgSize.width-size.width)/2, 0, size.width, imgSize.height);
    else if(size.height<imgSize.height&&size.width>=imgSize.width)
        rect=CGRectMake(0, (imgSize.height-size.height)/2, imgSize.width, size.height);
    else
        rect=CGRectMake((imgSize.width-size.width)/2,(imgSize.height-size.height)/2, size.width, size.height);
    CGImageRef imgRef=CGImageCreateWithImageInRect(self.CGImage, rect);
    return [UIImage imageWithCGImage:imgRef scale:1 orientation:orientation];
}

UIImage *scaleImage(UIImage *image, CGFloat width)
{
    CGFloat imgWidth = image.size.width;
    CGFloat imgHeight = image.size.height;
    
    if ((imgWidth  < width-0.000001) &&
        (imgHeight < width-0.000001))
    {
        return image;
    }
    
    CGFloat scale = MIN(imgWidth/width, imgHeight/width);
    
    UIGraphicsBeginImageContext(CGSizeMake(imgWidth/scale, imgHeight/scale));
    
    [image drawInRect:CGRectMake(0, 0, imgWidth/scale, imgHeight/scale)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

UIImage *scaleImage2(UIImage *image, CGFloat width, CGFloat height)
{
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    [image drawInRect:CGRectMake(0, 0, width, height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

// 指定最大宽度，按原图比例返回限定大小的图片（未剪切）
- (UIImage *)imageByScalingToMaxWidth:(CGFloat)maxWidth
{
    if (self.size.width < maxWidth) return self;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (self.size.width > self.size.height) {
        btHeight = maxWidth;
        btWidth = self.size.width * (maxWidth / self.size.height);
    } else {
        btWidth = maxWidth;
        btHeight = self.size.height * (maxWidth / self.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingWithTargetSize:targetSize];
}

// 按原图比例返回限定大小的图片2（未剪切）
- (UIImage *)imageByScalingAndCroppingWithTargetSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end
