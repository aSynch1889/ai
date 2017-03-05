//
//  UIView+HMRoundedCorners.h
//  HealthMall
//
//  Created by qiuwei on 15/11/3.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HMRoundedCorners)
/**
 *  把View设置为圆角
 *
 *  @param corners 圆角类型
 *  @param radius  圆角半径
 */
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;

@end
