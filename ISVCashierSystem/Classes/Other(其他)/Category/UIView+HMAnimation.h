//
//  UIView+HMAnimation.h
//  HealthMall
//
//  Created by qiuwei on 15/12/13.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HMAnimation)

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
