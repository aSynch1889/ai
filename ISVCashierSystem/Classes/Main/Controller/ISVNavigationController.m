//
//  ISVNavigationController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/2.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "ISVNavigationController.h"
#import "UIImage+ISVExtension.h"

@interface ISVNavigationController ()

@end

@implementation ISVNavigationController

+(void)initialize {
    // 设置导航栏背景色
    UINavigationBar *nav = [UINavigationBar appearance];
    nav.barTintColor = ISVMainlColor;
    nav.tintColor = [UIColor whiteColor];
    
    [nav setShadowImage:[UIImage new]];
    
    // 设置导航栏字体颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [nav setTitleTextAttributes:attrs];

}

/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 如果push进来的不是第一个控制器就隐藏tabbar
    if (self.childViewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 设置导航栏返回按钮的title为空
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:0 target:nil action:NULL];
    
    [super pushViewController:viewController animated:animated];
    
}


@end
