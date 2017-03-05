//
//  ISVPayWayPanelView.h
//  ISV
//
//  Created by aaaa on 16/1/8.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISVPayModel.h"

@protocol ISVPayWayPanelViewDelegate <NSObject>
@optional
- (void)selectedPayWay:(ISVPayWay)payWay;

@end

@interface ISVPayWayPanelView : UIView
@property (nonatomic, weak) id<ISVPayWayPanelViewDelegate> delegate;
/// 选定的支付方式
@property (nonatomic, assign, readonly) ISVPayWay selectedPayWay;


@end
