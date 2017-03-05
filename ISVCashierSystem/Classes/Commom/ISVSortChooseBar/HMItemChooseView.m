//
//  HMItemChooseView.m
//  HealthMall
//
//  Created by jkl on 15/12/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMItemChooseView.h"
#import "HMEasyHitBtn.h"

@interface HMItemChooseView ()
/// 当前选中的按钮
@property (nonatomic, weak) HMEasyHitBtn *selectedBtn;
@end

@implementation HMItemChooseView

+ (instancetype)itemChooseViewWithY:(CGFloat)y title:(NSString *)title items:(NSArray *)items
{
    CGFloat chooseViewH = 10+15+5 + (((items.count-1)/4) + 1)*30 +5;
    if (items.count == 0)
    {
        chooseViewH = 40;
    }
    HMItemChooseView *chooseView = [[self alloc] initWithFrame:CGRectMake(0, y, kSCREEN_WIDTH, chooseViewH)];
    chooseView.backgroundColor = [UIColor whiteColor];
    chooseView.title = title;
    chooseView.items = items;
    
    CGFloat leading = 10;  // 距离屏幕边距
    CGFloat lineH = 1;
    CGFloat lineW = kSCREEN_WIDTH - 2 * leading;
    
    // 1. titleLabel
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leading, 7, 100, 21)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = HMRGB(100, 100, 100);
    if (items.count == 0)
    {
        titleLabel.frame = CGRectMake(leading, (chooseViewH-21)*0.5, 100, 21);
    }
    [chooseView addSubview:titleLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(leading, chooseViewH-lineH, lineW, lineH)];
    line.backgroundColor = HMRGB(242, 242, 242);
    line.userInteractionEnabled = NO;
    [chooseView addSubview:line];
    
    CGFloat btnW = 60;
    CGFloat btnH = 30;
    CGFloat margin = (kSCREEN_WIDTH - leading*2 - btnW*4) / 3.0;
    
    for (NSInteger i = 0; i < items.count; i++)
    {
        HMEasyHitBtn *btn = [HMEasyHitBtn easyHitBtn];
        btn.frame = CGRectMake(leading + (btnW+margin)*(i%4), CGRectGetMaxY(titleLabel.frame) + 30*(i/4), btnW, btnH);
        [btn setTitle:items[i] forState:UIControlStateNormal];
        [btn addTarget:chooseView action:@selector(itemBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [chooseView addSubview:btn];
    }
 
    return chooseView;
}

- (void)itemBtnPressed:(HMEasyHitBtn *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    [self.delegate didChooseItemWithTitle:self.title item:btn.currentTitle];
}

- (void)reset
{
    [self.selectedBtn setSelected:NO];
}

@end
