//
//  HMBaseFormItemTextView.h
//  HealthMall
//
//  Created by qiuwei on 15/11/15.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMBaseFormItemModel.h"
#import "HMPlaceholderTextView.h"

@interface HMBaseFormItemTextView : UIView
@property (nonatomic, strong) HMBaseFormItemModel *formItem;
@property (weak, nonatomic) IBOutlet HMPlaceholderTextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) CGFloat titleWidth;
@end
