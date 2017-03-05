//
//  HMServeView.h
//  HealthMall
//
//  Created by johnWu on 16/1/1.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class hm_pav_specialservices;

@protocol HMServeViewDelegate <NSObject>

@optional
@optional
- (void)didClickServeViewAtIndex:(NSUInteger)index isSelected:(BOOL)isSelected;
@end

@interface HMServeView : UIView

@property (nonatomic, strong) hm_pav_specialservices *servers;
@property (nonatomic, assign) BOOL shouldEdit;// 是否允许点击
@property (nonatomic, weak) id<HMServeViewDelegate> delegate;
@end
