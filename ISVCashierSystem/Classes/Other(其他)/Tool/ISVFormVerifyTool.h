//
//  ISVFormVerifyTool.h
//  ISV
//
//  Created by aaaa on 15/12/17.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

// 表单验证工具类
@interface ISVFormVerifyTool : NSObject

/** 是否是手机号码 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/** 判断是否存在手机号码 */
+ (BOOL)isExistedMobileNumber:(NSString *)mobileNum;

/** 固话验证*/
+ (BOOL)isValidateTel:(NSString *)tel;

/** 车牌号验证*/
+ (BOOL)isValidateCarNo:(NSString*)carNo;

/** 邮箱验证*/
+ (BOOL)isValidateEmail:(NSString *)email;

/** 邮政编码验证*/
+ (BOOL)isValidatePostalcode:(NSString *)code;

/** 身份证验证*/
+ (BOOL)isValidateIdentityCarNo:(NSString*)carNo;

/** 银行卡号验证*/
+ (BOOL)isValidateBankCarNo:(NSString*)carNo;

/** 护照验证*/
+ (BOOL)isValidatePassport:(NSString*)passport;

/** 用户昵称验证*/
+ (BOOL)isValidateNickname:(NSString*)nickname;

/** 用户数字验证*/
+ (BOOL)isNumber:(NSString *)numString;
/**
 *  是否是数字字母组合
 */
+ (BOOL)isNumberORLetter:(NSString *)numString;
@end
