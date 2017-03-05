//
//  HMPaopaoView.m
//  HealthMall
//
//  Created by qiuwei on 15/12/28.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMPaopaoView.h"
#import "HMPointAnnotation.h"

#define kPaopaoViewMargin 10.0
#define kPaopaoViewRowMargin 5.0
#define kPaopaoViewButtonW 160.0
#define kPaopaoViewButtonH 30.0

@interface HMPaopaoView ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIButton *button;
@end
@implementation HMPaopaoView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(![self.titleLabel.text isKindOfClass:[NSNull class]])
        [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(kPaopaoViewMargin, kPaopaoViewMargin, self.width - kPaopaoViewMargin * 2, self.titleLabel.height);
    if(![self.contentLabel.text isKindOfClass:[NSNull class]])
        [self.contentLabel sizeToFit];
    self.contentLabel.frame = CGRectMake(kPaopaoViewMargin, CGRectGetMaxY(self.titleLabel.frame) + kPaopaoViewRowMargin, self.titleLabel.width, self.contentLabel.height);
    
    CGFloat buttonY = CGRectGetMaxY(self.contentLabel.frame);
    if (!self.contentLabel.height) {
        buttonY = CGRectGetMaxY(self.titleLabel.frame);
    }
//    if (self.state != HMPaopaoViewStateNor) {
        [self.button sizeToFit];
        self.button.frame = CGRectMake(kPaopaoViewMargin, buttonY + kPaopaoViewRowMargin, kPaopaoViewButtonW, kPaopaoViewButtonH);
        self.button.centerX = self.centerX;
//    }
    
    self.height = CGRectGetMaxY(self.button.frame) + kPaopaoViewMargin;
}

- (void)setPointAnnotation:(HMPointAnnotation *)pointAnnotation
{
    _pointAnnotation = pointAnnotation;
    
    self.titleLabel.text = pointAnnotation.title;
    if (![pointAnnotation.subtitle isKindOfClass:[NSNull class]]) {
        self.contentLabel.text = pointAnnotation.subtitle;
    }
    
}

- (void)setButtonTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle
{
    if (title) {
      [self.button setTitle:title forState:UIControlStateNormal];
    }
    if (selectedTitle) {
        [self.button setTitle:selectedTitle forState:UIControlStateSelected];
    }
    
}

- (void)setState:(HMPaopaoViewState)state
{
    _state = state;
    
    if (state == HMPaopaoViewStateAdd) {
        self.button.selected = state;
        [self.button setBackgroundImage:[UIImage imageNamed:@"Button_radius5_greenBorder_hig"] forState:UIControlStateHighlighted];
    }else if(state == HMPaopaoViewStateDel){
        self.button.selected = state;
        [self.button setBackgroundImage:[UIImage imageNamed:@"Button_radius5_redBorder_hig"] forState:UIControlStateHighlighted];
    }else if(state == HMPaopaoViewStateNor){
        self.button.hidden = YES;
        [self.button setBackgroundImage:nil forState:UIControlStateNormal];
        self.button.height = 0;
    }
    
}


#pragma mark - 懒加载
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = HMFontSize(14.0);
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = kColorBlackPercent40;
        label.font = HMFontSize(14.0);
        label.numberOfLines = 0;
        [self addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIButton *)button
{
    if (_button == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 5.0;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = HMFontSize(14.0);
        btn.titleLabel.textColor = HMMainlColor;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:HMMainlColor forState:UIControlStateNormal];
        [btn setTitle:kStringAdd forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"Button_radius5_greenBorder_nor"] forState:UIControlStateNormal];
        [btn setTitleColor:HMContraColor forState:UIControlStateSelected];
        [btn setTitle:kStringDel forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"Button_radius5_redBorder_nor"] forState:UIControlStateSelected];
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
        _button = btn;
    }
    return _button;
}
@end
