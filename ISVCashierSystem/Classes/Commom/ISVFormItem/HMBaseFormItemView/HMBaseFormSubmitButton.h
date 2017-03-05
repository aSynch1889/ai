//
//  HMBaseFormSubmitButton.h
//  HealthMall
//
//  Created by qiuwei on 15/11/15.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HMBaseFormSubmitButtonTypeGreen,    // 绿色背景
    HMBaseFormSubmitButtonTypeRed,      // 红色背景
} HMBaseFormSubmitButtonType;

@interface HMBaseFormSubmitButton : UIButton
@property (nonatomic, assign) HMBaseFormSubmitButtonType bgtype;
@end
