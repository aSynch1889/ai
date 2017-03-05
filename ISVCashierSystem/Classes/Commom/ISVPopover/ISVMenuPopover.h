//
//  ISVMenuPopover.h
//  ISV
//
//  Created by aaaa on 15/11/7.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ISVMenuPopover;

@protocol ISVMenuPopoverDelegate

/**
 *  点击Popover列表item的时候会调用
 */
- (void)menuPopover:(ISVMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex;

@end

@interface ISVMenuPopover : UIView

@property int menutype;
@property int isShowMenu;   // 是否正在显示

@property(nonatomic, weak) id<ISVMenuPopoverDelegate> menuPopoverDelegate;

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
