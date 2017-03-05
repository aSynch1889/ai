//
//  HMItemButton.m
//  HealthMall
//
//  Created by jkl on 15/11/5.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMItemButton.h"
#define KeyPath @"transform.scale"

@implementation HMItemButton

+ (instancetype)itemButtonWithTitle:(NSString *)title icon:(NSString *)icon
{
    HMItemButton *button = [[self alloc] init];
    // 1.文字居中
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 2.文字大小
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    // 3.图片的内容模式
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image = [UIImage imageNamed:icon];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    // 4.给按钮添加点击事件
    [button addTarget:button action:@selector(scaleToFlat)
   forControlEvents:UIControlEventTouchDown];
    [button addTarget:button action:@selector(scaleToDefault)
   forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    
    button.titleLabel.backgroundColor = [UIColor clearColor];
    
    return button;
}

- (void)scaleToFlat
{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:KeyPath];
    theAnimation.delegate = self;
    theAnimation.duration = 0.1;
    theAnimation.repeatCount = 0;
    theAnimation.removedOnCompletion = FALSE;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.autoreverses = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:1];
    theAnimation.toValue = [NSNumber numberWithFloat:1.1f];
    [self.imageView.layer addAnimation:theAnimation forKey:theAnimation.keyPath];
}

- (void)scaleToDefault
{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:KeyPath];
    theAnimation.delegate = self;
    theAnimation.duration = 0.1;
    theAnimation.repeatCount = 0;
    theAnimation.removedOnCompletion = FALSE;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.autoreverses = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:1.1f];
    theAnimation.toValue = [NSNumber numberWithFloat:1];
    [self.imageView.layer addAnimation:theAnimation forKey:theAnimation.keyPath];
}


#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageWidth = 54;
    CGFloat imageX = (CGRectGetWidth(contentRect) - imageWidth) * 0.5;
    CGFloat imageHeight = imageWidth;
    CGFloat imageY = 5;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = 15;
    CGFloat titleY = contentRect.size.height - titleHeight - 1;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX,titleY, titleWidth, titleHeight);
}

@end
