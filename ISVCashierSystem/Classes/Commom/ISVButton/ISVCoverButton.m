//
//  ISVCoverButton.m
//  ISV
//
//  Created by aaaa on 15/11/19.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVCoverButton.h"

@implementation ISVCoverButton

+ (instancetype)coverButtonWithFrame:(CGRect)frame
{
    ISVCoverButton *btn = [[ISVCoverButton alloc] initWithFrame:frame];
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
    [super awakeFromNib];
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
    
    self.highlightedColor = ISVRGBACOLOR(0, 0, 0, 0.1);
}


// 普通状态
- (void)normal
{
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = ISVRGBACOLOR(0, 0, 0, 0.0);
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
