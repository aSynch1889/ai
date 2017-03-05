//
//  HMFormVerifyTool.m
//  HealthMall
//
//  Created by qiuwei on 15/12/17.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMFormVerifyTool.h"
#import "NSString+HMExtension.h"

@implementation HMFormVerifyTool

/* 手机号码验证 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    // 手机号以13，15，18开头，八个 \d 数字字符  170开头的也判断为可以
//    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0,0-9])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"(^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$)|(^(((\\d{3}))|(\\d{3}-))?(1[34578]\\d{9})$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobileNum];
}

// 判断是否存在手机号码
+ (BOOL)isExistedMobileNumber:(NSString *)mobileNum
{
    mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    if ([mobileNum hasPrefix:@"86"]) {
        mobileNum = [mobileNum substringFromIndex:2];
    }
    
    return mobileNum.length == 11 && [self isMobileNumber:mobileNum];
}

// 固话验证
+ (BOOL)isValidateTel:(NSString *)tel
{
//    NSString *TelRegex = @"^(0(10|2[1-3]|[3-9]\\d{2}))?[1-9]\\d{6,7}$";
    NSString *TelRegex = @"^[+]{0,1}0(\\d){1,3}([ -]{0,1}(\\d{5,9}))+$";
    NSPredicate *TelTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",TelRegex];
    
    return [TelTest evaluateWithObject:tel];
}

/* 邮箱验证 */
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 邮编验证[1-9]d{5}(?!d)   [1-9]d{5}（?!d）
+ (BOOL)isValidatePostalcode:(NSString *)code
{
    NSString *codeRegex = @"^[1-9]\\d{5}$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    return [codeTest evaluateWithObject:code];
}

/* 车牌号验证 */
+ (BOOL)isValidateCarNo:(NSString*) carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

