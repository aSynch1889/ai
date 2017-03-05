//
//  HMStatusBarWidow.h
//  HealthMall
//
//  Created by qiuwei on 15/11/2.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

// 自定义状态栏窗口
@interface HMStatusBarWidow : NSObject

// 显示自定义状态栏窗口
+ (void)show;

// 隐藏自定义状态栏窗口
+ (void)hide;

// 设置状态栏样式
+ (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle;
//+ (void)setStatusBarHidden:(BOOL)statusBarHidden;

@end
