//
//  ISVImageViewContainerView.h
//  ISV
//
//  Created by aaaa on 15/11/24.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ISVImageViewContainerViewTypeNormal = 0, // 普通
    ISVImageViewContainerViewTypeDelete = 1, // 删除
    ISVImageViewContainerViewTypeChecked = 2,// 选中
} ISVImageViewContainerViewType;


@class ISVImageViewContainerView;

@protocol ISVImageViewContainerViewDelegate <NSObject>

@optional
// 点击控件
- (void)clickImageViewContainerView:(ISVImageViewContainerView *)imageViewContainerView;

// 长按控件
- (void)longPressImageViewContainerView:(ISVImageViewContainerView *)imageViewContainerView;

// 点击删除按钮
- (void)deleteImageViewContainerView:(ISVImageViewContainerView *)imageViewContainerView;

@end

@interface ISVImageViewContainerView : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) ISVImageViewContainerViewType type;
@property (nonatomic, assign) CGFloat coverAlpha; // 透明度 0.01 - 1.0
@property (nonatomic, weak) id<ISVImageViewContainerViewDelegate> delegate;

+ (instancetype)containerView;
@end