// 身份证验证d{15}|d{18}
+ (BOOL)isValidateIdentityCarNo:(NSString*)carNo
{
    NSString *carRegex = @"^[1-9]\\d{5}[1-9]9\\d{4}3[0-1]\\d{4}$|^[1-9]\\d{5}[1-9]9\\d{4}[0-2][0-9]\\d{4}$|^[1-9]\\d{5}[1-9]9\\d{4}3[0-1]\\d{3}X$|^[1-9]\\d{5}[1-9]9\\d{4}[0-2][0-9]\\d{3}X$|^[1-9]\\d{5}\\d{4}3[0-1]\\d{4}$|^[1-9]\\d{5}\\d{4}[0-2][0-9]\\d{4}$|^[1-9]\\d{5}\\d{4}3[0-1]\\d{3}X$|^[1-9]\\d{5}\\d{4}[0-2][0-9]\\d{3}X$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}
// 银行卡号验证d{16}|d{19}
+ (BOOL)isValidateBankCarNo:(NSString*)carNo
{
    NSString *carRegex = @"^\\d{1,26}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

// 护照^1[45][0-9]{7}|G[0-9]{8}|P[0-9]{7}|S[0-9]{7,8}|D[0-9]+$
+ (BOOL)isValidatePassport:(NSString*)passport
{
    NSString *carRegex = @"^1[45][0-9]{7}|G[0-9]{8}|P[0-9]{7}|S[0-9]{7,8}|D[0-9]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:passport];
}

/* 用户昵称验证 */
+ (BOOL)isValidateNickname:(NSString*)nickname{
    
    NSString *regex = @"[a-zA-Z]|[a-zA-Z0-9]|[0-9]|[a-zA-Z\u4e00-\u9fa5]|[\u4e00-\u9fa5]|[a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:nickname];
}

+ (BOOL)isNumber:(NSString *)numString
{
    return [numString isPureInt];
}

/**
 *  是否是数字字母组合
 */
+ (BOOL)isNumberORLetter:(NSString *)numString
{
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return  [pred evaluateWithObject:numString];
}

+ (BOOL)IdentityCarStrictValidateCarNo:(NSString *)carNo
{
//    NSString *carRegex = @"^[1-9]\d{5}[1-9]9\d{4}3[0-1]\d{4}$|^[1-9]\d{5}[1-9]9\d{4}[0-2][0-9]\d{4}$|^[1-9]\d{5}[1-9]9\d{4}3[0-1]\d{3}X$|^[1-9]\d{5}[1-9]9\d{4}[0-2][0-9]\d{3}X$|^[1-9]\d{5}\d{4}3[0-1]\d{4}$|^[1-9]\d{5}\d{4}[0-2][0-9]\d{4}$|^[1-9]\d{5}\d{4}3[0-1]\d{3}X$|^[1-9]\d{5}\d{4}[0-2][0-9]\d{3}X$";
    // 大陆身份证
    NSString *carRegex = @"^[1-9]\\d{5}[1-9]9\\d{4}3[0-1]\\d{4}$|^[1-9]\\d{5}[1-9]9\\d{4}[0-2][0-9]\\d{4}$|^[1-9]\\d{5}[1-9]9\\d{4}3[0-1]\\d{3}X$|^[1-9]\\d{5}[1-9]9\\d{4}[0-2][0-9]\\d{3}X$|^[1-9]\\d{5}\\d{4}3[0-1]\\d{4}$|^[1-9]\\d{5}\\d{4}[0-2][0-9]\\d{4}$|^[1-9]\\d{5}\\d{4}3[0-1]\\d{3}X$|^[1-9]\\d{5}\\d{4}[0-2][0-9]\\d{3}X$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    if ([phoneTest evaluateWithObject:phoneTest]) {
        return YES;
    }
    
    // region 台湾身份证
//    NSArray<NSString *> *ListNumber = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
//    
    if (carNo.length == 10)
    {
        if ([[carNo substringWithRange:NSMakeRange(1, 9)] isPureInt])// 中间部分必须为数字
        {
            // 开头必须为A~Z的字母
            
            if (IsLetter([[carNo substringWithRange:NSMakeRange(0, 1)] characterAtIndex:0]))
            {
                int s;
                NSString *letters = @"ABCDEFGHJKLMNPQRSTUVXYWZIO";
                NSString *head = [carNo substringWithRange:NSMakeRange(0, 1)];
//                NSString *foot = [carNo substringWithRange:NSMakeRange(1, 9)];
                
                NSRange range = [letters rangeOfString:head];
                if (range.location != NSNotFound) {
                    NSInteger headNum = range.location + 10;
                    //                common.hm_vi_idcard = (head.IndexOf(common.hm_vi_idcard.Substring(0, 1)) + 10) + "" + common.hm_vi_idcard.Substring(1, 9);
                    NSMutableString *mutableCarNo =  [carNo mutableCopy];
                    [mutableCarNo replaceCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%zd", headNum]];
//                    
//                    s = Convert.ToInt32(common.hm_vi_idcard.Substring(0, 1)) +
//                    Convert.ToInt32(common.hm_vi_idcard.Substring(1, 1)) * 9 +
//                    Convert.ToInt32(common.hm_vi_idcard.Substring(2, 1)) * 8 +
//                    Convert.ToInt32(common.hm_vi_idcard.Substring(3, 1)) * 7 +
//                    Convert.ToInt32(common.hm_vi_idcard.Substring(4, 1)) * 6 +
//                    Convert.ToInt32(common.hm_vi_idcard.Substring(5, 1)) * 5 +
//                    Convert.ToInt32(common.hm_vi_idcard.Substring(6, 1)) * 4 +
//                    Convert.ToInt32(common.hm_vi_idcard.Substring(7, 1)) * 3 +
//                    Convert.ToInt32(common.hm_vi_idcard.Substring(8, 1)) * 2 +
//                    Convert.ToInt32(common.hm_vi_idcard.Substring(9, 1)) +
//                    Convert.ToInt32(common.hm_vi_idcard.Substring(10, 1));
                    
                    // 判斷是否可整除
                    if ((s % 10) == 0){
                        return YES;
                    }
                }
            }
        }
    }
    
//    // region 香港身份证
//    bool istrueHK = false;
//    //这是验证第一位的是否是A~Z
//    if (ListNumber.Contains(common.hm_vi_idcard.Substring(0, 1)))
//    {
//        int a = 0;
//        //这是验证身份证长度的
//        if (common.hm_vi_idcard.IndexOf('(') >= 0 && common.hm_vi_idcard.Length == 10)
//        {
//            //这是验证中间六位的
//            if (int.TryParse(common.hm_vi_idcard.Substring(1, 6), out a))
//            {
//                //这是验证，身份证第八位是否是（，第十位是否是）
//                if (common.hm_vi_idcard.Substring(7, 1) == "(" && common.hm_vi_idcard.Substring(9, 1) == ")")
//                {
//                    string aa = common.hm_vi_idcard.Substring(8, 1);
//                    //这是验证第9位是否是数字的以及A
//                    string[] NumberHK = new string[] { "A", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" };
//                    List<string> ListNumberHK = new List<string>(NumberHK);
//                    
//                    istrueHK = ListNumberHK.Contains(common.hm_vi_idcard.Substring(8, 1));
//                }
//            }
//        }
//    }
//    if (istrueHK)
//    {
//        cr.succeed = true;
//        cr.errmsg = "";
//        return cr;
//    }

//    
//    // region 澳门身份证
//    bool istrue = false;
//    //这是验证第一位的
//    if (common.hm_vi_idcard.Substring(0, 1) == "1" || common.hm_vi_idcard.Substring(0, 1) == "5" || common.hm_vi_idcard.Substring(0, 1) == "7")
//    {
//        int a = 0;
//        //这是验证身份证长度的
//        if (common.hm_vi_idcard.IndexOf('(') >= 0 && common.hm_vi_idcard.Length == 10)
//        {
//            //这是验证中间六位的
//            if (int.TryParse(common.hm_vi_idcard.Substring(1, 6), out a))
//            {
//                
//                //这是验证，身份证第八位是否是（，第十位是否是）
//                if (common.hm_vi_idcard.Substring(7, 1) == "(" && common.hm_vi_idcard.Substring(9, 1) == ")")
//                {
//                    string aa = common.hm_vi_idcard.Substring(8, 1);
//                    //这是验证第9位是否是数字的
//                    istrue = Regex.IsMatch(common.hm_vi_idcard.Substring(8, 1), "^[0-9]*$");
//                }
//            }
//        }
//    }
//    if (istrue)
//    {
//        cr.succeed = true;
//        cr.errmsg = "";
//        return cr;
//    }
    return NO;
}

@end
