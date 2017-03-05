//
//  HMSegmentedView.h
//  HealthMall
//
//  Created by qiuwei on 15/11/27.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMSegmentedView;


@protocol HMSegmentedViewDelegate <NSObject>

@optional

- (void)segmentedView:(HMSegmentedView *)segmentedView willSelectedIndex:(NSUInteger)index;
- (void)segmentedView:(HMSegmentedView *)segmentedView didSelectedIndex:(NSUInteger)index;

- (BOOL)segmentedView:(HMSegmentedView *)segmentedView shouldSelectedIndex:(NSUInteger)index;
@end


// 切换条
@interface HMSegmentedView : UIView

@property (nonatomic, readonly) NSUInteger numberOfSegmenteds;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, weak) id <HMSegmentedViewDelegate> delegate;

@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@property (nonatomic, assign) CGSize marginSize;
@property (nonatomic, strong) UIColor *marginColor;

- (instancetype)initWithItems:(NSArray *)items; // items can be NSStrings or UIImages. control is automatically sized to fit content

- (void)setFontSize:(UIFont *)fontSize;
- (void)setFontColor:(UIColor *)fontColor selectedFontColor:(UIColor *)selectedFontColor;
- (void)setImage:(UIImage *)image forState:(UIControlState)forState;
- (void)setBackgroupImage:(UIImage *)backgroupImage forState:(UIControlState)forState;

@end
