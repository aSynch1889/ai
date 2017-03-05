//
//  ISVAlertView.h
//  ISV
//
//  Created by aaaa on 15/11/20.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ISVAlertViewCompletionBlock)(BOOL cancelled, NSInteger buttonIndex);


/**
 *  ISVAlertView主要类
 */
@interface ISVAlertView : UIViewController

@property (nonatomic, getter = isVisible) BOOL visible;

/**
 *  弹出带标题的Alert
 */
+ (instancetype)showAlertWithTitle:(NSString *)title;

/**
 *  弹出带标题和消息体的Alert
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                        completion:(ISVAlertViewCompletionBlock)completion;

/**
 *  弹出带标题和消息体的Alert, 并修改取消按钮标题
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        completion:(ISVAlertViewCompletionBlock)completion;

/**
 *  弹出带标题和消息体的Alert, 并修改取消按钮标题和其他按钮标题
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                        completion:(ISVAlertViewCompletionBlock)completion;

/**
 *  弹出带标题和消息体的Alert, 并修改取消按钮标题和其他按钮标题, 按钮是否层叠
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                buttonsShouldStack:(BOOL)shouldStack
                        completion:(ISVAlertViewCompletionBlock)completion;

/**
 *  弹出带多个其他标题和消息体的Alert...
 *  @param otherTitles必须是NSArray中包含类型的NSString, 如果无需otherTitles则设置为nil. 所有选项自动层叠.
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                        completion:(ISVAlertViewCompletionBlock)completion;

/**
 *  弹出一个contentView
 *  @param contentView会被添加到alertView里面然后弹出，且弹出后会被销毁
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                       contentView:(UIView *)view
                        completion:(ISVAlertViewCompletionBlock)completion;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                buttonsShouldStack:(BOOL)shouldStack
                       contentView:(UIView *)view
                        completion:(ISVAlertViewCompletionBlock)completion;

/**
 * @param otherTitles必须是NSArray中包含类型的NSString, 如果无需otherTitles则设置为nil.
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                       contentView:(UIView *)view
                        completion:(ISVAlertViewCompletionBlock)completion;
/**
 *  根据数组创建alertView，（现主要用于无法获取验证码）
 *
 *  @param otherTitles 标题数组
 */
+ (instancetype)showAlertWithTitles:(NSArray *)otherTitles
                        contentView:(UIView *)view
                         completion:(ISVAlertViewCompletionBlock)completion;

/**
 * 添加一个按钮，并给定标题
 * @param 新按钮的标题
 * @return 新按钮的索引。按键编号从0开始，并增加它们的添加顺序。
 */
- (NSInteger)addButtonWithTitle:(NSString *)title;

/**
 * 让alertView消失
 */
- (void)dismiss;

/**
 * 给某个按钮的点击事件 使alertView消失的同时可以带动画效果。
 */
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

/**
 * 默认情况下，点击灰色背景不会让AlertView消失. 可以使用这个方法开启。
 */
- (void)setTapToDismissEnabled:(BOOL)enabled;

- (NSArray *)otherButtons;
- (UIView *)contentView;
@end
