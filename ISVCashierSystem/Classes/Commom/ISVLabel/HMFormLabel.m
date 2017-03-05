//
//  HMFormLabel.m
//  HealthMall
//
//  Created by jkl on 15/12/12.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMFormLabel.h"

@implementation HMFormLabel

+ (instancetype)formLabelWithPoint:(CGPoint)point
{
    HMFormLabel *label = [[self alloc] initWithFrame:CGRectMake(point.x, point.y, 70, 14)];
    
    return label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.font = [UIFont systemFontOfSize:14];
        self.textColor = ISVRGB(100, 100, 100);
    }
    
    return self;
}

@end
