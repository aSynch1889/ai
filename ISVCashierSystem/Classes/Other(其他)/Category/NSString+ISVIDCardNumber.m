//
//  NSString+ISVIDCardNumber.m
//  ISVFriendsDemo
//
//  Created by ZhouChunlong on 16/3/4.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "NSString+ISVIDCardNumber.h"

@implementation NSString (ISVIDCardNumber)

//中国
- (BOOL)validateIdentityCardInChina
{
    NSString *carRegex = @"^[1-9]\\d{5}[1-9]9\\d{4}3[0-1]\\d{4}$|^[1-9]\\d{5}[1-9]9\\d{4}[0-2][0-9]\\d{4}$|^[1-9]\\d{5}[1-9]9\\d{4}3[0-1]\\d{3}X$|^[1-9]\\d{5}[1-9]9\\d{4}[0-2][0-9]\\d{3}X$|^[1-9]\\d{5}\\d{4}3[0-1]\\d{4}$|^[1-9]\\d{5}\\d{4}[0-2][0-9]\\d{4}$|^[1-9]\\d{5}\\d{4}3[0-1]\\d{3}X$|^[1-9]\\d{5}\\d{4}[0-2][0-9]\\d{3}X$";
    return [self stringWithRegex:carRegex];
}

//香港
- (BOOL)validateIdentityCardInHongKong {
    //规则:http://shenfenzheng.bajiu.cn/?rid=40
    BOOL validate = [self stringWithRegex:@"^[A-Za-z]\\d{6}\\((\\d|[Aa])\\)"];
    
    if (validate) {
        //计算
        
        //首字母
        NSString *initial = [self substringToIndex:1];
        NSInteger asciiCode = [initial characterAtIndex:0];
        
        NSInteger num1;
        if (asciiCode>=65 && asciiCode<=90) {
            num1 = asciiCode - 65 + 1;
        } else {
            num1 = asciiCode - 97 +1;
        }
        NSInteger num2 = [[self substringWithRange:NSMakeRange(1, 1)] integerValue];
        NSInteger num3 = [[self substringWithRange:NSMakeRange(2, 1)] integerValue];
        NSInteger num4 = [[self substringWithRange:NSMakeRange(3, 1)] integerValue];
        NSInteger num5 = [[self substringWithRange:NSMakeRange(4, 1)] integerValue];
        NSInteger num6 = [[self substringWithRange:NSMakeRange(5, 1)] integerValue];
        NSInteger num7 = [[self substringWithRange:NSMakeRange(6, 1)] integerValue];
        
        NSInteger result = num1*8 + num2*7 + num3*6 + num4*5 + num5*4 + num6*3 + num7*2;
        
        NSInteger remainder = result%11;
        
        NSString *lastCode = [self substringWithRange:NSMakeRange(8, 1)];
        if (remainder == 10) {
            validate = [lastCode stringWithRegex:@"^[Aa]"];
        } else {
            if ([lastCode stringWithRegex:@"^[Aa]"]) {
                validate = NO;
            } else {
                NSInteger num8 = [[self substringWithRange:NSMakeRange(8, 1)] integerValue];
                validate = (remainder == num8);
            }
        }
    }
    
    return validate;
}

//澳门
- (BOOL)validateIdentityCardInMacao {
    //规则:http://shenfenzheng.bajiu.cn/?rid=377
    BOOL validate = [self stringWithRegex:@"^(1|5|7)\\d{6}\\(\\d\\)"];
    
    if (validate) {
        //计算(不知道怎么算)
    }
    
    return validate;
}

//台湾
- (BOOL)validateIdentityCardInTaiwan {
    //规则:http://shenfenzheng.bajiu.cn/?rid=39
    BOOL validate = [self stringWithRegex:@"^[A-Za-z](1|2)\\d{8}"];
    
    if (validate) {
        //计算(太烦,不会算...)
    }
    
    return validate;
}


/**
 *  正则表达式验证
 *
 *  @param regex 正则表达式字符串
 */
- (BOOL)stringWithRegex:(NSString *)regex {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}

@end
