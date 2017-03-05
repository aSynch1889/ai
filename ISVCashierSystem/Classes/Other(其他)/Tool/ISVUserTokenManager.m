//
//  ISVUserDataManager.m
//  ISV
//
//  Created by aaaa on 15/11/2.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVUserTokenManager.h"
#import "ISVKeyChain.h"

@implementation ISVUserTokenManager

static NSString * const KEY_IN_KEYCHAIN = @"tv.ISV.app.info";
static NSString * const KEY_IN_TOKEN = @"tv.ISV.app.token";

+(void)saveToken:(NSString *)token
{    
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:token forKey:KEY_IN_TOKEN];
    [ISVKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+(id)readToken
{
    NSMutableDictionary *token = (NSMutableDictionary *)[ISVKeyChain load:KEY_IN_KEYCHAIN];
    if (token == nil) {
        return kDefaultKey;
    }
    return token[KEY_IN_TOKEN];
}

+(void)deleteToken
{
    [ISVKeyChain delete:KEY_IN_KEYCHAIN];
}

@end
