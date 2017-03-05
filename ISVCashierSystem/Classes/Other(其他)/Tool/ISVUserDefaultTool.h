//
//  ISVUserDefaultTool.h
//  ISV
//
//  Created by aaaa on 15/11/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kIMAutoLogin  @"IsAutoLogin"

@interface ISVUserDefaultTool : NSObject

// 当前是否自动登录
+ (BOOL)currentClientIsAutoLogin;

// 设置是否自动登录
+ (void)setAutoLogin:(BOOL)isAutoLogin;

// 设置消息声音提示开关
+ (void)settingVoice:(BOOL)isOpen;

// 设置消息震动提示开关
+ (void)settingShock:(BOOL)isOpen;

// 设置接收新消息的提示开关
+ (void)settingInceptNews:(BOOL)isOpen;

// 获取消息声音提示开关
+ (BOOL)isVoiceOpen;

// 获取消息震动提示开关
+ (BOOL)isShockOpen;

// 接收新消息的提示开关
+ (BOOL)isInceptNews;

@end
