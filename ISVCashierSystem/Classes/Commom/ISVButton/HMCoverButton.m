//
//  HMCoverButton.m
//  HealthMall
//
//  Created by jkl on 15/11/19.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMCoverButton.h"

@implementation HMCoverButton

+ (instancetype)coverButtonWithFrame:(CGRect)frame
{
    HMCoverButton *btn = [[HMCoverButton alloc] initWithFrame:frame];
    return btn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return  self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    [self addTarget:self action:@selector(highlighted)
     forControlEvents:UIControlEventTouchDown];
    
    [self addTarget:self action:@selector(normal)
     forControlEvents:UIControlEventTouchUpInside|
                      UIControlEventTouchUpOutside|
                      UIControlEventTouchCancel];
    
    self.highlightedColor = HMRGBACOLOR(0, 0, 0, 0.1);
}


// 普通状态
- (void)normal
{
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = HMRGBACOLOR(0, 0, 0, 0.0);
    }];
}


// 高亮
- (void)highlighted
{
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = self.highlightedColor;
    }];
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}


@end
