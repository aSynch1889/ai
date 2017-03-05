//
//  SCRSA.h
//  SCRSA
//
//  Created by silentcloud on 14-4-15.
//  Copyright (c) 2014年 silentcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <openssl/rsa.h>
#include <openssl/pem.h>
#include <openssl/err.h>

typedef enum {
    KeyTypePublic,
    KeyTypePrivate
}KeyType;

typedef enum {
    RSA_PADDING_TYPE_NONE       = RSA_NO_PADDING,
    RSA_PADDING_TYPE_PKCS1      = RSA_PKCS1_PADDING,
    RSA_PADDING_TYPE_SSLV23     = RSA_SSLV23_PADDING
}RSA_PADDING_TYPE;

@interface SCRSA : NSObject

- (id)initWithKeyContent:(NSString *)keyContent keyType:(KeyType)keyType;

- (NSString *) encryptByRsa:(NSString*)content;
- (NSString *) decryptByRsa:(NSString*)content;

@end
