//
//  HMImageViewContainerView.h
//  HealthMall
//
//  Created by qiuwei on 15/11/24.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HMImageViewContainerViewTypeNormal = 0, // 普通
    HMImageViewContainerViewTypeDelete = 1, // 删除
    HMImageViewContainerViewTypeChecked = 2,// 选中
} HMImageViewContainerViewType;


@class HMImageViewContainerView;

@protocol HMImageViewContainerViewDelegate <NSObject>

@optional
// 点击控件
- (void)clickImageViewContainerView:(HMImageViewContainerView *)imageViewContainerView;

// 长按控件
- (void)longPressImageViewContainerView:(HMImageViewContainerView *)imageViewContainerView;

// 点击删除按钮
- (void)deleteImageViewContainerView:(HMImageViewContainerView *)imageViewContainerView;

@end

@interface HMImageViewContainerView : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) HMImageViewContainerViewType type;
@property (nonatomic, assign) CGFloat coverAlpha; // 透明度 0.01 - 1.0
@property (nonatomic, weak) id<HMImageViewContainerViewDelegate> delegate;

+ (instancetype)containerView;
@end
