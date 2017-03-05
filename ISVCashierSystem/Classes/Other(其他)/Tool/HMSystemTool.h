//
//  HMSystemTool.h
//  HealthMall
//
//  Created by qiuwei on 15/10/29.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

// 系统工具类
@interface HMSystemTool : NSObject

/**
 *  是否是版本更新后首次打开
 *  @return BOOL 是/否
 */
+ (BOOL)isVersionUpdated;

/**
 *  检查更新APP
 */
+ (void)checkUpAPP;

/**
 *  检查相机的认证状态
 *
 *  @param successCallback 可用
 *  @param failedCallback  不可用
 */
+ (void)captureDeviceAuthStatusWithSuccessCallback:(void(^)())successCallback failedCallback:(void(^)())failedCallback;

/**
 *  检查相册权限
 *
 *  @param successCallback 可用
 *  @param failedCallback  不可用
 */
+ (void)libraryAuthStatusWithSuccessCallback:(void(^)())successCallback failedCallback:(void(^)())failedCallback;


@end
