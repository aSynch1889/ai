//
//  ISVTabBarController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/2.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "ISVTabBarController.h"
#import "ISVHomeViewController.h"
#import "ISVMeViewController.h"
#import "ISVNavigationController.h"
#import "UIImage+ISVExtension.h"

@interface ISVTabBarController ()

@end

@implementation ISVTabBarController

+(void)initialize {
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"home"]];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = kTabBarItemFontSize;
    attrs[NSForegroundColorAttributeName] = kTabBarItemFontColorNormal;
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = kTabBarItemFontColorSelected;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加子控制器
    [self setupChildVc:[[ISVHomeViewController alloc] init] title:@"首页" image:@"homepageNormal" selectedImage:@"homepageSelected"];
    
    [self setupChildVc:[[ISVMeViewController alloc] init] title:@"我的" image:@"meNormal" selectedImage:@"meSelected"];
    
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamedForOriginal:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamedForOriginal:selectedImage];
    vc.tabBarItem.tag = self.viewControllers.count;
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    ISVNavigationController *nav = [[ISVNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
