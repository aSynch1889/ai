//
//  HMHollowButton.m
//  HealthMall
//
//  Created by jkl on 15/12/14.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMHollowButton.h"

@implementation HMHollowButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    
    return self;
}

+ (instancetype)hollowButtonWithTitle:(NSString *)title frame:(CGRect)frame
{
    HMHollowButton *btn = [[self alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.themeColor = ISVMainColor;
    btn.layer.cornerRadius = frame.size.height * 0.3;
    btn.layer.borderWidth = 0.5;
    btn.layer.masksToBounds = YES;
    [btn normal];
    return btn;
}

- (void)setup
{
    [self addTarget:self action:@selector(highlighted)
   forControlEvents:UIControlEventTouchDown];
    
    [self addTarget:self action:@selector(normal)
   forControlEvents:UIControlEventTouchUpInside|
     UIControlEventTouchUpOutside|
     UIControlEventTouchCancel];
}

- (void)setThemeColor:(UIColor *)themeColor
{
    _themeColor = themeColor;
    self.layer.borderColor = themeColor.CGColor;
    [self setTitleColor:themeColor forState:UIControlStateNormal];
}

// 普通状态
- (void)normal
{
    self.backgroundColor = [UIColor whiteColor];
    [self setTitleColor:self.themeColor forState:UIControlStateNormal];
}


// 高亮
- (void)highlighted
{
    self.backgroundColor = self.themeColor;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)setHighlighted:(BOOL)highlighted
{

}


@end
