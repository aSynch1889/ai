//
//  NSDictionary+ISVJoining.h
//  ISV
//
//  Created by aaaa on 15/11/7.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

/****用于拼接get网络请求的参数*****/
@interface NSDictionary (ISVJoining)

- (NSString *)joiningKeysAndValues;

@end
