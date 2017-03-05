//
//  HMFormFootView.m
//  HealthMall
//
//  Created by qiuwei on 15/11/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMFormFootView.h"

#define kTopBoder 3.0

@interface HMFormFootView ()
{
    UIView *_contentView;
    HMBaseFormSubmitButton *_submitButton;
}
@property (nonatomic, weak) UIView *warpView;
@end

@implementation HMFormFootView

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
    self.backgroundColor = HMBackgroundColor;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.warpView.frame = CGRectMake(0, kTopBoder, self.width, self.height - kTopBoder);
    
    self.submitButton.y = self.height - self.submitButton.height - kFormItemTextTopBottomMargin;
}

#pragma mark - 懒加载
- (UIView *)warpView
{
    if (_warpView == nil) {
        UIView *warpView = [[UIView alloc] init];
        warpView.backgroundColor = [UIColor whiteColor];
        [self addSubview:warpView];
        _warpView = warpView;
    }
    return _warpView;
}

- (UIView *)contentView
{
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        
        [self.warpView addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}
#pragma mark - 懒加载
- (HMBaseFormSubmitButton *)submitButton
{
    if (_submitButton == nil) {
        HMBaseFormSubmitButton *submitButton = [HMBaseFormSubmitButton buttonWithType:UIButtonTypeCustom];
        [self.warpView addSubview:submitButton];
        _submitButton = submitButton;
    }
    return _submitButton;
}
@end
