//
//  HMUserDefaultTool.m
//  HealthMall
//
//  Created by qiuwei on 15/11/5.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMUserDefaultTool.h"


#define kIMMessageVoice @"Setting_Message_Voice"
#define kIMMessageShock @"Setting_Message_Shock"
#define kIMMessageInceptNews @"kSetting_Message_News"

@implementation HMUserDefaultTool

// 当前是否自动登录
+ (BOOL)currentClientIsAutoLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIMAutoLogin];
}

// 设置是否自动登录
+ (void)setAutoLogin:(BOOL)isAutoLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isAutoLogin forKey:kIMAutoLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 设置消息声音提示开关
+ (void)settingVoice:(BOOL)isOpen
{
    [[NSUserDefaults standardUserDefaults] setBool:isOpen forKey:kIMMessageVoice];
}

// 设置消息震动提示开关
+ (void)settingShock:(BOOL)isOpen
{
    [[NSUserDefaults standardUserDefaults] setBool:isOpen forKey:kIMMessageShock];
}

// 设置接收新消息的提示开关
+ (void)settingInceptNews:(BOOL)isOpen
{
    [[NSUserDefaults standardUserDefaults] setBool:isOpen forKey:kIMMessageInceptNews];
}

// 获取消息声音提示开关
+ (BOOL)isVoiceOpen
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIMMessageVoice];
}

// 获取消息震动提示开关
+ (BOOL)isShockOpen
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIMMessageShock];
}

// 接收新消息的提示开关
+ (BOOL)isInceptNews
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIMMessageInceptNews];
}

@end
