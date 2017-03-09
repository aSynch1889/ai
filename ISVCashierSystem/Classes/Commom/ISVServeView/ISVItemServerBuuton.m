//
//  ISVItemServerBuuton.m
//  ISV
//
//  Created by aaaa on 15/12/9.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVItemServerBuuton.h"

@implementation ISVItemServerBuuton

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
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = ISVFontSize(10);
    [self setTitleColor:kColorBlackPercent60 forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // 图片
    self.imageView.height = 32;
    self.imageView.width = self.width;
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = 0;

    // 文字
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.height = self.height - self.imageView.height;
    
}

@end
