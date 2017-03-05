//
//  HMOrderBottomBar.m
//  HealthMall
//
//  Created by healthmall005 on 16/1/23.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "HMOrderBottomBar.h"
#import "HMBaseFormSubmitButton.h"

@interface HMOrderBottomBar ()
@property (nonatomic, weak) HMBaseFormSubmitButton *submitButton;
@end

@implementation HMOrderBottomBar

+ (instancetype)bottomToolBarWithOrderStatus:(HMOrderStatus )status
{
    
    HMOrderBottomBar *orderBottomBar = [[self alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT - kFormfootViewHeight, kSCREEN_WIDTH, kFormfootViewHeight)];
    orderBottomBar.status = status;
    
    return orderBottomBar;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, kSCREEN_HEIGHT - kFormfootViewHeight, kSCREEN_WIDTH, kFormfootViewHeight);
}

- (void)btnPressed:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(orderBottomBarDidSelectedAtIndex:)]) {
        [self.delegate orderBottomBarDidSelectedAtIndex:btn.tag];
    }
}

- (void)setStatus:(HMOrderStatus)status
{
    _status = status;
    
    self.hidden = YES;
    
    CGFloat barW = kSCREEN_WIDTH;
    CGFloat barH = 49;
    
    NSMutableArray *titles = [NSMutableArray array];
    switch (status) {
        case HMOrderStatusNoPayment:
            //未支付
            titles = [NSMutableArray arrayWithObjects:@"支付", nil];
            break;
        case HMOrderStatusPaid:
            //待评价
            titles = [NSMutableArray arrayWithObjects:@"评价", @"退款", nil];
            break;
            
        default:
            break;
    }
    
    NSInteger count = titles.count;
    
    CGFloat btnW = 100;
    CGFloat btnH = 30;
    CGFloat lineW = 1;  // 分割线的宽度
    
    CGFloat margin = (((barW - lineW * count) / count) - btnW) * 0.5;
    CGFloat btnY = (barH - btnH) * 0.5;
    
    [_submitButton removeFromSuperview];
    
    if (status == HMOrderStatusPaid) {
        
        self.hidden = NO;
        
        // 添加前面按钮
        for (NSInteger i = 0; i < titles.count - 1; i++)
        {
            CGFloat btnX = margin + (btnW + margin + lineW) * i;
            HMBaseFormSubmitButton *btn = [HMBaseFormSubmitButton buttonWithType:UIButtonTypeSystem];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            btn.bgtype = HMBaseFormSubmitButtonTypeGreen;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.pr_acceptEventInterval = 1;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            btn.tag = i;
            [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            _submitButton = btn;
        }
        
        // 添加最后一个按钮
        CGFloat lastBtnX = barW - btnW - margin;
        UIButton *lastBtn = [[UIButton alloc] init];
        [lastBtn setTitle:titles.lastObject forState:UIControlStateNormal];
        [lastBtn setTitleColor:kColortRed forState:UIControlStateNormal];
        lastBtn.layer.borderColor = kColorBlackPercent20.CGColor;
        lastBtn.layer.borderWidth = 1;
        lastBtn.layer.cornerRadius = 5;
        lastBtn.pr_acceptEventInterval = 1;
        if (count > 1)
        {
            lastBtn.frame = CGRectMake(lastBtnX, btnY, btnW, btnH);
        }
        else
        {
            lastBtn.y = btnY;
        }
        
        lastBtn.tag = count - 1;
        [self addSubview:lastBtn];
        [lastBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (status == HMOrderStatusNoPayment){
        
        self.hidden = NO;
        
        HMBaseFormSubmitButton *payButton = [HMBaseFormSubmitButton buttonWithType:UIButtonTypeCustom];
        payButton.bgtype = HMBaseFormSubmitButtonTypeRed;
        [payButton setTitle:titles[0] forState:UIControlStateNormal];
        payButton.pr_acceptEventInterval = 1;//间隔1秒后才能再次提交支付
        payButton.y = btnY;
        payButton.tag = HMOrderStatusNoPayment;
        [self addSubview:payButton];
        _submitButton = payButton;
        [payButton addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }

}


@end
