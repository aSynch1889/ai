//
//  ISVBannerViewCell.m
//  ISV
//
//  Created by aaaa on 17/03/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVBannerViewCell.h"

@implementation ISVBannerViewCell

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
