//
//  HMScoreView.m
//  HealthMall
//
//  Created by jkl on 15/11/27.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMScoreView.h"
#import "HMCoverButton.h"

#define kHeight 20
#define kWidth (5*10 + 4*2)


@interface HMScoreView ()
@property (nonatomic, weak) HMCoverButton *coverBtn;
/// 五角星宽度(高度)
@property (nonatomic, assign) CGFloat starWidth;

/// 图标名称
@property (nonatomic, copy) NSString *iconName;

@end

@implementation HMScoreView

+ (instancetype)scoreViewWithPoint:(CGPoint)point score:(CGFloat)score
{
    HMScoreView *panelView = [[self alloc] initWithFrame:CGRectMake(point.x, point.y, kWidth, kHeight)];

    panelView.score = score;
    panelView.large = NO;
    return panelView;
}

+ (instancetype)scoreViewWithPoint:(CGPoint)point
{
    return [self scoreViewWithPoint:point score:0.0];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.point = frame.origin;
        frame = CGRectMake(_point.x, _point.y, kWidth, kHeight);
        self.opaque = NO;
    }
    
    return self;
}

- (void)setScore:(CGFloat)score
{
    _score = score;
    [self setNeedsDisplay];
}

- (void)setPointWithX:(CGFloat)x andY:(CGFloat)y
{
    self.point = CGPointMake(x, y);
}

- (void)setPoint:(CGPoint)point
{
    _point.x = point.x;
    _point.y = point.y - 5;
    self.frame = CGRectMake(_point.x, _point.y, kWidth, kHeight);
}

- (CGRect)frame
{
    if (self.large)
    {
        return CGRectMake(self.point.x, self.point.y, 5*22+4*5, 22);
    }
    else
    {
        return CGRectMake(self.point.x, self.point.y+5, kWidth, 10);
    }
}


- (void)setLarge:(BOOL)large
{
    _large = large;
    
    if (large)
    {
        // icon_OverallScore_full
        self.starWidth = 22.0;
        self.iconName = @"OverallScore";
        self.size = CGSizeMake(5*22+4*5, 22);
    }
    else
    {
        // icon_score_full
        self.starWidth = 10.0;
        self.iconName = @"score";
    }
}

- (void)drawRect:(CGRect)rect
{
    CGFloat width = self.starWidth;  // 五角星图片宽度
    CGFloat height = width;   // 五角星图片高度
    CGFloat margin = 2;       // 间距
    
    NSInteger half = 0;       // 全绿个数
    NSInteger full = 0;       // 半绿个数
    
    // 整数部分
    NSInteger integer = (int) self.score;
    // 小数部分
    CGFloat decimal = self.score - integer;
    
    if ((decimal >= 0.1-0.000001)  && (decimal < 0.5))
    {
        half = 1;
        full = integer;
    }
    else if (decimal >= 0.5)
    {
        full = integer + 1;
    } else
    {
        full = integer;
    }
    
    full = MIN(5, full);
    
    // 单颗星星有3种状态: 全白、全绿、半绿; 其中全白表示0分，全绿表示0.5-1分，半绿表示0.1-0.4;
    
    CGFloat imgY = self.large ? 0 : (kHeight - height) * 0.5;
    
    // 1.添加全绿
    for (NSInteger i = 0; i < full; i++)
    {
        CGRect imgRect = CGRectMake(i * (width+margin), imgY, width, height);
        // icon_OverallScore_full
        UIImage *img = [UIImage imageNamed:
                        [NSString stringWithFormat:@"icon_%@_full", self.iconName]];
        [img drawInRect:imgRect];
    }
    
    // 2.添加半绿
    if (half == 1)
    {
        CGRect imgRect = CGRectMake(full * (width+margin), imgY, width, height);
        // icon_OverallScore_half
        UIImage *img = [UIImage imageNamed:
                        [NSString stringWithFormat:@"icon_%@_half", self.iconName]];
        [img drawInRect:imgRect];
    }
    
    // 3.添加全白
    for (NSInteger i = full+half; i < 5; i++)
    {
        CGRect imgRect = CGRectMake(i * (width+margin), imgY, width, height);
        // icon_OverallScore_null
        UIImage *img = [UIImage imageNamed:
                        [NSString stringWithFormat:@"icon_%@_null", self.iconName]];
        [img drawInRect:imgRect];
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self.superview bringSubviewToFront:self];
}

#pragma mark - 添加点击五角星事件
- (void)addTarget:(id)target actionForTouchUpInside:(SEL)action
{
    if (self.coverBtn == nil)
    {
        // 添加按钮
        HMCoverButton *btn = [HMCoverButton coverButtonWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        btn.highlightedColor = HMRGBACOLOR(0, 0, 0, 0);
        [self addSubview:btn];
        self.coverBtn = btn;
    }
    
    [self.coverBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
