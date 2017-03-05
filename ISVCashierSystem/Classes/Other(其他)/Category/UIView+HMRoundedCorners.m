//
//  UIView+HMRoundedCorners.m
//  HealthMall
//
//  Created by qiuwei on 15/11/3.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "UIView+HMRoundedCorners.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (HMRoundedCorners)

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    
    // Create the path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
}


@end
