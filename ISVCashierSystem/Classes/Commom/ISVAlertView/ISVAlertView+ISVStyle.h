//
//  ISVAlertView+ISVStyle.h
//  ISV
//
//  Created by aaaa on 15/11/20.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVAlertView.h"

/**
 *  ISVAlertView自定义样式类
 */
@interface ISVAlertView (ISVStyle)

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
