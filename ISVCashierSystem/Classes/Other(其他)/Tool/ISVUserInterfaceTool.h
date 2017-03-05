//
//  ISVUserInterfaceTool.h
//  ISV
//
//  Created by aaaa on 15/10/30.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISVUserInterfaceTool : NSObject

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
