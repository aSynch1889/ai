//
//  NSString+HMExtension.m
//  HealthMall
//
//  Created by jkl on 15/11/18.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "NSString+HMExtension.h"

@implementation NSString (HMExtension)

#pragma mark - URL
// `返回缩略图的URLStr`
- (NSString *)thumbnailURLWithString
{
    return [NSString stringWithFormat:@"%@/1", self];
}

// URL编码
- (NSString *)urlStringEncoding
{
    NSString *escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    kCFAllocatorDefault, /* allocator */
                                                                                                    (CFStringRef)self,
                                                                                                    NULL, /* charactersToLeaveUnescaped */
                                                                                                    CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),//(CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8));
    
    return escaped_value;
}

- (NSString *)urlStringDecoding
{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

// 根据code获取URL对象，会使用默认的图片路径，如果本来是网址就直接返回
- (NSURL *)URLFromCode
{
    if (NotNilAndNull(self)) {
        if ([self componentsSeparatedByString:@"/"].count == 1) {
            return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_IMAGE_URLSTRING, self]];
        }
        return [NSURL URLWithString:self];
    }
    return [NSURL URLWithString:@""];
}


// 计算尺寸
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    font = font?:[UIFont systemFontOfSize:17];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

// 判断是否是整形
- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

// 浮点形判断
- (BOOL)isPureFloat
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  去掉两边的空格
 */
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//判断NSString字符串是否包含emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}

+ (NSMutableArray *)processSelectedTime:(NSMutableArray *)timeArray{
    //合并后的时间字符串
    NSString* mergeTimeStr;
    //选择的时间段合并处理后的数组
    NSMutableArray* timeStrArray;
    //二维数组可解决这个问题
    NSMutableArray* data = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < timeArray.count; i++) {
        NSMutableArray* tmps = [[NSMutableArray alloc]init];
        [tmps addObject:timeArray[i]];
        if (i == timeArray.count - 1) {
            [data addObject:tmps];
            break;
        }
        int position = i;
        NSInteger tmpData = [timeArray[i] integerValue] + 1;
        while (YES) {
            position++;
            if (position<timeArray.count && tmpData == [timeArray[position] integerValue]) {
                [tmps addObject:timeArray[position]];
                i = position;
                
            }else{
                break;
            }
            tmpData = [timeArray[position] integerValue] + 1;
            
        }
        [data addObject:tmps];
    }
    //            NSLog(@"%@",data);
    NSMutableArray *crr = [[NSMutableArray alloc] init];
    timeStrArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < data.count; i++) {
        //                NSLog(@"----%@-----遍历data二维数组并打印",data[i]);
        crr = data[i];
        //合并时间段后的时间段数组
        mergeTimeStr = [NSString stringWithFormat:@"%ld:00-%zd:00",(long)[crr[0] integerValue],[crr[0] integerValue] + crr.count];
        [timeStrArray addObject:mergeTimeStr];
    }
    NSLog(@"---timeStrArray---%@-----",timeStrArray);
    
    return timeStrArray;
}

@end
