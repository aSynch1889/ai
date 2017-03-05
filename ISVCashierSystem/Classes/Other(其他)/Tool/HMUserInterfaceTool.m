//
//  HMUserInterfaceTool.m
//  HealthMall
//
//  Created by qiuwei on 15/10/30.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMUserInterfaceTool.h"
#import "HMManagementViewController.h"
#import "AppDelegate.h"
#import "HMStatusBarWidow.h"

@implementation HMUserInterfaceTool

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
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.isFullScreen = NO;
 
    [HMStatusBarWidow show];
    
    UITabBarController *tabbarVC = [self tabBarController];
    
    UIViewController *topVC = [HMUserInterfaceTool topViewController];
    [topVC dismissViewControllerAnimated:YES completion:nil];
    
    for (UINavigationController *navVc in tabbarVC.childViewControllers) {
        [navVc popToRootViewControllerAnimated:YES];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (tabbarVC) {
            tabbarVC.selectedIndex = 0;
        }
    });
    
}

/**
 *  退回[管理]界面
 */
+ (void)popToMannagerPage
{
    UINavigationController *meNav = [[HMUserInterfaceTool tabBarController].childViewControllers lastObject];
    
    if (meNav.childViewControllers.count > 1) {
        HMManagementViewController *managerVC = (HMManagementViewController *)meNav.childViewControllers[1];
        if ([managerVC isKindOfClass:[HMManagementViewController class]]) {
            [managerVC reloadData];
            [meNav popToViewController:managerVC animated:YES];
        }
    }
}

@end
