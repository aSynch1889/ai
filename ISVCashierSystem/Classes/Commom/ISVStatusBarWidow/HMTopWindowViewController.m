//
//  HMTopWindowViewController.m
//  HealthMall
//
//  Created by qiuwei on 15/11/2.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMTopWindowViewController.h"

@interface HMTopWindowViewController ()

@end

@implementation HMTopWindowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.statusBarStyle = UIStatusBarStyleLightContent;
}


#pragma mark - 状态栏控制
- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}

#pragma mark - setter
- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    _statusBarHidden = statusBarHidden;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
