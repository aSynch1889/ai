//
//  UINavigationController+ISVLandscape.m
//  ISV
//
//  Created by aaaa on 16/3/1.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "UINavigationController+ISVLandscape.h"

@implementation UINavigationController (ISVLandscape)
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
