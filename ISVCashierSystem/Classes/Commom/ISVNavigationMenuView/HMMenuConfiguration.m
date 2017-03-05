//
//  HMMenuConfiguration.m
//  test
//
//  Created by healthmall005 on 15/12/2.
//  Copyright © 2015年 healthmall005. All rights reserved.
//

#import "HMMenuConfiguration.h"

@implementation HMMenuConfiguration
//Menu width
+ (float)menuWidth
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return window.frame.size.width;
}

//Menu item height
+ (float)itemCellHeight
{
    return 40.0f;
}

//Animation duration of menu appearence
+ (float)animationDuration
{
    return 0.3f;
}

//Menu substrate alpha value
+ (float)backgroundAlpha
{
    return 0.6;
}

//Menu alpha value
+ (float)menuAlpha
{
    return 0.0;
}

//Value of bounce
+ (float)bounceOffset
{
    return -7.0;
}

//Arrow image near title
+ (UIImage *)arrowImage
{
    return [UIImage imageNamed:@"myOrder_Triangle_NotSel"];
}

//Distance between Title and arrow image
+ (float)arrowPadding
{
    return 10.0;
}

//Items color in menu
+ (UIColor *)itemsColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)mainColor
{
    return [UIColor blackColor];
}

+ (float)selectionSpeed
{
    return 0.15;
}

+ (UIColor *)itemTextColor
{
    return [UIColor lightGrayColor];
}

@end
