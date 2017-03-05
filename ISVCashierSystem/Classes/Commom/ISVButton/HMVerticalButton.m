//
//  HMVerticalButton.m
//  HealthMall
//
//  Created by qiuwei on 15/12/15.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMVerticalButton.h"

@implementation HMVerticalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 图片
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = 0;
    
    // 文字
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
