//
//  ISVFormLabel.m
//  ISV
//
//  Created by aaaa on 15/12/12.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVFormLabel.h"

@implementation ISVFormLabel

+ (instancetype)formLabelWithPoint:(CGPoint)point
{
    ISVFormLabel *label = [[self alloc] initWithFrame:CGRectMake(point.x, point.y, 70, 14)];
    
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
