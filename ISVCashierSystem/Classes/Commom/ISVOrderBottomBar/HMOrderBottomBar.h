//
//  HMOrderBottomBar.h
//  HealthMall
//
//  Created by healthmall005 on 16/1/23.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMOrderBottomBarDelegate <NSObject>
/**
 *  底部栏按钮代理方法
 *
 *  @param index 索引
 */
- (void)orderBottomBarDidSelectedAtIndex:(NSInteger )index;

@end

@interface HMOrderBottomBar : UIView

@property (nonatomic, assign) HMOrderStatus status;
@property (nonatomic, weak) id<HMOrderBottomBarDelegate> delegate;
/**
 *  根据订单状态初始化底部按钮
 *
 *  @param status 订单状态
 *
 *  @return 底部栏
 */
+ (instancetype)bottomToolBarWithOrderStatus:(HMOrderStatus )status;

@end
