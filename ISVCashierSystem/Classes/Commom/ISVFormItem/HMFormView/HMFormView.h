//
//  HMFormView.h
//  HealthMall
//
//  Created by qiuwei on 15/11/18.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMTextField.h"
#import "HMPlaceholderTextView.h"

@class HMFormView, HMBaseFormItemModel, HMTextField, HMPlaceholderTextView;

// 数据源
@protocol HMFormViewDataSource <NSObject>

 @optional
// 每一行的高度
- (CGFloat)formView:(HMFormView *)formView heightForRowAtIndex:(NSInteger)index;
- (UIEdgeInsets)formView:(HMFormView *)formView edgeInsetsForRowAtIndex:(NSInteger)index;

@end


// 代理
@protocol HMFormViewDelegate <NSObject>


 @optional
// HMTextField
- (BOOL)textFieldShouldBeginEditing:(HMTextField *)textField;
- (BOOL)textFieldShouldEndEditing:(HMTextField *)textField;
- (void)textFieldDidBeginEditing:(HMTextField *)textField;
- (void)textFieldDidEndEditing:(HMTextField *)textField;

- (BOOL)textField:(HMTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

// HMPlaceholderTextView
- (BOOL)textViewShouldBeginEditing:(HMPlaceholderTextView *)textView;
- (BOOL)textViewShouldEndEditing:(HMPlaceholderTextView *)textView;
- (void)textViewDidBeginEditing:(HMPlaceholderTextView *)textView;
- (void)textViewDidEndEditing:(HMPlaceholderTextView *)textView;

- (BOOL)textView:(HMPlaceholderTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;


// 开始拖动时（在内部已经自动调用了[self endEditing:YES]）
- (void)formViewWillBeginDragging:(HMFormView *)formView;
@end

// 表单控件
@interface HMFormView : UIView
@property (nonatomic, strong) NSArray<HMBaseFormItemModel *> *formItems;
@property (nonatomic, weak) id<HMFormViewDataSource> dataSource;
@property (nonatomic, weak) id<HMFormViewDelegate> delegate;

//@property (nonatomic, strong, readonly) UIView *activeField;

@property (nonatomic, assign) CGFloat titleWidth;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGFloat headViewHeight;
@property (nonatomic, assign) CGFloat footViewHeight;
@property (nonatomic, assign, readonly) CGFloat lastItemMaxHeight;  // 最后Item的最大Y值

/**
 *  添加一个控件到第一个元素的上面
 */
- (void)addSubviewOnHeadView:(UIView *)subView;
/**
 *  添加一个控件到最后元素的下面
 */
- (void)addSubviewOnFootView:(UIView *)subView;
/**
 *  获取某一项表单组件
 */
- (UIView *)itemViewForFormViewAtIndex:(NSUInteger)index;
/**
 *  获取某个文本框
 */
- (UIView *)fieldForFormViewAtIndex:(NSUInteger)index;
/**
 *  获取某一项的frame
 */
- (CGRect)itemFrameForFormViewAtIndex:(NSUInteger)index;

- (void)reloadData;

@end
