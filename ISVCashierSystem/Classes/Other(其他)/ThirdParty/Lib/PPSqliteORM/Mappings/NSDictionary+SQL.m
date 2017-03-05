//
//  NSDictionary+SQL.m
//  PPSqliteORM
//
//  Created by StarNet on 12/22/14.
//  Copyright (c) 2014 StarNet. All rights reserved.
//

#import "NSDictionary+SQL.h"
#import "NSObject+PPSqliteORM.h"

@implementation NSDictionary (SQL)
- (NSString* )sqlValue {
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [str sqlValue];
}

+ (id)objectForSQL:(NSString* )sql objectType:(NSString* )type {
    if (!sql) return nil;
    NSData *data = [sql dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

}
@end
