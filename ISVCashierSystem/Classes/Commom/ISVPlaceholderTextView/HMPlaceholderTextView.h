//
//  HMPlaceholderTextView.h
//  HealthMall
//
//  Created by qiuwei on 15/11/4.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMPlaceholderTextView;
typedef void(^inputTextViewBlock)(HMPlaceholderTextView *textField, NSString *fromString);
typedef void(^overflowTextViewBlock)(HMPlaceholderTextView *textField, NSString *toString);


@interface HMPlaceholderTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;          // 占位文字
@property (nonatomic, strong) UIColor *placeholderColor;    // 占位文字的颜色

@property (nonatomic, assign) CGFloat textLeftMargin;       // 文本左边距

// 保持一定字符个数
- (void)keepToLength:(NSInteger)length inputBlock:(inputTextViewBlock)inputBlock overflowBlock:(overflowTextViewBlock)overflowBlock;
@end
