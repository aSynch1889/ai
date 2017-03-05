//
//  ISVTextField.h
//  ISV
//
//  Created by aaaa on 15/11/15.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISVTextField;
typedef void(^inputBlock)(ISVTextField *textField, NSString *fromString);
typedef void(^overflowBlock)(ISVTextField *textField, NSString *toString);

@interface ISVTextField : UITextField

@property (nonatomic, strong) UIColor *placeholderColor;    // 占位文本颜色
@property (nonatomic, assign) CGFloat textLeftMargin;       // 文本左边距

// 保持一定字符个数
- (void)keepToLength:(NSInteger)length inputBlock:(inputBlock)inputBlock overflowBlock:(overflowBlock)overflowBlock;

@end
