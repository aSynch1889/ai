//
//  ISVSegmentedView.m
//  ISV
//
//  Created by aaaa on 15/11/27.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVSegmentedView.h"
#import "ISVHorizontalButton.h"

#define kHMSegmentedViewDefaultMarginSizeW 3.0
#define kHMSegmentedViewDefaultMarginSizeH 30.0

@interface ISVSegmentedView ()
{
    UIButton *_currentButton;
}
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation ISVSegmentedView

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
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp
{
    self.backgroundColor = ISVBackgroundColor;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    // 按钮间距
    _marginSize = CGSizeMake(kHMSegmentedViewDefaultMarginSizeW, kHMSegmentedViewDefaultMarginSizeH);
    _marginColor = kColorBlackPercent10;
}

- (instancetype)initWithItems:(NSArray *)items
{
    if (self = [super init]) {
        for (int i = 0;i < items.count; i++) {
            id item = items[i];
            ISVHorizontalButton *button = [ISVHorizontalButton buttonWithType:UIButtonTypeCustom];

            button.titleLabel.font = ISVFontSize(12.0);
            [button setTitleColor:kColorBlackPercent20 forState:UIControlStateNormal];
            [button setTitleColor:ISVMainColor forState:UIControlStateSelected];
            if ([item isKindOfClass:[NSString class]]) {
                [button setTitle:item forState:UIControlStateNormal];
                
                [button setImage:[UIImage imageNamed:@"icon_button_Triangle_NotSel"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"icon_button_Triangle_Sel"] forState:UIControlStateSelected];
            }else{
                [button setImage:item forState:UIControlStateNormal];
            }
            button.tag = i;
            [button sizeToFit];
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.buttons addObject:button];
            [self.contentView addSubview:button];
            
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = CGRectMake(_edgeInsets.left, _edgeInsets.top, self.frame.size.width - _edgeInsets.left - _edgeInsets.right, self.frame.size.height - _edgeInsets.top - _edgeInsets.bottom);
    
    NSInteger count = self.buttons.count;
    CGFloat W = self.contentView.frame.size.width;
    CGFloat H = self.contentView.frame.size.height;
    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = floorf((W - ((count - 1) * _marginSize.width)) / count) + 1;// 加一像素误差
    
    for (int i = 0; i < count; i++ ) {
        UIView *button = self.buttons[i];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, H);
        buttonX += buttonW + _marginSize.width;
        
        if(i < count - 1){
            // 创建
            UIView *headView = [[UIView alloc] init];
            headView.frame = CGRectMake(buttonX, (H - _marginSize.height) * 0.5, _marginSize.width, _marginSize.height);
            headView.backgroundColor = _marginColor;
            [self.contentView addSubview:headView];
        }
    }
}

- (void)buttonClick:(UIButton *)button
{
    BOOL isShouldSelected = YES;
    if ([self.delegate respondsToSelector:@selector(segmentedView:shouldSelectedIndex:)]) {
        isShouldSelected = [self.delegate segmentedView:self shouldSelectedIndex:button.tag];
    }
    if (!isShouldSelected) return;
    
    if ([self.delegate respondsToSelector:@selector(segmentedView:willSelectedIndex:)]) {
        [self.delegate segmentedView:self willSelectedIndex:button.tag];
    }
    
    [self setSelectedIndex:button.tag];
    
    if ([self.delegate respondsToSelector:@selector(segmentedView:didSelectedIndex:)]) {
        [self.delegate segmentedView:self didSelectedIndex:button.tag];
    }
}

#pragma mark - setter/getter 
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    UIButton *button = self.buttons[selectedIndex];
    if (button == _currentButton) return;
    
    button.selected = YES;
    _currentButton.selected = NO;
    _currentButton = button;
}
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    [self setNeedsLayout];
}
- (NSUInteger)numberOfSegmenteds
{
    return self.buttons.count;
}

- (void)setFontSize:(UIFont *)fontSize
{
    for (UIButton *button in self.buttons) {
        button.titleLabel.font = fontSize;
    }
}
- (void)setFontColor:(UIColor *)fontColor selectedFontColor:(UIColor *)selectedFontColor
{
    for (UIButton *button in self.buttons) {
        [button setTitleColor:fontColor forState:UIControlStateNormal];
        [button setTitleColor:selectedFontColor forState:UIControlStateSelected];
    }
}

- (void)setImage:(UIImage *)image forState:(UIControlState)forState
{
    for (UIButton *button in self.buttons) {
        [button setImage:image forState:forState];
    }
}

- (void)setBackgroupImage:(UIImage *)backgroupImage forState:(UIControlState)forState
{
    for (UIButton *button in self.buttons) {
        [button setBackgroundImage:backgroupImage forState:forState];
    }
}

- (void)setDelegate:(id<ISVSegmentedViewDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认选中第0个按钮
    UIButton *btn = [self.buttons objectAtIndex:0];
    [self buttonClick:btn];
}
#pragma mark - 懒加载
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (UIView *)contentView
{
    if (_contentView == nil) {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        _contentView = view;
    }
    return _contentView;
}
@end
