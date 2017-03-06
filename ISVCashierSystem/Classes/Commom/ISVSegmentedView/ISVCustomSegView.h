//
//  ISVCustomSegView.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/6.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    自定义segmentView
 */
@protocol ISVCustomSegViewDelegate <NSObject>

/**
    代理方法

 @param tag 选中的按钮
 */
- (void)D_selectedTag:(NSInteger)tag;

@end

@interface ISVCustomSegView : UIView


/**
 初始化方法

 @param titles 名称数组
 @param frame frame
 @param delegate 代理
 @return
 */
- (instancetype)initWithNumberOfTitles:(NSArray *)titles andFrame:(CGRect)frame delegate:(id<ISVCustomSegViewDelegate>)delegate;

@end
