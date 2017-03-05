//
//  HMSwitchView.h
//  HealthMall
//
//  Created by qiuwei on 15/11/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMSwitchView, HMSwitch;

@protocol HMSwitchViewDelegate <NSObject>

@required
/* 点击按钮 */
- (void)switchClick:(HMSwitchView *)switchView index:(NSUInteger)index;

@optional
/* 是否允许点击按钮 */
- (BOOL)switchShouldClick:(HMSwitchView *)switchView index:(NSUInteger)index;

@end

@interface HMSwitchView : UIView

@property (nonatomic, strong) NSArray<HMSwitch *> *switchs;
@property (nonatomic, assign) NSUInteger selectedIndex; // 默认选中第0个
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGFloat buttonwidth;  // 每个按钮的宽度
@property (nonatomic, assign) CGFloat buttonMargin;

@property (nonatomic, weak) id<HMSwitchViewDelegate> delegate;  // 监听点击

@end
