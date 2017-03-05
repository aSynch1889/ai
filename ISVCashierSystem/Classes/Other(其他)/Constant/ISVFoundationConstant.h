//
//  ISVFoundationConstant.h
//  ISV
//
//  Created by aaaa on 17/3/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

/**
 *  基础宏
 */
#ifndef ISVFoundationConstant_h
#define ISVFoundationConstant_h

// ************************** 系统宏 ***************************************
#pragma mark 系统宏

// 自定义的log
#ifdef DEBUG    //调试
#define NSLog(...) NSLog(__VA_ARGS__)
#define LogFunc NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define LogFunc 
#endif

#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 *  系统是否小于iOS8.0
 *  if (SYSTEM_VERSION_LESS_THAN(@"8.0"))
 */
#define SYSTEM_VERSION_LESS_THAN(version) ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending)

#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0) ? YES : NO)

// ************************** 创建 ***************************************
#pragma mark 创建

// 便捷方式创建NSNumber类型
#undef	__INT
#define __INT( __x )			[NSNumber numberWithInt:(NSInteger)__x]

#undef	__UINT
#define __UINT( __x )			[NSNumber numberWithUnsignedInt:(NSUInteger)__x]

#undef	__FLOAT
#define	__FLOAT( __x )			[NSNumber numberWithFloat:(float)__x]

#undef	__DOUBLE
#define	__DOUBLE( __x )			[NSNumber numberWithDouble:(double)__x]

// ************************** 转换 ***************************************
#pragma mark 转换

// 便捷将int转NSString
#undef  STR_FROM_INT
#define STR_FROM_INT( __x )     [NSString stringWithFormat:@"%d", (__x)]

// C字符串转OC字符串
#define OC(str) [NSString stringWithCString:(str) encoding:NSUTF8StringEncoding]

// 将角度转换成弧度
#define angle2radius(angle) (angle)/180.f * M_PI

// 快速解析后台返回的数据respondData

// ************************** 判断 ***************************************
#pragma mark 判断

// 是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

// 字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
// 数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

// 判断字符是否一个字母
#define IsLetter(ch) (((ch)>='A'&&ch<='Z')||((ch)>='a'&&(ch)<='z'))

//tableview 列表左侧标题plist文件读取
#define kLoadTableviewPlist(file,type) [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:type]]

// 加载没有缓存的图片（图片名称）
#define noCacheImage(imageFile) [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], imageFile]]

// ************************** 声明 ***************************************
// 年月日结构体
typedef struct ISVDate
{
    long year;
    long month;
    long day;
    long hour;
    long minute;
    long second;
    long weekday;
} ISVDate;

// ************************** 通用字典的key ***************************************

#define kTitleKey   @"kTitleKey"
#define kMessageKey @"kMessageKey"
#define kContentKey @"kContentKey"
#define kClassNameKey @"kClassNameKey"

// 错误领域
#define kHMErrorDomain @"tv.healtmall.ios"

#endif /* ISVFoundationConstant_h */
