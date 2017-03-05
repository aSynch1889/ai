//
//  NSDictionary+ChangeNull.m
//  HealthMall
//
//  Created by xmfish on 14-9-19.
//  Copyright (c) 2015年 Jinzhai Nature Health Technology Co.,Ltd. All rights reserved.
//

#import "NSDictionary+ChangeNull.h"

@implementation NSDictionary (ChangeNull)

// 改变对象的值，不能为空
- (nonnull id)objectForKeyWithoutNull:(nonnull id)aKey
{
    id result = [self objectForKey:aKey];
    if (!result || [result isKindOfClass:[NSNull class]]) {
        result = @"";
        return result;
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        return [result stringValue];
    }
    if ([result isKindOfClass:[NSDictionary class]] || [result isKindOfClass:[NSArray class]]) {
        return result;
    }
    
    return result;
}

// 改变对象的值，可为空或为0
- (nullable id)objectForKeyCanNull:(nonnull id)aKey
{
    id result = [self objectForKey:aKey];
    if (!result || [result isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if ([result isKindOfClass:[NSDictionary class]] || [result isKindOfClass:[NSArray class]]) {
        if ([result count] == 0) {
            return nil;
        }
        return result;
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        if ([result isEqual: @0]) {
            return nil;
        }
    }
    return result;
}
@end
