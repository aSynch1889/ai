//
//  ISVImageViewContainerListView.h
//  ISV
//
//  Created by aaaa on 15/11/26.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

// 容器模式
typedef enum : NSUInteger {
    ISVContainerListViewModeNormal = 0,  // 普通模式
    ISVContainerListViewModeDelete = 1,  // 删除模式
    ISVContainerListViewModeCheck = 2,   // 检查模式
} ISVContainerListViewMode;

// 容器改变动作
typedef enum : NSUInteger {
    ISVContainerListViewChangeActionDelete = 0, // 删除
    ISVContainerListViewChangeActionAdd    = 1, // 添加
} ISVContainerListViewChangeAction;

@class ISVImageViewContainerListView;

@protocol ISVImageViewContainerListViewDelegate <NSObject>

@optional
/**
 *  点击加号按钮
 */
- (void)didClickAddButtonWithContainerListView:(nonnull ISVImageViewContainerListView *)containerListView;

/**
 *  如果不实现didClickAddButtonWithContainerListView: 默认会弹出imagePickerController，选择图片或视频或拍照完后调用此方法
 *  @param containerListView containerListView
 *  @param info              PickingMedia's Info <UIImagePickerControllerDelegate>
 */
- (void)containerListView:(nonnull ISVImageViewContainerListView *)containerListView didFinishPickingImages:(nonnull NSArray<UIImage *> *)images;

/**
 *  容器内部图片数量发生改变后
 *
 *  @param containerListView 容器
 *  @param image             被改变的图片
 *  @param action            改变动作 删除or添加
 */
- (void)didChangeWithContainerListView:(nonnull ISVImageViewContainerListView *)containerListView images:(nonnull NSArray<UIImage *> *)images action:(ISVContainerListViewChangeAction)action;

/**
 *  是否允许弹出默认预览器（普通模式下 ISVContainerListViewModeNormal）
 *  @param containerListView 容器
 *  @return 默认YES
 */
- (BOOL)shouldShowPreviewWithContainerListView:(nonnull ISVImageViewContainerListView *)containerListView image:(nonnull UIImage *)image index:(NSUInteger)index;

/**
 *  长按某个图片
 */
//- (void)didLongPressImageViewWithContainerListView:(ISVImageViewContainerListView *)containerListView index:(NSUInteger)index;

@end


// 图片容器类
@interface ISVImageViewContainerListView : UIView

@property (nonatomic, strong, readonly) NSArray<UIImage *> * _Nullable images;
@property (nonatomic, strong, readonly) NSArray<UIImage *> * _Nullable checkedImages;
@property (nonatomic, weak) id<ISVImageViewContainerListViewDelegate> delegate;

@property (nonatomic, assign) ISVContainerListViewMode mode; // 容器模式

@property (nonatomic, assign) CGFloat imageListMaxCount;    // 最大能装多少个
@property (nonatomic, assign) CGFloat imageListMaxColumn;   // 一行最多显示多少列
@property (nonatomic, assign) CGFloat imageListRowMargin;   // 行间距
@property (nonatomic, assign) CGFloat imageListColumnMargin; // 列间距

@property (nonatomic, assign) CGFloat coversAlpha;  // 单个图片遮盖层的透明度 0.01 - 1.0

@property (nonatomic, assign, readonly) CGSize imageSize;   // 获取每张图片的大小

- (void)addImage:(nonnull UIImage *)image;
- (void)addImages:(nonnull NSArray<UIImage *> *)images;
- (void)insetImage:(nonnull UIImage *)image atIndex:(NSUInteger)index;
- (void)insetImages:(nonnull NSArray<UIImage *> *)images atIndex:(NSUInteger)index;

- (void)deleteImageFromIndex:(NSUInteger)index;

// 删除选中的所有图片
- (void)deleteCheckedImages;

@end
