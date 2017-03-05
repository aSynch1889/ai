//
//  HMTextField.h
//  HealthMall
//
//  Created by qiuwei on 15/11/15.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMTextField;
typedef void(^inputBlock)(HMTextField *textField, NSString *fromString);
typedef void(^overflowBlock)(HMTextField *textField, NSString *toString);

@interface HMTextField : UITextField

@property (nonatomic, strong) UIColor *placeholderColor;    // 占位文本颜色
@property (nonatomic, assign) CGFloat textLeftMargin;       // 文本左边距

// 保持一定字符个数
- (void)keepToLength:(NSInteger)length inputBlock:(inputBlock)inputBlock overflowBlock:(overflowBlock)overflowBlock;

@end
