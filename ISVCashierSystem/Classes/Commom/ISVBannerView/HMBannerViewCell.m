//
//  HMBannerViewCell.m
//  HealthMall
//
//  Created by jkl on 15/11/4.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMBannerViewCell.h"

@implementation HMBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.opaque = YES;
    imageView.clearsContextBeforeDrawing = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView = imageView;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}

@end
