//
//  ISVTabBarForUpViewController.m
//  ISV
//
//  Created by aaaa on 15/11/21.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVTabBarForUpViewController.h"

@interface ISVTabBarForUpViewController ()

@end

static const CGFloat kTabBarForUpDefaultTabbarHeight = 44.0f;
static const NSInteger kTabBarForUpTagOffset = 1000;

@implementation ISVTabBarForUpViewController
{
    UIView *_tabButtonsContainerView;
    UIView *_contentContainerView;
    UIImageView *_indicatorImageView;
    CGFloat _tabBarHeight;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tabBarHeight = kTabBarForUpDefaultTabbarHeight;
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // tabbar
    _tabButtonsContainerView = [[UIView alloc] init];
    _tabButtonsContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tabButtonsContainerView];
    
    // contentView
    _contentContainerView = [[UIView alloc] init];
    _contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_contentContainerView];
    
    // 选中按钮角标
    if (_showIndicator) {
        _indicatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ISVTabBarForUpIndicator"]];
        [self.view addSubview:_indicatorImageView];
    }
    
    [self reloadTabButtons];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _tabButtonsContainerView = nil;
    _contentContainerView = nil;
    _indicatorImageView = nil;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if ([self.dataSource respondsToSelector:@selector(heightFortabIntabBarForUpController:)]) {
        CGFloat customTabbarHeight = [self.dataSource heightFortabIntabBarForUpController:self];
        if (customTabbarHeight > 0) _tabBarHeight = customTabbarHeight;
    }
    
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, _tabBarHeight);
    _tabButtonsContainerView.frame = rect;
    
    rect.origin.y = _tabBarHeight;
    rect.size.height = self.view.bounds.size.height - _tabBarHeight;
    _contentContainerView.frame = rect;
    
    [self layoutTabButtons];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Only rotate if all child view controllers agree on the new orientation.
    for (UIViewController *viewController in self.viewControllers)
    {
        if (![viewController shouldAutorotateToInterfaceOrientation:interfaceOrientation])
            return NO;
    }
    return YES;
}

#pragma mark - Private
- (void)centerIndicatorOnButton:(UIButton *)button
{
    if (_showIndicator) {
        CGRect rect = _indicatorImageView.frame;
        rect.origin.x = button.center.x - floorf(_indicatorImageView.frame.size.width/2.0f);
        rect.origin.y = _tabBarHeight - _indicatorImageView.frame.size.height;
        _indicatorImageView.frame = rect;
        _indicatorImageView.hidden = NO;
    }
}

