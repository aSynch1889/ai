//
//  HMBaseFormSwitch.h
//  HealthMall
//
//  Created by qiuwei on 15/11/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSwitchView.h"
#import "HMSwitch.h"
#import "HMBaseFormItemModel.h"

@class HMBaseFormItemModel, HMBaseFormSwitch, HMSwitchView, HMSwitch;

@protocol HMBaseFormSwitchDelegate <NSObject>

- (void)switchClick:(HMBaseFormSwitch *)switchView index:(NSUInteger)index;

@end

@interface HMBaseFormSwitch : UIView
@property (nonatomic, weak) id<HMBaseFormSwitchDelegate> delegate;

@property (nonatomic, strong) HMBaseFormItemModel *formItem;

@property (weak, nonatomic) IBOutlet HMSwitchView *switchView;

@end
