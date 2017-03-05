//
//  NSData+HMDataCache.m
//  HealthMall
//
//  Created by jkl on 15/11/4.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "NSData+HMDataCache.h"
#import "NSString+HMHash.h"

#define kSDMaxCacheFileAmount 100

@implementation NSData (HMDataCache)

+ (NSString *)cachePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"Caches"];
    path = [path stringByAppendingPathComponent:@"HMDataCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)creatDataPathWithString:(NSString *)string
{
    NSString *path = [NSData cachePath];
    path = [path stringByAppendingPathComponent:[string md5]];
    return path;
}

-(void)saveDataCacheWithIdentifier:(NSString *)identifier
{
    NSString *path = [NSData creatDataPathWithString:identifier];
    [self writeToFile:path atomically:YES];
}

+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier
{
    static BOOL isCheckedCacheDisk = NO;
    if (!isCheckedCacheDisk)
    {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *contents = [manager contentsOfDirectoryAtPath:[self cachePath] error:nil];
        if (contents.count >= kSDMaxCacheFileAmount)
        {
            [manager removeItemAtPath:[self cachePath] error:nil];
        }
        isCheckedCacheDisk = YES;
    }
    NSString *path = [self creatDataPathWithString:identifier];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (void)clearCache
{
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:[self cachePath] error:nil];
}

@end
