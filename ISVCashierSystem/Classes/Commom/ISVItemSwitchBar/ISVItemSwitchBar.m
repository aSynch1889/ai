//
//  ISVItemSwitchBar.m
//  ISV
//
//  Created by aaaa on 15/12/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVItemSwitchBar.h"

#define btnWidth 64
#define margin 5

@interface ISVItemSwitchBar ()
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation ISVItemSwitchBar

+ (instancetype)itemSwitchBarWithTitles:(NSArray *)titles
{
    ISVItemSwitchBar *bar = [[self alloc] initWithFrame:CGRectMake(0, 0, btnWidth*2 +margin, 40)];
    
    NSInteger i = 0;
    for (NSString *title in titles)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(i * (btnWidth + margin) , 0, btnWidth, 40);
        
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:ISVRGBACOLOR(255, 255, 255, 0.6) forState:UIControlStateNormal];
        [btn setTitleColor:ISVRGBACOLOR(255, 255, 255, 1.0) forState:UIControlStateSelected];
        btn.tintColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.tag = i;
        [btn addTarget:bar action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
        [bar addSubview:btn];
        
        if (i == 0)
        {
            bar.selectedBtn = btn;
        }
        
        i++;
    }
    
    
    // 下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(2, 38, btnWidth-4, 2.5)];
    lineView.backgroundColor = [UIColor whiteColor];
    [bar addSubview:lineView];
    bar.lineView = lineView;

    return bar;
}


- (void)itemSelected:(UIButton *)btn
{
    CGPoint point = self.lineView.center;
    point.x = btn.center.x;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.lineView.center = point;
    }];
    
    self.selectedBtn = btn;
    
    // 通知代理
    [self.delegate itemSwitchBar:self didSelectedAtIndex:btn.tag];
}

- (void)setSelectedBtn:(UIButton *)selectedBtn
{
    _selectedBtn.selected = NO;
    selectedBtn.selected = YES;
    _selectedBtn = selectedBtn;
}

- (void)setItemSelectedAtIndex:(NSInteger)index
{
    
}

@end
