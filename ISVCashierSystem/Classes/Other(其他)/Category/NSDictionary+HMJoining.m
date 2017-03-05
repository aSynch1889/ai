//
//  NSDictionary+HMJoining.m
//  HealthMall
//
//  Created by jkl on 15/11/7.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "NSDictionary+HMJoining.h"
#import "HMNetworking.h"


@implementation NSDictionary (HMJoining)

- (NSString *)joiningKeysAndValues
{
    NSMutableString *str = [NSMutableString string];
    for (NSString *key in self)
    {
        if (![self[key] isEqualToString:HM_NULL])
        {
            [str appendFormat:@"%@=%@&", key, self[key]];
        }
    }
    [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
    return [str copy];
}

@end
