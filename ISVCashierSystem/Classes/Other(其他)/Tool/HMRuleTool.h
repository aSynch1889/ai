//
//  HMRuleTool.h
//  HealthMall
//
//  Created by qiuwei on 16/1/21.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMRuleTool : NSObject

/**
 *  添加好友
 */
+ (void)ruleForAddFriendWithViewController:(UIViewController *)viewController userID:(NSString *)userID;

/**
 *  加入群
 */
+ (void)ruleForJoinTribeWithViewController:(UIViewController *)viewController userID:(NSString *)userID;

/**
 *  跳转浏览器
 */
+ (void)ruleForWebWithViewController:(UIViewController *)viewController urlString:(NSString *)urlString;


/**
 *  其他规则处理
 */
+ (void)ruleForOtherWithViewController:(UIViewController *)viewController urlString:(NSString *)urlString;
@end
