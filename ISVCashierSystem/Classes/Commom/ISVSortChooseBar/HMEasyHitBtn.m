//
//  HMEasyHitBtn.m
//  HealthMall
//
//  Created by jkl on 15/11/18.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMEasyHitBtn.h"

#define kBackgoundColorForNormal HMRGB(240, 240, 240)
#define kBackgoundColorForSelected HMMainlColor

@implementation HMEasyHitBtn

+ (instancetype)easyHitBtn
{
    HMEasyHitBtn *btn = [[self alloc] init];

    [btn setTitleColor:HMRGB(150, 150, 150) forState:UIControlStateNormal];
    [btn setTitleColor:HMRGB(255, 255, 255) forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:btn action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.titleLabel.textColor = HMRGB(150, 150, 150);
        self.titleLabel.backgroundColor = kBackgoundColorForNormal;
        self.titleLabel.layer.cornerRadius = 8;
        self.titleLabel.layer.masksToBounds = YES;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.tintColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = 20;
    CGFloat titleY = (contentRect.size.height - titleHeight) * 0.5;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX,titleY, titleWidth, titleHeight);
}


- (void)touchUpInside
{
    if (self.isSelected)
    {
        [super setSelected:NO];
        self.titleLabel.backgroundColor = kBackgoundColorForNormal;
    }
    else
    {
        [super setSelected:YES];
        self.titleLabel.backgroundColor = kBackgoundColorForSelected;
    }
}

- (void)setSelected:(BOOL)selected
{
    if (selected)
    {
        [super setSelected:YES];
        self.titleLabel.backgroundColor = kBackgoundColorForSelected;
    }
    else
    {
        [super setSelected:NO];
        self.titleLabel.backgroundColor = kBackgoundColorForNormal;
    }

}


- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
