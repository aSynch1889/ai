//
//  NSArray+SQL.m
//  PPSqliteORM
//
//  Created by StarNet on 8/25/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "NSArray+SQL.h"
#import "NSObject+PPSqliteORM.h"

@implementation NSArray (SQL)

- (NSString* )sqlValue {
    
//    return [[self JSONString] sqlValue];
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [str sqlValue];
}

+ (id)objectForSQL:(NSString* )sql objectType:(NSString* )type {
    if (!sql) return nil;
//    return [sql objectFromJSONString];
    NSData *data = [sql dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}

@end
