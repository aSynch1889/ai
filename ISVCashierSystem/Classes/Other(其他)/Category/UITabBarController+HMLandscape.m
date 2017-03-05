//
//  UITabBarController+HMLandscape.m
//  HealthMall
//
//  Created by qiuwei on 16/3/1.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "UITabBarController+HMLandscape.h"

@implementation UITabBarController (HMLandscape)

/**
 *  只允许竖屏向上
 */
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationPortrait;
//}
@end
