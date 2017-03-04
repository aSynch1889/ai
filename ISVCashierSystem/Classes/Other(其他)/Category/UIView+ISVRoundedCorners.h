//
//  UIView+ISVRoundedCorners.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ISVRoundedCorners)
/**
 *  把View设置为圆角
 *
 *  @param corners 圆角类型
 *  @param radius  圆角半径
 */
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;

@end
