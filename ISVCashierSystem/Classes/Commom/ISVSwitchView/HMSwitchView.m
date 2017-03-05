//
//  HMSwitchView.m
//  HealthMall
//
//  Created by qiuwei on 15/11/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMSwitchView.h"
#import "HMSwitch.h"
#import "HMNoHighlightButton.h"
#import "HMHorizontalButton.h"

#define kSwitchViewButtonCornerRadius 10.0
#define kSwitchViewButtonMargin 10.0

@interface HMSwitchView ()
{
    UIButton *_currenButton;
}
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation HMSwitchView
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
    // 默认按钮间距
    if (!_buttonMargin) {
        _buttonMargin = kSwitchViewButtonMargin;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat W = self.width - (_edgeInsets.left + _edgeInsets.right);
    CGFloat H = self.height - (_edgeInsets.top + _edgeInsets.bottom);
    
    CGFloat btnW = self.buttonwidth > 0 ? self.buttonwidth : (W - _buttonMargin * (_buttons.count - 1)) / self.buttons.count;
    
    CGFloat maxX = 0;
    for (int i = 0; i < self.buttons.count; i ++) {
        UIView *btn = self.buttons[i];
        CGFloat btnX = i * (btnW + _buttonMargin) + _edgeInsets.left;
        btn.frame = CGRectMake(btnX, _edgeInsets.top, btnW, H);
        
        maxX = btnX + btnW;
    }
    
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(maxX, self.height);
}

#pragma mark - Event
- (void)switchClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(switchShouldClick:index:)]) {
        BOOL should = [self.delegate switchShouldClick:self index:button.tag];
        if (!should) { return; }
    }
    
    if(_currenButton == button) return;
    
    button.selected = YES;
    _currenButton.selected = NO;
    _currenButton = button;
    
    [self.delegate switchClick:self index:button.tag];
}

#pragma mark - setter/getter
- (void)setSwitchs:(NSArray<HMSwitch *> *)switchs
{
    _switchs = switchs;
    
    [self.buttons removeAllObjects];
    [self.scrollView removeAllSubviews];
    
    for (int i = 0; i < switchs.count; i++) {
        
        HMSwitch *switchModel = switchs[i];
        
        UIButton *btn;
        
        // 如果有小图标
        if (switchModel.iconName.length > 0) {
           btn = [HMHorizontalButton buttonwithImageName:switchModel.iconName title:switchModel.title];
            HMHorizontalButton *button = (HMHorizontalButton *)btn;
            button.isTitleAtLeft = NO;
        }else{
            btn = [HMNoHighlightButton buttonWithType:UIButtonTypeCustom];
        }
        
        btn.tag = i;
        
        [btn setTitle:switchModel.title forState:UIControlStateNormal];
        btn.titleLabel.font = ISVFontSize(13.0);
        
        [btn setTitleColor:ISVRGB(92, 92, 92) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"Button_radius8_LightGray_nor"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"Button_radius8_green_nor"] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:btn];
        [self.buttons addObject:btn];
        
        if (i == 0) {
            btn.selected = YES;
        }
    }
    
    [self setNeedsLayout];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    if (!_buttons.count) return;
    
    UIButton *btn = _buttons[selectedIndex];
    [self switchClick:btn];
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    [self setNeedsLayout];
}


- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}
@end
