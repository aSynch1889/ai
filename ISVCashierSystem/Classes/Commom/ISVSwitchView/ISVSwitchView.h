//
//  ISVSwitchView.h
//  ISV
//
//  Created by aaaa on 15/11/16.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISVSwitchView, ISVSwitch;

@protocol ISVSwitchViewDelegate <NSObject>

@required
/* 点击按钮 */
- (void)switchClick:(ISVSwitchView *)switchView index:(NSUInteger)index;

@optional
/* 是否允许点击按钮 */
- (BOOL)switchShouldClick:(ISVSwitchView *)switchView index:(NSUInteger)index;

@end

@interface ISVSwitchView : UIView

@property (nonatomic, strong) NSArray<ISVSwitch *> *switchs;
@property (nonatomic, assign) NSUInteger selectedIndex; // 默认选中第0个
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGFloat buttonwidth;  // 每个按钮的宽度
@property (nonatomic, assign) CGFloat buttonMargin;

@property (nonatomic, weak) id<ISVSwitchViewDelegate> delegate;  // 监听点击

@end
