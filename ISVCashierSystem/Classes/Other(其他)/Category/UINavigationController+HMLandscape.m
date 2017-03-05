//
//  UINavigationController+HMLandscape.m
//  HealthMall
//
//  Created by qiuwei on 16/3/1.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "UINavigationController+HMLandscape.h"

@implementation UINavigationController (HMLandscape)
/**
 *  允许横竖屏
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


//- (BOOL)shouldAutorotate
//{
//    return [self.viewControllers.lastObject shouldAutorotate];
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return [self.viewControllers.lastObject supportedInterfaceOrientations];
//}

@end
