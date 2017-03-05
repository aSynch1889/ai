//
//  HMBottomToolBar.m
//  HealthMall
//
//  Created by jkl on 15/12/11.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMBottomToolBar.h"
#import "HMBaseFormSubmitButton.h"

@implementation HMBottomToolBar

+ (instancetype)bottomToolBarWithTitles:(NSArray *)titles
{
    CGFloat barW = kSCREEN_WIDTH;
    CGFloat barH = 49;

    HMBottomToolBar *bar = [[self alloc] initWithFrame:
                            CGRectMake(0, kSCREEN_HEIGHT-barH, barW, barH)];
    bar.backgroundColor = [UIColor whiteColor];
    
    NSInteger count = titles.count;
    
    CGFloat btnW = 100;
    CGFloat btnH = 30;
    CGFloat lineW = 1;  // 分割线的宽度
    
    CGFloat margin = (((barW - lineW * count) / count) - btnW) * 0.5;
    CGFloat btnY = (barH - btnH) * 0.5;
    
    // 添加前面按钮
    for (NSInteger i = 0; i < titles.count - 1; i++)
    {
        CGFloat btnX = margin + (btnW + margin + lineW) * i;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:ISVMainColor forState:UIControlStateNormal];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = i;
        [bar addSubview:btn];
        [btn addTarget:bar action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        // 分割线
        CGFloat lineH = 29;
        CGFloat lineX = btnX + btnW + margin;
        CGFloat lineY = (barH - lineH) *0.5;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        lineView.backgroundColor = ISVRGB(240, 240, 240);
        [bar addSubview:lineView];
    }
    
    // 添加最后一个按钮
    CGFloat lastBtnX = barW - btnW - margin;
    UIButton *lastBtn = [[HMBaseFormSubmitButton alloc] init];
    [lastBtn setTitle:titles.lastObject forState:UIControlStateNormal];
    lastBtn.layer.cornerRadius = 5;
    lastBtn.layer.masksToBounds = YES;
    if (count > 1)
    {
        lastBtn.frame = CGRectMake(lastBtnX, btnY, btnW, btnH);
    }
    else
    {
        lastBtn.frame = CGRectMake(30, 10, kSCREEN_WIDTH-60, 30);
    }
    
    lastBtn.tag = count - 1;
    [bar addSubview:lastBtn];
    [lastBtn addTarget:bar action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return bar;
}

- (void)btnPressed:(UIButton *)btn
{
    [self.delegate bottomToolBarDidSelectedAtIndex:btn.tag];
}

- (UIButton *)buttonAtIndex:(NSInteger)index
{
    if (index < self.subviews.count)
    {
        return self.subviews[index];
    }
    else
    {
        return nil;
    }
}

@end
