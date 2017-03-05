//
//  NSDictionary+HMJoining.h
//  HealthMall
//
//  Created by jkl on 15/11/7.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

/****用于拼接get网络请求的参数*****/
@interface NSDictionary (HMJoining)

- (NSString *)joiningKeysAndValues;

@end
