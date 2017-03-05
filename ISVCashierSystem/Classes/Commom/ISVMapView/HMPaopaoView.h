//
//  HMPaopaoView.h
//  HealthMall
//
//  Created by qiuwei on 15/12/28.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMPaopaoView, HMPointAnnotation;

typedef enum : NSUInteger {
    HMPaopaoViewStateAdd = 0,
    HMPaopaoViewStateDel = 1,
    HMPaopaoViewStateNor = 3
} HMPaopaoViewState;

@interface HMPaopaoView : UIView
@property (nonatomic, strong) HMPointAnnotation *pointAnnotation;
@property (nonatomic, assign) HMPaopaoViewState state;


/**
 *  弹出PaopaoView的按钮标题 为nil时使用默认的
 */
- (void)setButtonTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle;

@end
