//
//  ISVIndicatorField.h
//  ISV
//
//  Created by aaaa on 15/12/12.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISVFormField : UITextField

@property (nonatomic, copy) void (^tapBlock)();

/**
 * `带跳转箭头指示器的textField`
 * 默认Height是30
 */
+ (instancetype)indicatorFieldWithPoint:(CGPoint)point tapBlock:(void (^)())block;

/**
 * `不带跳转箭头指示器的textField`
 * 默认Height是30
 */
+ (instancetype)normalFieldWithPoint:(CGPoint)point;

@end
