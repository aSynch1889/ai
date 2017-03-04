//
//  UIButton+ISVExt.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "UIButton+ISVExt.h"

@implementation UIButton (ISVExt)

/**
    调整按钮文本和图片位置（左文本右图片）
 */
- (void)adjustButtonImageRightAndTitleLeft {
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, -self.titleLabel.bounds.size.width)];
}

/**
    调整按钮文本和图片位置 （上图下文本）
 */
- (void)adjustButtonImageTopAndTitleBottom {
    // 按钮图片和标题总高度
    CGFloat totalHeight = (self.imageView.frame.size.height + self.titleLabel.frame.size.height);
    
    // 设置按钮图片偏移
    [self setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - self.imageView.frame.size.height), 0.0, 0.0, -self.titleLabel.frame.size.width)];
    
    // 设置按钮标题偏移
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -self.imageView.frame.size.width, -(totalHeight - self.titleLabel.frame.size.height),0.0)];
}

@end
