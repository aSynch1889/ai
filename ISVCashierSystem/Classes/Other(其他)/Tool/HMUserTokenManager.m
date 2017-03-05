//
//  HMUserDataManager.m
//  HealthMall
//
//  Created by jkl on 15/11/2.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMUserTokenManager.h"
#import "HMKeyChain.h"

@implementation HMUserTokenManager

static NSString * const KEY_IN_KEYCHAIN = @"tv.healthmall.app.info";
static NSString * const KEY_IN_TOKEN = @"tv.healthmall.app.token";

+(void)saveToken:(NSString *)token
{    
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:token forKey:KEY_IN_TOKEN];
    [HMKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+(id)readToken
{
    NSMutableDictionary *token = (NSMutableDictionary *)[HMKeyChain load:KEY_IN_KEYCHAIN];
    if (token == nil) {
        return kDefaultKey;
    }
    return token[KEY_IN_TOKEN];
}

+(void)deleteToken
{
    [HMKeyChain delete:KEY_IN_KEYCHAIN];
}

@end
