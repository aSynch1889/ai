//
//  ISVUserInterfaceTool.m
//  ISV
//
//  Created by aaaa on 15/10/30.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVUserInterfaceTool.h"
#import "AppDelegate.h"

@implementation ISVUserInterfaceTool

+ (nullable UITabBarController *)tabBarController
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    for (UIWindow *window in windows) {
        
        UITabBarController *tabbarVC = (UITabBarController *)window.rootViewController;
        
        if ([tabbarVC isKindOfClass:[UITabBarController class]]) {
            return tabbarVC;
        }
    }
    return nil;
}

// 返回正在展示的topViewController
+ (nullable UIViewController *)topViewController
{
    UITabBarController *tabbarVC = [self tabBarController];
    
    if (tabbarVC) {
        UINavigationController *navVC = tabbarVC.selectedViewController;
        
        if ([navVC isKindOfClass:[UINavigationController class]]) {
            return navVC.topViewController;
        }else{
            return navVC.navigationController.topViewController;
        }
        return tabbarVC.navigationController.topViewController;
    }
    return nil;
}

// 跳转到首页
+ (void)showHomePage
{

    
}

/**
 *  退回[管理]界面
 */
+ (void)popToMannagerPage
{

}

@end
