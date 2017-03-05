//
//  UIImageView+ISVUser.m
//  ISV
//
//  Created by aaaa on 15/12/1.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "UIImageView+ISVUser.h"
#import "UIImage+ISVExtension.h"
#import <UIImageView+WebCache.h>
#import "NSString+ISVExtension.h"

@implementation UIImageView (ISVUser)

- (void)setHeaderPic:(NSString *)url
{
    UIImage *placeholder = kPlaceholder40_40;
    
    CGSize size = self.size;
    if (size.width == 0 || size.height == 0) {
        size = CGSizeMake(60, 60);
    }
    
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
// dispatch_async(dispatch_get_main_queue(), ^{
//            if (cacheType == SDImageCacheTypeDisk || cacheType == SDImageCacheTypeMemory) {
////                dispatch_async(dispatch_get_main_queue(), ^{
//                    weakSelf.image = image ? image : placeholder;
////                });
//            }else{
        
        UIImage *newImage = image ? [image roundClipImageWithSize:size.width] : placeholder;
        weakSelf.image = newImage;
//                [[SDWebImageManager sharedManager] saveImageToCache:newImage forURL:imageURL];
        
////                dispatch_async(dispatch_get_main_queue(), ^{
//                    weakSelf.image = newImage;
////                });
//            }
//     });
//        });
    }];
}

/**
 *  设置圆形头像专用(不缓存裁剪后的图片)
 *
 *  @param url 头像链接
 */
- (void)setHeaderPicDontClip:(NSString *)url
{
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:[NSURL URLWithString:[[url thumbnailURLWithString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:kPlaceholder40_40 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                UIImage *image2 = image ? [image roundClipImageWithSize:weakSelf.size.width] : kPlaceholder40_40;
                
                dispatch_sync(dispatch_get_main_queue(), ^{
        
                    weakSelf.image = image2;
            
                });
            });
    }];
}




- (void)setHeaderPic:(NSString *)url target:(id)target selector:(SEL)selector
{
    [self setHeaderPic:url];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}

/**
 *  设置圆形头像专用(不缓存裁剪后的图片) (可为头像加添加事件)
 */
- (void)setHeaderPicDontClip:(NSString *)url target:(id)target selector:(SEL)selector
{
    [self setHeaderPicDontClip:url];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}

@end
