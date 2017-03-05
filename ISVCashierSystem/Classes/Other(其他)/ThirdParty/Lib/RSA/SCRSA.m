//
//  CRSA.m
//  CRSA
//
//  Created by silentcloud on 14-4-15.
//  Copyright (c) 2014年 silentcloud. All rights reserved.
//

#import "SCRSA.h"
#import "Base64.h"

#define BUFFSIZE  1024
#define PADDING RSA_PADDING_TYPE_PKCS1

@interface SCRSA()
{
    RSA *_rsa;
}
@property (nonatomic, copy) NSString *keyContent;
@property (nonatomic, assign) KeyType keyType;
@end

@implementation SCRSA

- (id)initWithKeyContent:(NSString *)keyContent keyType:(KeyType)keyType
{
    if (self = [super init]) {
        self.keyContent = [keyContent copy];
        self.keyType = keyType;
    }
    return self;
}

- (BOOL)importRSAKeyWithType:(KeyType)type
{
    NSString *keyName = type == KeyTypePublic ? @"rsa_public_key.pem" : @"pkcs8_rsa_private_key.pem";
    [self createKeyFileWithContent:self.keyContent fileName:keyName];
    
    FILE *file;
    NSString *keyPath = [self keyFilePath:keyName];
    
    file = fopen([keyPath UTF8String], "rb");
    
    if (NULL != file)
    {
        if (type == KeyTypePublic)
        {
            _rsa = PEM_read_RSA_PUBKEY(file, NULL, NULL, NULL);
            assert(_rsa != NULL);
        }
        else
        {
            _rsa = PEM_read_RSAPrivateKey(file, NULL, NULL, NULL);
            assert(_rsa != NULL);
        }
        
        fclose(file);
        
        [self deleteKeyFileWithFileName:keyName];
        
        return (_rsa != NULL) ? YES : NO;
    }
    
    return NO;
}

- (NSString *)getDocumentDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];//去处需要的路径
}

- (NSString *)keyFilePath:(NSString *)fileName
{
    NSString *documentsDirectory = [self getDocumentDir];
    NSString *keyPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    return keyPath;
}

- (void)createKeyFileWithContent:(NSString *)keyContent fileName:(NSString *)fileName
{
    NSString *keyPath = [self keyFilePath:fileName];
    [keyContent writeToFile:keyPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)deleteKeyFileWithFileName:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[self keyFilePath:fileName] error:nil];
}

- (NSString *)encryptByRsa:(NSString*)content
{
    if (![self importRSAKeyWithType:self.keyType]){
        return nil;
    }
    int status;
    int length  = [content length];
    unsigned char input[length + 1];
    bzero(input, length + 1);
    int i = 0;
    for (; i < length; i++)
    {
        input[i] = [content characterAtIndex:i];
    }
    
    NSInteger  flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING];
    
    char *encData = (char*)malloc(flen);
    bzero(encData, flen);
    
    switch (self.keyType) {
        case KeyTypePublic:
            status = RSA_public_encrypt(length, (unsigned char*)input, (unsigned char*)encData, _rsa, PADDING);
            break;
            
        default:
            status = RSA_private_encrypt(length, (unsigned char*)input, (unsigned char*)encData, _rsa, PADDING);
            break;
    }
    
    if (status)
    {
        NSData *returnData = [NSData dataWithBytes:encData length:status];
        free(encData);
        encData = NULL;
        
        NSString *ret = [returnData base64EncodedString];
        return ret;
    }
    
    free(encData);
    encData = NULL;
    
    return nil;
}

- (NSString *)decryptByRsa:(NSString*)content
{
    if (![self importRSAKeyWithType:self.keyType])
        return nil;
    
    int status;
    
    NSData *data = [content base64DecodedData];
    int length = [data length];
    
    NSInteger flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING];
    char *decData = (char*)malloc(flen);
    bzero(decData, flen);
    
    switch (self.keyType) {
        case KeyTypePublic:
            status = RSA_public_decrypt(length, (unsigned char*)[data bytes], (unsigned char*)decData, _rsa, PADDING);
            break;
            
        default:
            status = RSA_private_decrypt(length, (unsigned char*)[data bytes], (unsigned char*)decData, _rsa, PADDING);
            break;
    }
    
    if (status)
    {
        NSMutableString *decryptString = [[NSMutableString alloc] initWithBytes:decData length:strlen(decData) encoding:NSASCIIStringEncoding];
        free(decData);
        decData = NULL;
        
        return decryptString;
    }
    
    free(decData);
    decData = NULL;
    
    return nil;
}

- (int)getBlockSizeWithRSA_PADDING_TYPE:(RSA_PADDING_TYPE)padding_type
{
    int len = RSA_size(_rsa);
    
    if (padding_type == RSA_PADDING_TYPE_PKCS1 || padding_type == RSA_PADDING_TYPE_SSLV23) {
        len -= 11;
    }
    
    return len;
}

@end
