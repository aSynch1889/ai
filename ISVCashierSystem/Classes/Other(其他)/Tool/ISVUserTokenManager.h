//
//  ISVUserDataManager.h
//  ISV
//
//  Created by aaaa on 15/11/2.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISVUserTokenManager : NSObject

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
