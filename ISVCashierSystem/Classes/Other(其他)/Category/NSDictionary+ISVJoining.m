//
//  NSDictionary+ISVJoining.m
//  ISV
//
//  Created by aaaa on 15/11/7.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "NSDictionary+ISVJoining.h"
#import "ISVNetworking.h"


@implementation NSDictionary (ISVJoining)

- (NSString *)joiningKeysAndValues
{
    NSMutableString *str = [NSMutableString string];
    for (NSString *key in self)
    {
        if (![self[key] isEqualToString:ISV_NULL])
        {
            [str appendFormat:@"%@=%@&", key, self[key]];
        }
    }
    [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
    return [str copy];
}

@end
