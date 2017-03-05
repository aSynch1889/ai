//
//  ISVPlaceholderTextView.h
//  ISV
//
//  Created by aaaa on 17/3/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISVPlaceholderTextView;
typedef void(^inputTextViewBlock)(ISVPlaceholderTextView *textField, NSString *fromString);
typedef void(^overflowTextViewBlock)(ISVPlaceholderTextView *textField, NSString *toString);


@interface ISVPlaceholderTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;          // 占位文字
@property (nonatomic, strong) UIColor *placeholderColor;    // 占位文字的颜色

@property (nonatomic, assign) CGFloat textLeftMargin;       // 文本左边距

// 保持一定字符个数
- (void)keepToLength:(NSInteger)length inputBlock:(inputTextViewBlock)inputBlock overflowBlock:(overflowTextViewBlock)overflowBlock;
@end
