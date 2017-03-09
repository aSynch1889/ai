//
//  ISVRuleTool.h
//  ISV
//
//  Created by aaaa on 17/3/02.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISVRuleTool : NSObject

/**
 *  跳转浏览器
 */
+ (void)ruleForWebWithViewController:(UIViewController *)viewController urlString:(NSString *)urlString;


/**
 *  其他规则处理
 */
+ (void)ruleForOtherWithViewController:(UIViewController *)viewController urlString:(NSString *)urlString;
@end
