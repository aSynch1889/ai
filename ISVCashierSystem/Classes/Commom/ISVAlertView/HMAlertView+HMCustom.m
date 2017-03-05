//
//  HMAlertView+HMCustom.m
//  HealthMall
//
//  Created by qiuwei on 15/11/20.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMAlertView+HMCustom.h"
#import "HMAlertView+HMStyle.h"

#define kAlertViewCancelTitle @"取消"
#define kAlertViewOtherTitle @"确定"

#define kAlertViewCommonColor [UIColor colorWithRed:96/255.0 green:209/255.0 blue:147/255.0 alpha:1.0]

@implementation HMAlertView (HMCustom)

/**
 *  只带确认按钮的提示框
 */
+ (instancetype)showCustomConfirmAlertWithTitle:(NSString *)title
                                        message:(NSString *)message
                                     completion:(HMAlertViewCompletionBlock)completion
{
    HMAlertView *alert = [HMAlertView showAlertWithTitle:title message:message completion:^(BOOL cancelled, NSInteger buttonIndex) {
        ! completion ? : completion(cancelled, buttonIndex);
    }];
    
    [alert setCancelButtonBackgroundColor:kAlertViewCommonColor];
//    [alert setCancelButtonNonSelectedBackgroundColor:kAlertViewCommonLightColor];
//    [alert setCancelButtonTextColor:[UIColor whiteColor]];
    return alert;
}


// (自定义方法)弹出带标题和消息体的Alert, 并修改取消按钮标题和其他按钮标题
+ (instancetype)showCustomAlertWithTitle:(NSString *)title
                                 message:(NSString *)message
                              completion:(HMAlertViewCompletionBlock)completion
{
    HMAlertView *alert = [HMAlertView showAlertWithTitle:title message:message cancelTitle:kAlertViewCancelTitle otherTitle:kAlertViewOtherTitle completion:^(BOOL cancelled, NSInteger buttonIndex) {
        ! completion ? : completion(cancelled, buttonIndex);
    }];

    [alert setOtherButtonNonSelectedBackgroundColor:kAlertViewCommonColor];
    [alert setOtherButtonBackgroundColor:kAlertViewCommonColor];
    [alert setOtherButtonTextColor:[UIColor whiteColor]];

    return alert;
}

+ (instancetype)showCustomAlertWithTitle:(NSString *)title
                                 message:(NSString *)message
                             cancelTitle:(NSString *)cancelTitle
                              otherTitle:(NSString *)otherTitle
                              completion:(HMAlertViewCompletionBlock)completion
{
    HMAlertView *alert = [HMAlertView showAlertWithTitle:title message:message cancelTitle:cancelTitle otherTitle:otherTitle completion:^(BOOL cancelled, NSInteger buttonIndex) {
        ! completion ? : completion(cancelled, buttonIndex);
    }];
    
    [alert setOtherButtonNonSelectedBackgroundColor:kAlertViewCommonColor];
    [alert setOtherButtonBackgroundColor:kAlertViewCommonColor];
    [alert setOtherButtonTextColor:[UIColor whiteColor]];
    
    return alert;
}

// 添加好友专用
+ (instancetype)showCustomAlertWithTitle:(NSString *)title placeholder:(NSString *)placeholder completion:(HMAlertViewCompletionBlock)completion
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH-76, 30)];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont systemFontOfSize:14];
    textField.placeholder = placeholder;
    textField.tintColor = HMMainlColor;
    [textField becomeFirstResponder];
    
    [textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];

    HMAlertView *alert =
    [HMAlertView showAlertWithTitle:title message:nil cancelTitle:@"取消" otherTitle:@"发送" contentView:textField completion:completion];
    
    [alert setOtherButtonNonSelectedBackgroundColor:kAlertViewCommonColor];
    [alert setOtherButtonBackgroundColor:kAlertViewCommonColor];
    [alert setOtherButtonTextColor:[UIColor whiteColor]];
    
    return alert;
}

+ (void)textDidChange:(UITextField *)textField
{
    if (textField.markedTextRange == nil && textField.text.length > 20)
    {
        textField.text = [textField.text substringToIndex:20];
    }
}

/**
 * @param otherTitles必须是NSArray中包含类型的NSString, 如果无需otherTitles则设置为nil.
 */
+ (instancetype)showCustomAlertWithTitle:(NSString *)title
                                 message:(NSString *)message
                             cancelTitle:(NSString *)cancelTitle
                             otherTitles:(NSArray *)otherTitles
                             contentView:(UIView *)view
                              completion:(HMAlertViewCompletionBlock)completion{
    HMAlertView *alert = [HMAlertView showAlertWithTitle:(NSString *)title
                                            message:(NSString *)message
                                            cancelTitle:(NSString *)cancelTitle
                                            otherTitles:(NSArray *)otherTitles
                                            contentView:(UIView *)view
                                              completion:(HMAlertViewCompletionBlock)completion];
    [alert setCancelButtonTextColor:HMRGB(255, 131, 131)];
    return alert;
}

@end
