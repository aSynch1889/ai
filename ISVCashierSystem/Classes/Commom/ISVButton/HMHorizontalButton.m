//
//  HMHorizontalButton.m
//  HealthMall
//
//  Created by qiuwei on 15/10/31.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMHorizontalButton.h"
#import "UIImage+HMExtension.h"

@implementation HMHorizontalButton

+ (instancetype)buttonwithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName title:(NSString *)title
{
    UIButtonType type = highlightedImageName ? UIButtonTypeCustom : UIButtonTypeSystem; // Added By jkl
    HMHorizontalButton *button = [self buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamedForOriginal:imageName] forState:UIControlStateNormal];
    
    if (highlightedImageName)
    {
        [button setImage:[UIImage imageNamedForOriginal:highlightedImageName] forState:UIControlStateHighlighted];
    }
    
    return button;
}

+ (instancetype)buttonwithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title
{
    UIButtonType type = selectedImageName ? UIButtonTypeCustom : UIButtonTypeSystem;
    
    HMHorizontalButton *button = [self buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamedForOriginal:imageName] forState:UIControlStateNormal];
    
    if (selectedImageName)
    {
        [button setImage:[UIImage imageNamedForOriginal:selectedImageName] forState:UIControlStateSelected];
    }

    return button;
}

+ (instancetype)buttonwithImageName:(NSString *)imageName title:(NSString *)title
{
    return [self buttonwithImageName:imageName highlightedImageName:nil title:title];
}

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
    _isTitleAtLeft = YES;
    _margin = 5;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView *leftView;
    UIView *rightView;
    
    if (_isTitleAtLeft) {// 文字在左边
        leftView = self.titleLabel;
        rightView = self.imageView;
    }else{
        leftView = self.imageView;
        rightView = self.titleLabel;
    }
    
    CGFloat left = (self.width - leftView.width - rightView.width - _margin) * 0.5;
    // 左视图
    leftView.x = left;
    
    // 右视图
    CGFloat rightViewW = rightView.width;
    CGFloat rightViewH = rightView.height;
    CGFloat rightViewX = CGRectGetMaxX(leftView.frame) + _margin;
    CGFloat rightViewY = (self.height - rightViewH) * 0.5;
    
    rightView.frame = CGRectMake(rightViewX, rightViewY, rightViewW, rightViewH);
}

- (void)setIsTitleAtLeft:(BOOL)isTitleAtLeft
{
    _isTitleAtLeft = isTitleAtLeft;
    [self setNeedsLayout];
}

@end
