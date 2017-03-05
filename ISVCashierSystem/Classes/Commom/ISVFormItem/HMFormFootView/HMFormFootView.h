//
//  HMFormFootView.h
//  HealthMall
//
//  Created by qiuwei on 15/11/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMBaseFormSubmitButton.h"

@class HMBaseFormSubmitButton;

@interface HMFormFootView : UIView

@property (nonatomic, weak, readonly) UIView *contentView;
@property (nonatomic, weak, readonly) HMBaseFormSubmitButton *submitButton;
@end
