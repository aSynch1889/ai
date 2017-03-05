//
//  HMCheckView.h
//  HealthMall
//
//  Created by qiuwei on 15/11/17.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCheckPotocol.h"

@class HMCheckView;

@protocol HMCheckViewDelegate <NSObject>

 @optional
/**
 *  点击某一行触发
 *
 *  @param checkView HMCheckView
 *  @param id<HMCheckPotocol> 被选中所有行的模型（单选模式永远只有一个元素）
 */
- (void)checkViewClick:(HMCheckView *)checkView checkeds:(NSArray<id<HMCheckPotocol> > *)checkeds;
/**
 *  是否允许选中这一行
 *
 *  @param id<HMCheckPotocol> 准备被选中的一行（模型）
 *  @param checkeds 已经选中的所有行（模型）
 *
 *  @return 是否允许 默认YES
 */
- (BOOL)checkViewShouldBeginSelectCheck:(id<HMCheckPotocol>)check;
@end

@interface HMCheckView : UIView

@property (nonatomic, strong) NSArray<id<HMCheckPotocol>> *checks;
@property (nonatomic, strong, readonly) NSMutableArray<id<HMCheckPotocol>> *checkeds; // 被选的所有模型

@property (nonatomic, assign, getter=isMultipleCheck) BOOL multipleCheck;   // 是否开启了多选模式
@property (nonatomic, assign, getter=isShowCheckMark) BOOL showCheckMark; // 是否显示选中标记 默认NO
@property (nonatomic, assign, getter=isShowIndexs) BOOL showIndexs; // 是否显示索引条 默认NO

@property (nonatomic, weak) id<HMCheckViewDelegate> delegate;

@property (nonatomic, assign) BOOL iconRounded; // 图标圆角 (默认YES)
@property (nonatomic, strong) UIColor *iconBackgroundColor; // 图标背景色

@property (nonatomic, strong) NSArray<NSString *> *filters; // 过滤词（多个）

// 需要开启多选模式可以使用此方法创建（默认单选）
+ (instancetype)checkWithMultipleCheck:(BOOL)isMultipleCheck;

- (void)reloadData;
@end
