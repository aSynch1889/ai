//
//  HMUserDataManager.h
//  HealthMall
//
//  Created by jkl on 15/11/2.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMUserTokenManager : NSObject

/**
 * `存储令牌`
 */
+(void)saveToken:(NSString *)token;

/**
 *  `读取令牌`
 */
+(id)readToken;

/**
 *  `删除令牌数据`
 */
+(void)deleteToken;

@end
