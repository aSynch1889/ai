//
//  ISVTabBarForUpViewController.h
//  ISV
//
//  Created by aaaa on 15/11/21.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ISVTabBarForUpViewControllerDelegate, ISVTabBarForUpViewControllerDataSource;

// 顶部TabBar选项卡控制器
@interface ISVTabBarForUpViewController : UIViewController

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign, getter=isTransiting) BOOL transiting; // 是否正在执行动画;
@property (nonatomic, weak) id <ISVTabBarForUpViewControllerDelegate> delegate;
@property (nonatomic, weak) id <ISVTabBarForUpViewControllerDataSource> dataSource;

@property (nonatomic, assign, getter=isShowIndicator) BOOL showIndicator; // 是否显示选中按钮角标 默认为NO

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSelectedViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end


// 数据源
@protocol ISVTabBarForUpViewControllerDataSource <NSObject>

@optional

// 自定义tab按钮
- (UIButton *)tabBarForUpController:(ISVTabBarForUpViewController *)tabBarController tabButtonForItemAtIndex:(NSUInteger)index;

- (CGFloat)heightFortabIntabBarForUpController:(ISVTabBarForUpViewController *)tabBarController;
- (CGFloat)marginFortabButtonIntabBarForUpController:(ISVTabBarForUpViewController *)tabBarController;

@end

// 代理协议
@protocol ISVTabBarForUpViewControllerDelegate <NSObject>

@optional
- (BOOL)tabBarForUpController:(ISVTabBarForUpViewController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
- (void)tabBarForUpController:(ISVTabBarForUpViewController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
@end
