//
//  HMBottomToolBar.h
//  HealthMall
//
//  Created by jkl on 15/12/11.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMBottomToolBar;
@protocol HMBottomToolBarDelagate <NSObject>

- (void)bottomToolBarDidSelectedAtIndex:(NSInteger)index;

@end

/**** 底部按钮工具条 ****/
@interface HMBottomToolBar : UIView
@property (nonatomic, weak) id <HMBottomToolBarDelagate> delegate;

/**
 * `底部按钮工具条`
 * titles:按钮标题数组
 * 无需手动设定frame, 为固定值 (0, kSCREEN_HEIGHT-49, kSCREEN_WIDTH, 49)
 */
+ (instancetype)bottomToolBarWithTitles:(NSArray *)titles;

- (UIButton *)buttonAtIndex:(NSInteger)index;

@end
