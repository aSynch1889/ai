//
//  NSString+HMPath.m
//  HealthMall
//
//  Created by qiuwei on 15/11/25.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "NSString+HMPath.h"

@implementation NSString (HMPath)

/**
 *  返回缓存路径的完整路径名
 */
- (NSString *)cachePath
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

/**
 *  返回文档路径的完整路径名
 */
- (NSString *)documentPath
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

/**
 *  返回临时路径的完整路径名
 */
- (NSString *)tmpPath
{
    NSString *dir = NSTemporaryDirectory();
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}
/**
 *  判断文件是否存在
 */
- (BOOL)FileIsExists
{
    if([[NSFileManager defaultManager] fileExistsAtPath:self]){
        return true;
    }
    return  false;
} 


@end
