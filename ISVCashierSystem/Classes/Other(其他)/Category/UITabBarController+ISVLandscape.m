//
//  UITabBarController+ISVLandscape.m
//  ISV
//
//  Created by aaaa on 16/3/1.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "UITabBarController+ISVLandscape.h"

@implementation UITabBarController (ISVLandscape)

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
