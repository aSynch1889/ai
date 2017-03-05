//
//  ISVLabelButton.m
//  ISV
//
//  Created by aaaa on 15/11/22.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVLabelButton.h"

@implementation ISVLabelButton

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
