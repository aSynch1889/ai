//
//  UIView+ISVAnimation.h
//  ISV
//
//  Created by aaaa on 15/12/13.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ISVAnimation)

/**
 *  以动画弹出
 */
- (void)showAlertAnimation;
/**
 *  以缩放动画展示
 */
- (void)showScalesAnimation;
/**
 *  还原缩放动画
 */
- (void)disScalesAnimation;
@end
