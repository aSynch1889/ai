//
//  HMBaseFormItemModel.h
//  HealthMall
//
//  Created by qiuwei on 15/11/15.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMSwitch;

// 表单类型:目前只支持textField/textView/SwitchView/Label（简单文字）四种类型
typedef enum : NSUInteger {
    HMBaseFormItemTypeField = 0,
    HMBaseFormItemTypeText  = 1,
    HMBaseFormItemTypeSwitch= 2,
    HMBaseFormItemTypeLabel = 3,
} HMBaseFormItemType;

@interface HMBaseFormItemModel : NSObject

@property (nonatomic, assign) HMBaseFormItemType formItemType; // 表单类型
@property (nonatomic, copy) NSString *title;    // 标题
@property (nonatomic, copy) NSString *placeholder;  // 占位符
@property (nonatomic, copy) NSString *text;         // 填写的文本

@property (nonatomic, copy) NSString *name;     // 辅助属性

@property (nonatomic, assign) BOOL isImportant; // 是否重要的 默认NO YES的话会使标题为红色
@property (nonatomic, assign) BOOL isNecessary; // 是否必填 默认NO
@property (nonatomic, assign) BOOL readonly;    // 是否只读 默认NO
@property (nonatomic, assign, getter=isJumpIndicator) BOOL JumpIndicator; // 是否显示跳转指示器 默认NO
@property (nonatomic, copy) void(^actionBlock)(); // 点击时要执行的block（不会成为第一响应者）

/* HMSwitch */
@property (nonatomic, strong) NSArray<HMSwitch *> *switchs;  // 选项数组(formItemType == HMBaseFormItemTypeSwitch)
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) CGFloat height;

/**
 *  返回表单视图数组（带默认frame）
 *  @param formItems 表单字典数组
 *  @return 表单视图数组
 */
+ (NSArray<UIView *> *)formItemViewsWithFormItemDicts:(NSArray<NSDictionary *> *)formItemDicts;

@end
