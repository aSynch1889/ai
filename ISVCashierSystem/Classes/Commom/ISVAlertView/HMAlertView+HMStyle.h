//
//  HMAlertView+HMStyle.h
//  HealthMall
//
//  Created by qiuwei on 15/11/20.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMAlertView.h"

/**
 *  HMAlertView自定义样式类
 */
@interface HMAlertView (HMStyle)

- (void)setWindowTintColor:(UIColor *)color;
- (void)setBackgroundColor:(UIColor *)color;

- (void)setTitleColor:(UIColor *)color;
- (void)setTitleFont:(UIFont *)font;

- (void)setMessageColor:(UIColor *)color;
- (void)setMessageFont:(UIFont *)font;

- (void)setCancelButtonBackgroundColor:(UIColor *)color;
- (void)setOtherButtonBackgroundColor:(UIColor *)color;
- (void)setAllButtonsBackgroundColor:(UIColor *)color;

- (void)setCancelButtonNonSelectedBackgroundColor:(UIColor *)color;
- (void)setOtherButtonNonSelectedBackgroundColor:(UIColor *)color;
- (void)setAllButtonsNonSelectedBackgroundColor:(UIColor *)color;

- (void)setCancelButtonTextColor:(UIColor *)color;
- (void)setAllButtonsTextColor:(UIColor *)color;
- (void)setOtherButtonTextColor:(UIColor *)color;

- (void)useDefaultIOS7Style;

- (void)setCornerRadius:(CGFloat)radius;
- (void)setCenter:(CGPoint)center;

@end
