//
//  HMPayWayPanelView.h
//  HealthMall
//
//  Created by jkl on 16/1/8.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMPayModel.h"

@protocol HMPayWayPanelViewDelegate <NSObject>
@optional
- (void)selectedPayWay:(HMPayWay)payWay;

@end

@interface HMPayWayPanelView : UIView
@property (nonatomic, weak) id<HMPayWayPanelViewDelegate> delegate;
/// 选定的支付方式
@property (nonatomic, assign, readonly) HMPayWay selectedPayWay;


@end
