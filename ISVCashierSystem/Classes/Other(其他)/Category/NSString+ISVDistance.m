//
//  NSString+ISVDistance.m
//  ISV
//
//  Created by aaaa on 15/11/27.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "NSString+ISVDistance.h"

@implementation NSString (ISVDistance)

/*
 距离显示规则如下：
 小于1000m的，显示为xxxm，比如200m；超过1000m显示为xkm，比如2.8km，保留1位小数;
 */

- (NSString *)distance
{
    // 把km转为m
    CGFloat m = [self floatValue] * 1000;
    if (m < 100.0)
    {
        return @"<100m";
    }
    else if (m < 1000.0-0.000001)
    {
        return [NSString stringWithFormat:@"%.lfm", m];
    }
    else
    {
        return [NSString stringWithFormat:@"%.1lfkm", m / 1000.0];
    }
}

@end
