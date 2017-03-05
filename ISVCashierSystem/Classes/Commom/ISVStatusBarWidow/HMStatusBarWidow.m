//
//  HMStatusBarWidow.m
//  HealthMall
//
//  Created by qiuwei on 15/11/2.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMStatusBarWidow.h"
#import "HMTopWindowViewController.h"

static UIWindow *topWindow_;

@implementation HMStatusBarWidow

// 显示自定义状态栏窗口
+ (void)show
{
    if (topWindow_ == nil) {
        topWindow_ = [[UIWindow alloc] init];
        topWindow_.frame = [UIApplication sharedApplication].statusBarFrame;
        topWindow_.windowLevel = UIWindowLevelAlert;
        topWindow_.rootViewController = [[HMTopWindowViewController alloc] init];
        topWindow_.backgroundColor = [UIColor clearColor];
        
        [topWindow_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
    }
    topWindow_.hidden = NO;
    HMTopWindowViewController *TopWindowViewController = (HMTopWindowViewController *)topWindow_.rootViewController;
    if ([TopWindowViewController isKindOfClass:[HMTopWindowViewController class]]) {
        TopWindowViewController.statusBarHidden = NO;
    }

}

// 隐藏自定义状态栏窗口
+ (void)hide
{
    HMTopWindowViewController *TopWindowViewController = (HMTopWindowViewController *)topWindow_.rootViewController;
    if ([TopWindowViewController isKindOfClass:[HMTopWindowViewController class]]) {
        TopWindowViewController.statusBarHidden = YES;
    }
}

+ (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    HMTopWindowViewController *TopWindowViewController = (HMTopWindowViewController *)topWindow_.rootViewController;
    if ([TopWindowViewController isKindOfClass:[HMTopWindowViewController class]]) {
        TopWindowViewController.statusBarStyle = statusBarStyle;
    }
}
/**
 * 监听窗口点击
 */
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}


@end
