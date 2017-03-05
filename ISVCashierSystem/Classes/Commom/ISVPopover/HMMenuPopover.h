//
//  HMMenuPopover.h
//  HealthMall
//
//  Created by qiuwei on 15/11/7.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HMMenuPopover;

@protocol HMMenuPopoverDelegate

/**
 *  点击Popover列表item的时候会调用
 */
- (void)menuPopover:(HMMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex;

@end

@interface HMMenuPopover : UIView

@property int menutype;
@property int isShowMenu;   // 是否正在显示

@property(nonatomic, weak) id<HMMenuPopoverDelegate> menuPopoverDelegate;

@property(nonatomic, retain) UIButton *containerButton;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems;
- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems andIconItems:(NSArray*)iconItems;

/**
 *  来回切换，显示/隐藏
 */
- (void)toggleShowHideInView:(UIView *)view;
- (void)showInView:(UIView *)view;
- (void)dismissMenuPopover;
- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
