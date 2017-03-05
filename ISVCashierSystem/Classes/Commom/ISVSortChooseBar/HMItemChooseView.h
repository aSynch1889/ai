//
//  HMItemChooseView.h
//  HealthMall
//
//  Created by jkl on 15/12/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HMItemChooseViewDelegate <NSObject>
- (void)didChooseItemWithTitle:(NSString *)title item:(NSString *)item;
@end


@interface HMItemChooseView : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id <HMItemChooseViewDelegate> delegate;

+ (instancetype)itemChooseViewWithY:(CGFloat)y title:(NSString *)title items:(NSArray *)items;

/// 重置(设置全部未选中状态)
- (void)reset;

@end
