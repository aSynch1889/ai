//
//  UIImage+ISVBlur.h
//  ISV
//
//  Created by aaaa on 16/2/26.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ISVBlur)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
/**
 *  加模糊(毛玻璃)效果
 */
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
