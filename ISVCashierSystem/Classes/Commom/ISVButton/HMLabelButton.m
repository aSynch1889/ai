//
//  HMLabelButton.m
//  HealthMall
//
//  Created by qiuwei on 15/11/22.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMLabelButton.h"

@implementation HMLabelButton

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setUp];
}

- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
}
- (void)setHighlighted:(BOOL)highlighted
{
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}

@end
