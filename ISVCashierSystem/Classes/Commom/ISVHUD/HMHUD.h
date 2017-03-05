//
//  HMHUD.h
//  HealthMall
//
//  Created by qiuwei on 15/12/5.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const HMHUDReLoadDataNotification = @"HMHUDReLoadDataNotification"; // 点击重新加载网络按钮通知

// 蒙版样式
typedef NS_ENUM(NSUInteger,HMHUDMaskType) {
    HMHUDMaskTypeNone = 1,  // 没有蒙版，并可以继续点击
    HMHUDMaskTypeClear,     // 没有蒙版，不可以继续点击
    HMHUDMaskTypeBlack,     // 黑色蒙版，不可以继续点击
    HMHUDMaskTypeGradient   // 透明蒙版，不可以继续点击
};

// HUDPage形式
typedef enum : NSUInteger {
    HMHUDPageTypeLoading = 1,   // 加载中
    HMHUDPageTypeNoData,        // 暂无数据
    HMHUDPageTypeNoConnect,     // 网络不佳
} HMHUDPageType;

@interface HMHUD : NSObject

// 重置HUD
+ (void)reset;

/**
 *  显示一个页面
 *
 *  @param pageType 页面类型
 *  @param view     在哪个View上显示
 */
+ (void)showPageWithPageType:(HMHUDPageType)pageType InView:(UIView *)view;

// 显示一个圈圈
+ (void)show;
+ (void)showWithMaskType:(HMHUDMaskType)maskType;
// 显示一个圈圈加描述
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(HMHUDMaskType)maskType;

// 显示进度圈圈
+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress maskType:(HMHUDMaskType)maskType;
+ (void)showProgress:(float)progress status:(NSString*)status;
+ (void)showProgress:(float)progress status:(NSString*)status maskType:(HMHUDMaskType)maskType;

// 在showing的时候，改变 HUD 的加载状态
+ (void)setStatus:(NSString*)string;

// 停止所有的指示器, 显示带信息的指示器, 并自动消失
+ (void)showInfoWithStatus:(NSString *)string;
+ (void)showInfoWithStatus:(NSString *)string maskType:(HMHUDMaskType)maskType;

+ (void)showSuccessWithStatus:(NSString*)string;
+ (void)showSuccessWithStatus:(NSString*)string maskType:(HMHUDMaskType)maskType;

+ (void)showErrorWithStatus:(NSString *)string;
+ (void)showErrorWithStatus:(NSString *)string maskType:(HMHUDMaskType)maskType;

// use 28x28 white pngs
+ (void)showImage:(UIImage*)image status:(NSString*)status;
+ (void)showImage:(UIImage*)image status:(NSString*)status maskType:(HMHUDMaskType)maskType;

+ (void)setOffsetFromCenter:(UIOffset)offset;
+ (void)resetOffsetFromCenter;
+ (void)setBackgroundColor:(UIColor*)color;

// 减少指示器数量，如果==0，就隐藏指示器
+ (void)popActivity;
+ (void)dismiss;

+ (BOOL)isVisible;

@end
