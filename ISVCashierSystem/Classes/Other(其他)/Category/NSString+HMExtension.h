//
//  NSString+HMExtension.h
//  HealthMall
//
//  Created by jkl on 15/11/18.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HMExtension)

/**
 * `返回缩略图的URLStr`
 */
- (NSString *)thumbnailURLWithString;

/**
 *  URL编码
 */
- (NSString *)urlStringEncoding;
/**
 *  URL反编码
 */
- (NSString *)urlStringDecoding;

/**
 *  根据code获取URL对象，会使用默认的图片路径，如果本来是网址就直接返回
 */
- (NSURL *)URLFromCode;

/**
 * `计算NSString的尺寸`
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  判断是否是整形
 */
- (BOOL)isPureInt;
/**
 *  浮点形判断
 */
- (BOOL)isPureFloat;

/**
 *  去掉两边的空格
 */
- (NSString *)trim;

/**
 *  判断NSString字符串是否包含emoji表情
 *
 *  @param string 需要判断的字符串
 *
 *  @return 返回是否包含
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;
/**
 *  对时间段的相邻时段合并处理
 *
 *  @param timeArray 需要处理的时间段
 *
 *  @return 处理完的时间段
 */
+ (NSMutableArray *)processSelectedTime:(NSMutableArray *)timeArray;
@end
