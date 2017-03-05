//
//  UIBarButtonItem+ISVExtension.m
//  ISV
//
//  Created by aaaa on 15/10/31.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "UIBarButtonItem+ISVExtension.h"

@implementation UIBarButtonItem (ISVExtension)

+ (instancetype)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    return [self itemWithImageName:imageName highImageName:highImageName title:nil target:target action:action];
}

+ (instancetype)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName title:(NSString *)title target:(id)target action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    if (imageName)
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (highImageName)
        [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    //    button.size = button.currentBackgroundImage.size;
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

/**
 *  返回按钮
 */
+ (instancetype)backBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIImage *icon = [[UIImage imageNamed:@"BackNavButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setImage:icon forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 40);
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:leftBtn];
}
@end
