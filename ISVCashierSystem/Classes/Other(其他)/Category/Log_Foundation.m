//
//  NSDictionary+Foundation_Log.m
//
//  Created by Hugo on 15/7/16.
//  Copyright (c) 2015年 Hugo. All rights reserved.
//

#import <Foundation/Foundation.h>

// 重写打印结构
@implementation NSDictionary (Log)

-(NSString *)descriptionWithLocale:(id)locale
{
    /* 定义要输出的内容---搞一个可变的字符串 */
    NSMutableString *outString = [NSMutableString string];
    
    /* 目标格式为 */
    /*
     {
        "weathers" : [
            {"city":"Beijing","status":"晴转多云"},
            {"city":"Guangzhou","status":"晴转多云"},
            {"city":"Shanghai","status":"晴转多云"}
        ]
     } 
     */
    /* 所以先加两个大括号-之后在遍历这个原字典 */
    // 1.前括号
    [outString appendString:@"{\n"];
    
    // 3.加入字典中的内容要先遍历原字典--self就是原字典，他调用自己的这个方法
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
       // key obj对应 key和value
        if ([key isKindOfClass:[NSString class]]) {
            key = [NSString stringWithFormat:@"\"%@\"", key];
        }
        if ([obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"\"%@\"", obj];
        }
        [outString appendFormat:@"\t%@",key];
        [outString appendFormat:@" : "];
        [outString appendFormat:@"%@,\n",obj];// 每个元素后都有一个逗号
    }];
    
    
    // 2.后括号
    [outString appendString:@"\n}"];

    
    // 3.查找最后一个逗号干掉
    NSRange range = [outString rangeOfString:@"," options: NSBackwardsSearch];
    if (range.location != NSNotFound) {//判断是否找到最后一个逗号
        // 干掉
        [outString deleteCharactersInRange:range];
    }
    
    return outString;
}

@end


@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    /* 定义要输出的内容---搞一个可变的字符串 */
    NSMutableString *outString = [NSMutableString string];
    
    /* 目标格式为 */
    /*
      [
        {"city":"Beijing","status":"晴转多云"},
        {"city":"Guangzhou","status":"晴转多云"},
        {"city":"Shanghai","status":"晴转多云"}
      ]
     */
    /* 所以先加两个大括号-之后在遍历这个原字典 */
    // 1.前括号--[
    [outString appendString:@"[\n"];
    
    // 3.遍历数组
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"\"%@\"", obj];
        }
        [outString appendFormat:@" \t%@,\n",obj];
    }];
    
    
    // 2.后括号--]
    [outString appendString:@"\n\t]"];
    
    // 3.查找最后一个逗号干掉
    NSRange range = [outString rangeOfString:@"," options: NSBackwardsSearch];
    if (range.location != NSNotFound) {//判断是否找到最后一个逗号
        // 干掉
        [outString deleteCharactersInRange:range];
    }

    return outString;
}

@end
