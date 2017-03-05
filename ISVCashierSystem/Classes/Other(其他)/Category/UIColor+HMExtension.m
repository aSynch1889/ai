//
//  UIColor+HMExtension.m
//  HealthMall
//
//  Created by qiuwei on 15/11/3.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "UIColor+HMExtension.h"

@implementation UIColor (HMExtension)

/**
 *  用16进制颜色字符串获取UIColor类型 不透明
 */
+ (UIColor *)colorWithHexColor:(NSString *)stringToConvert {
    return [UIColor colorWithHexColor:stringToConvert alpha:1.0f];
}

/**
 *  用16进制颜色字符串获取UIColor类型 可透明
 */
+ (UIColor *)colorWithHexColor:(NSString *)stringToConvert alpha:(CGFloat)alpha {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

/**
 *  获取一个随机的颜色
 */
+ (UIColor *)randomColor {
    CGFloat red   = arc4random_uniform(256) / 255.f;
    CGFloat green = arc4random_uniform(256) / 255.f;
    CGFloat blue  = arc4random_uniform(256) / 255.f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
}

+ (UIColor *)color:(UIColor *)color_ withAlpha:(float)alpha_
{
    UIColor *uicolor = color_;
    CGColorRef colorRef = [uicolor CGColor];
    
    unsigned long numComponents = CGColorGetNumberOfComponents(colorRef);
    
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(colorRef);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha_];
}

+ (UIColor *)OrderStatusColorHandleWithStatus:(NSUInteger )status{
    UIColor *orderStatusColor;
    //TODO: 待完善各种状态的颜色
    if (status == HMOrderStatusToBeConfirm) {
        orderStatusColor = ISVMainColor;
    }else if (status == HMOrderStatusNoPayment){
        orderStatusColor = kColortRed;
    }else if (status == HMOrderStatusCanceled){
        orderStatusColor = kColorBlackPercent20;
    }else if (status == HMOrderStatusCompleted){
        orderStatusColor = kColorBlackPercent20;
    }else if (status == HMOrderStatusPaid){
        orderStatusColor = kColorBlackPercent20;
    }else if (status == HMOrderStatusProcessing){
        orderStatusColor = kColorBlackPercent20;
    }else if (status == HMOrderStatusAllowance){
        orderStatusColor = kColorBlackPercent20;
    }else if (status == HMOrderStatusCancelAfterVerific){
        orderStatusColor = kColorBlackPercent20;
    }else if (status == HMOrderStatusWaitComment){
        orderStatusColor = ISVMainColor;
    }else {
        orderStatusColor = kColorBlackPercent20;
    }
    return orderStatusColor;
}

@end
