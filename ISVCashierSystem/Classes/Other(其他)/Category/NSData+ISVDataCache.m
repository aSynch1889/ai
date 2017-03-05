//
//  NSData+ISVDataCache.m
//  ISV
//
//  Created by aaaa on 17/03/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "NSData+ISVDataCache.h"
#import "NSString+ISVHash.h"

#define kSDMaxCacheFileAmount 100

@implementation NSData (ISVDataCache)

+ (NSString *)cachePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"Caches"];
    path = [path stringByAppendingPathComponent:@"ISVDataCache"];
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