// 创建一个默认tabbar按钮
- (UIButton *)createTabButton:(NSString *)buttonTitle
{
    UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tabButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    //        button.titleLabel.shadowOffset = CGSizeMake(0, 1);
    //        [self deselectTabButton:button];
    
    [tabButton setTitle:buttonTitle forState:UIControlStateNormal];
//    UIImage *inactiveImage = [[UIImage imageNamed:@"ISVTabBarForUpInactiveTab"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
//    UIImage *activeImage = [[UIImage imageNamed:@"ISVTabBarForUpActiveTab"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
//    
//    [tabButton setBackgroundImage:inactiveImage forState:UIControlStateNormal];
//    [tabButton setBackgroundImage:inactiveImage forState:UIControlStateHighlighted];
//    [tabButton setBackgroundImage:activeImage forState:UIControlStateSelected];
    
    [tabButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return tabButton;
}

// 移除所有按钮
- (void)removeTabButtons
{
    NSArray *buttons = [_tabButtonsContainerView subviews];
    for (UIButton *button in buttons)
        [button removeFromSuperview];
}

// 添加所有按钮
- (void)addTabButtons
{
    NSUInteger index = 0;
    for (UIViewController *viewController in self.viewControllers)
    {
        UIButton *tabButton = nil;
        if([self.dataSource respondsToSelector:@selector(tabBarForUpController:tabButtonForItemAtIndex:)])
        {
            UIButton *customButton = [self.dataSource tabBarForUpController:self tabButtonForItemAtIndex:index];
            if (customButton) {
                tabButton = customButton;
                
            }else{
                tabButton = [self createTabButton:viewController.title];
            }
            
        }else{
            tabButton = [self createTabButton:viewController.title];
        }
        
        tabButton.tag = kTabBarForUpTagOffset + index;
        [tabButton addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_tabButtonsContainerView addSubview:tabButton];
        
        ++index;
    }
}

// 重载所有按钮
- (void)reloadTabButtons
{
    [self removeTabButtons];
    [self addTabButtons];
    
    // Force redraw of the previously active tab.
    NSUInteger lastIndex = _selectedIndex;
    _selectedIndex = NSNotFound;
    self.selectedIndex = lastIndex;
}

// 布局所有按钮
- (void)layoutTabButtons
{
    NSUInteger index = 0;
    NSUInteger count = [self.viewControllers count];
    
    CGFloat W = _tabButtonsContainerView.bounds.size.width;
    
    CGFloat buttonMargin = 0.0;
    if ([self.dataSource respondsToSelector:@selector(marginFortabButtonIntabBarForUpController:)]) {
        buttonMargin = [self.dataSource marginFortabButtonIntabBarForUpController:self];
    }
    CGFloat buttonX = 0;
    CGFloat buttonW = floorf((W - ((count - 1) * buttonMargin)) / count) + 1;// 加一像素误差
    
    NSArray *buttons = [_tabButtonsContainerView subviews];
    for (UIButton *button in buttons)
    {
        button.frame = CGRectMake(buttonX, 0, buttonW, _tabBarHeight);
        buttonX += buttonW + buttonMargin;
        
        if (index == self.selectedIndex)
            [self centerIndicatorOnButton:button];
        
        ++index;
    }
}

#pragma mark - setter/getter
- (void)setViewControllers:(NSArray *)newViewControllers
{
    NSAssert([newViewControllers count] >= 2, @"ISVTabBarForUpViewController requires at least two view controllers");
    
    UIViewController *oldSelectedViewController = self.selectedViewController;
    
    // Remove the old child view controllers.
    for (UIViewController *viewController in _viewControllers)
    {
        [viewController willMoveToParentViewController:nil];
        [viewController removeFromParentViewController];
    }
    
    _viewControllers = [newViewControllers copy];
    
    // This follows the same rules as UITabBarController for trying to
    // re-select the previously selected view controller.
    NSUInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
    if (newIndex != NSNotFound)
        _selectedIndex = newIndex;
    else if (newIndex < [_viewControllers count])
        _selectedIndex = newIndex;
    else
        _selectedIndex = 0;
    
    // Add the new child view controllers.
    for (UIViewController *viewController in _viewControllers)
    {
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
    
    if ([self isViewLoaded])
        [self reloadTabButtons];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex
{
    [self setSelectedIndex:newSelectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex animated:(BOOL)animated
{
    NSAssert(newSelectedIndex < [self.viewControllers count], @"View controller index out of bounds");
    
    if ([self.delegate respondsToSelector:@selector(tabBarForUpController:shouldSelectViewController:atIndex:)])
    {
        UIViewController *toViewController = [self.viewControllers objectAtIndex:newSelectedIndex];
        if (![self.delegate tabBarForUpController:self shouldSelectViewController:toViewController atIndex:newSelectedIndex])
            return;
    }
    
    if (![self isViewLoaded])
    {
        _selectedIndex = newSelectedIndex;
    }
    else if (_selectedIndex != newSelectedIndex)
    {
        UIViewController *fromViewController;
        UIViewController *toViewController;
        
        if (_selectedIndex != NSNotFound)
        {
            UIButton *fromButton = (UIButton *)[_tabButtonsContainerView viewWithTag:kTabBarForUpTagOffset + _selectedIndex];
//            [self deselectTabButton:fromButton];
            fromButton.selected = NO;
            fromViewController = self.selectedViewController;
        }
        
        NSUInteger oldSelectedIndex = _selectedIndex;
        _selectedIndex = newSelectedIndex;
        
        UIButton *toButton;
        if (_selectedIndex != NSNotFound)
        {
            toButton = (UIButton *)[_tabButtonsContainerView viewWithTag:kTabBarForUpTagOffset + _selectedIndex];
//            [self selectTabButton:toButton];
            toButton.selected = YES;
            toViewController = self.selectedViewController;
        }
        
        if (toViewController == nil)  // don't animate
        {
            [fromViewController.view removeFromSuperview];
        }
        else if (fromViewController == nil)  // don't animate
        {
            toViewController.view.frame = _contentContainerView.bounds;
            [_contentContainerView addSubview:toViewController.view];
            [self centerIndicatorOnButton:toButton];
            
            if ([self.delegate respondsToSelector:@selector(tabBarForUpController:didSelectViewController:atIndex:)])
                [self.delegate tabBarForUpController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
        }
        else if (animated)
        {
            _transiting = YES;
            
            CGRect rect = _contentContainerView.bounds;
            if (oldSelectedIndex < newSelectedIndex)
                rect.origin.x = rect.size.width;
            else
                rect.origin.x = -rect.size.width;
            
            toViewController.view.frame = rect;
            _tabButtonsContainerView.userInteractionEnabled = NO;
            
            [self transitionFromViewController:fromViewController
                              toViewController:toViewController
                                      duration:0.3
                                       options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                                    animations:^
             {
                 CGRect rect = fromViewController.view.frame;
                 if (oldSelectedIndex < newSelectedIndex)
                     rect.origin.x = -rect.size.width;
                 else
                     rect.origin.x = rect.size.width;
                 
                 fromViewController.view.frame = rect;
                 toViewController.view.frame = _contentContainerView.bounds;
                 [self centerIndicatorOnButton:toButton];
             }
                                    completion:^(BOOL finished)
             {
                 _tabButtonsContainerView.userInteractionEnabled = YES;
                 
                 if ([self.delegate respondsToSelector:@selector(tabBarForUpController:didSelectViewController:atIndex:)])
                     [self.delegate tabBarForUpController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
                 
                 _transiting = NO;
             }];
        }
        else  // not animated
        {
            [fromViewController.view removeFromSuperview];
            
            toViewController.view.frame = _contentContainerView.bounds;
            [_contentContainerView addSubview:toViewController.view];
            [self centerIndicatorOnButton:toButton];
            
            if ([self.delegate respondsToSelector:@selector(tabBarForUpController:didSelectViewController:atIndex:)])
                [self.delegate tabBarForUpController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
        }
    }
}

- (UIViewController *)selectedViewController
{
    if (self.selectedIndex != NSNotFound)
        return [self.viewControllers objectAtIndex:self.selectedIndex];
    else
        return nil;
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController
{
    [self setSelectedViewController:newSelectedViewController animated:NO];
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController animated:(BOOL)animated;
{
    NSUInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
    if (index != NSNotFound)
        [self setSelectedIndex:index animated:animated];
}

- (void)setShowIndicator:(BOOL)showIndicator
{
    _showIndicator = showIndicator;
    _indicatorImageView.hidden = !showIndicator;
}
#pragma mark - EVent
- (void)tabButtonPressed:(UIButton *)sender
{
    // 判断是否动画未完成
    if (_transiting) {
        return;
    }
    
    [self setSelectedIndex:sender.tag - kTabBarForUpTagOffset animated:YES];
}

@end
