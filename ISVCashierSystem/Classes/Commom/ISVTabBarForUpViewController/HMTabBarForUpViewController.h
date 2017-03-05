//
//  HMTabBarForUpViewController.h
//  HealthMall
//
//  Created by qiuwei on 15/11/21.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMTabBarForUpViewControllerDelegate, HMTabBarForUpViewControllerDataSource;

// 顶部TabBar选项卡控制器
@interface HMTabBarForUpViewController : UIViewController

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign, getter=isTransiting) BOOL transiting; // 是否正在执行动画;
@property (nonatomic, weak) id <HMTabBarForUpViewControllerDelegate> delegate;
@property (nonatomic, weak) id <HMTabBarForUpViewControllerDataSource> dataSource;

@property (nonatomic, assign, getter=isShowIndicator) BOOL showIndicator; // 是否显示选中按钮角标 默认为NO

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSelectedViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end


// 数据源
@protocol HMTabBarForUpViewControllerDataSource <NSObject>

@optional

// 自定义tab按钮
- (UIButton *)tabBarForUpController:(HMTabBarForUpViewController *)tabBarController tabButtonForItemAtIndex:(NSUInteger)index;

- (CGFloat)heightFortabIntabBarForUpController:(HMTabBarForUpViewController *)tabBarController;
- (CGFloat)marginFortabButtonIntabBarForUpController:(HMTabBarForUpViewController *)tabBarController;

@end

// 代理协议
@protocol HMTabBarForUpViewControllerDelegate <NSObject>

@optional
- (BOOL)tabBarForUpController:(HMTabBarForUpViewController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
- (void)tabBarForUpController:(HMTabBarForUpViewController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
@end