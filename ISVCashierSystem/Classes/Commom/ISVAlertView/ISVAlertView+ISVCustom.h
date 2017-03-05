//
//  ISVAlertView+ISVCustom.h
//  ISV
//
//  Created by aaaa on 15/11/20.
//  Copyright © 2017年 ISV. All rights reserved.
//

/**
 *  ISVAlertView自定义类（常用方法供项目使用，并带样式）
 */
#import "ISVAlertView.h"

@interface ISVAlertView (ISVCustom)

/**
 *  只带确认按钮的提示框
 */
+ (instancetype)showCustomConfirmAlertWithTitle:(NSString *)title
                                        message:(NSString *)message
                                     completion:(ISVAlertViewCompletionBlock)completion;

/**
 *  (通用自定义方法)弹出带标题和消息体的Alert, 并修改取消按钮标题和其他按钮标题
 *
 *  @param title      标题
 *  @param message    消息体
 *  @param completion 完成后回调
 *
 *  @return ISVAlertView对象
 */

+ (instancetype)showCustomAlertWithTitle:(NSString *)title
                                 message:(NSString *)message
                              completion:(ISVAlertViewCompletionBlock)completion;

+ (instancetype)showCustomAlertWithTitle:(NSString *)title
                                 message:(NSString *)message
                             cancelTitle:(NSString *)cancelTitle
                              otherTitle:(NSString *)otherTitle
                              completion:(ISVAlertViewCompletionBlock)completion;

/**
 * 添加好友专用
 */
+ (instancetype)showCustomAlertWithTitle:(NSString *)title placeholder:(NSString *)placeholder completion:(ISVAlertViewCompletionBlock)completion;

/**
 * 可添加一个contentView
 * @param otherTitles必须是NSArray中包含类型的NSString, 如果无需otherTitles则设置为nil.
 */
+ (instancetype)showCustomAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                       contentView:(UIView *)view
                        completion:(ISVAlertViewCompletionBlock)completion;
@end
