//
//  HMHUD.m
//  HealthMall
//
//  Created by qiuwei on 15/12/5.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMHUD.h"
#import <SVProgressHUD.h>
#import "HMJumpProgressHUD.h"

static CGFloat HUDDefaultMargin = 10.0;
static UILabel *HUDStateLabel_;
static UIView *HUDCoverView_;

@interface HMHUD ()
@property (nonatomic, weak) HMJumpProgressHUD *jumpHud;
@end

@implementation HMHUD

+ (void)load
{
    [super load];
    
    [self reset];
}

// 重置HUD
+ (void)reset
{
    // 初始化HUD
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [SVProgressHUD setBackgroundColor:ISVRGBACOLOR(0, 0, 0, 0.7)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setInfoImage:nil];
}

+ (void)showPageWithPageType:(HMHUDPageType)pageType InView:(UIView *)supperView;
{
    if (!self.coverView.hidden && self.coverView.superview == supperView) {
        return;
    }
    [SVProgressHUD dismiss];
    
    self.coverView.hidden = NO;
    [self.coverView removeAllSubviews];
    self.coverView.frame = supperView.bounds;
    [supperView addSubview:self.coverView];
    
    if (pageType == HMHUDPageTypeNoConnect) {// 网络不佳
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD_NonConnect"]];
        self.stateLabel.text = @"网络不佳";
        [self.stateLabel sizeToFit];
        UIButton *reLoadDataBtn = [self createReLoadDataBtn];
        
        imageView.center = CGPointMake(self.coverView.center.x, self.coverView.center.y - self.stateLabel.height - reLoadDataBtn.height);
        self.stateLabel.center = CGPointMake(imageView.center.x, CGRectGetMaxY(imageView.frame) + self.stateLabel.height * 0.5 + HUDDefaultMargin);
        reLoadDataBtn.center = CGPointMake(imageView.center.x, CGRectGetMaxY(self.stateLabel.frame) + reLoadDataBtn.height * 0.5 + HUDDefaultMargin);
        
        [self.coverView addSubview:imageView];
        [self.coverView addSubview:self.stateLabel];
        [self.coverView addSubview:reLoadDataBtn];
        
    }else if (pageType == HMHUDPageTypeNoData){// 没数据
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD_NoData"]];
        self.stateLabel.text = @"暂无数据";
        [self.stateLabel sizeToFit];
        
        imageView.center = CGPointMake(self.coverView.center.x, self.coverView.center.y - self.stateLabel.height);
        self.stateLabel.center = CGPointMake(imageView.center.x, CGRectGetMaxY(imageView.frame) + self.stateLabel.height * 0.5 + HUDDefaultMargin);
        
        [self.coverView addSubview:imageView];
        [self.coverView addSubview:self.stateLabel];

    }else if (pageType == HMHUDPageTypeLoading){// 加载中
        UIView *covrer = self.coverView;
        HMJumpProgressHUD *hud = [[HMJumpProgressHUD alloc] initWithFrame:
                                  CGRectMake((covrer.width-112)*0.5, covrer.height*0.5-140, 112, 140)];
        hud.tag = HMHUDPageTypeLoading;
        [covrer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [covrer addSubview:hud];
        [hud beginJump];
    }
    
}

+ (void)show
{
    [self dismissPage];
    [SVProgressHUD show];
}

+ (void)showWithMaskType:(HMHUDMaskType)maskType
{
    [self dismissPage];
    [SVProgressHUD showWithMaskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showWithStatus:(NSString*)status
{
    [self dismissPage];
    [SVProgressHUD showWithStatus:status];
}
+ (void)showWithStatus:(NSString*)status maskType:(HMHUDMaskType)maskType
{
    [self dismissPage];
    [SVProgressHUD showWithStatus:status maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showProgress:(float)progress
{
    [self dismissPage];
    [SVProgressHUD showProgress:progress];
}
+ (void)showProgress:(float)progress maskType:(HMHUDMaskType)maskType
{
    [self dismissPage];
    [SVProgressHUD showProgress:progress maskType:(SVProgressHUDMaskType)maskType];
}
+ (void)showProgress:(float)progress status:(NSString*)status
{
    [self dismissPage];
    [SVProgressHUD showProgress:progress status:status];
}
+ (void)showProgress:(float)progress status:(NSString*)status maskType:(HMHUDMaskType)maskType
{
    [self dismissPage];
    [SVProgressHUD showProgress:progress status:status maskType:(SVProgressHUDMaskType)maskType];
}

// 在showing的时候，改变 HUD 的加载状态
+ (void)setStatus:(NSString*)string
{
    [SVProgressHUD setStatus:string];
}

// 停止所有的指示器, 显示带信息的指示器, 并自动消失
+ (void)showInfoWithStatus:(NSString *)string
{
    [self dismissPage];
    [SVProgressHUD showInfoWithStatus:string];
}
+ (void)showInfoWithStatus:(NSString *)string maskType:(HMHUDMaskType)maskType
{
    [self dismissPage];
    [SVProgressHUD showInfoWithStatus:string maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showSuccessWithStatus:(NSString*)string
{
    [self dismissPage];
    [SVProgressHUD showSuccessWithStatus:string];
}
+ (void)showSuccessWithStatus:(NSString*)string maskType:(HMHUDMaskType)maskType
{
    [self dismissPage];
    [SVProgressHUD showSuccessWithStatus:string maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)showErrorWithStatus:(NSString *)string
{
    [self dismissPage];

    [SVProgressHUD showErrorWithStatus:string];
}
+ (void)showErrorWithStatus:(NSString *)string maskType:(HMHUDMaskType)maskType
{
    [self dismissPage];
    [SVProgressHUD showErrorWithStatus:string maskType:(SVProgressHUDMaskType)maskType];
}

// use 28x28 white pngs
+ (void)showImage:(UIImage*)image status:(NSString*)status
{
    [self dismissPage];
    [SVProgressHUD showImage:image status:status];
}
+ (void)showImage:(UIImage*)image status:(NSString*)status maskType:(HMHUDMaskType)maskType;
{
    [self dismissPage];
    [SVProgressHUD showImage:image status:status maskType:(SVProgressHUDMaskType)maskType];
}

+ (void)setOffsetFromCenter:(UIOffset)offset;
{
    [SVProgressHUD setOffsetFromCenter:offset];
}

+ (void)resetOffsetFromCenter
{
    [SVProgressHUD resetOffsetFromCenter];
}

+ (void)setBackgroundColor:(UIColor*)color
{
    [SVProgressHUD setBackgroundColor:color];
}

// 减少指示器数量，如果==0，就隐藏指示器
+ (void)popActivity
{
    [SVProgressHUD popActivity];
}
+ (void)dismiss
{
    [SVProgressHUD dismiss];
    [self dismissPage];
}

+ (void)dismissPage
{
    __weak typeof (self.coverView) weakCoverView = self.coverView;
    HMJumpProgressHUD *hud = [self.coverView.subviews lastObject];
    if ([hud isKindOfClass:[HMJumpProgressHUD class]])
    {
        [hud stopWithBlock:^{
            [weakCoverView removeFromSuperview];
            weakCoverView.hidden = YES;
            [weakCoverView removeAllSubviews];
        }];
    }else{
        [weakCoverView removeFromSuperview];
        weakCoverView.hidden = YES;
        [weakCoverView removeAllSubviews];
    }
}
// 是否正在显示
+ (BOOL)isVisible
{
    return [SVProgressHUD isVisible];
}

#pragma mark - Event
+ (void)reLoadDataBtnClick:(UIButton *)btn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:HMHUDReLoadDataNotification object:nil];
}
#pragma mark - setter/getter
+ (UIView *)coverView
{
    if (HUDCoverView_ == nil) {
        HUDCoverView_ = [[UIView alloc] init];
        HUDCoverView_.backgroundColor = ISVBackgroundColor;
        HUDCoverView_.userInteractionEnabled = YES;
    }
    return HUDCoverView_;
}
+ (UILabel *)stateLabel
{
    if (HUDStateLabel_ == nil) {
        HUDStateLabel_ = [[UILabel alloc] init];
        HUDStateLabel_.font = ISVFontSize(16.0);
        HUDStateLabel_.textColor = ISVRGB(150, 150, 150);
    }
    return HUDStateLabel_;
}

+ (UIButton *)createReLoadDataBtn
{
    UIButton *reLoadDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reLoadDataBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    reLoadDataBtn.titleLabel.font = ISVFontSize(15.0);
    reLoadDataBtn.size = CGSizeMake(80, 30);
    [reLoadDataBtn setBackgroundImage:[UIImage imageNamed:@"Button_radius5_green_nor"] forState:UIControlStateNormal];
    [reLoadDataBtn setBackgroundImage:[UIImage imageNamed:@"Button_radius5_green_hig"] forState:UIControlStateHighlighted];
    [reLoadDataBtn addTarget:self action:@selector(reLoadDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    reLoadDataBtn.pr_acceptEventInterval = 1.0;
    
    return reLoadDataBtn;
}
@end
