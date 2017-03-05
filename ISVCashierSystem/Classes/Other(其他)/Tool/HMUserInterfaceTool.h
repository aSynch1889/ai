//
//  HMUserInterfaceTool.h
//  HealthMall
//
//  Created by qiuwei on 15/10/30.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMUserInterfaceTool : NSObject

/**
 *  返回项目根控制器 tabBarController
 */
+ (nullable UITabBarController *)tabBarController;
/**
 *  返回正在展示的topViewController
 *
 *  @return topViewController
 */
+ (nullable UIViewController *)topViewController;

/**
 *  跳转到首页
 */
+ (void)showHomePage;

/**
 *  退回[管理]界面
 */
+ (void)popToMannagerPage;
@end
