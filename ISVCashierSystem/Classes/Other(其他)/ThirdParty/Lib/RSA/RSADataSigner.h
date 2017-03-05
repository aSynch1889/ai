//
//  RSADataSigner.h
//  HealthMall
//
//  Created by qiuwei on 15/12/21.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const PrivateKey = @"MIICXgIBAAKBgQDAIinxzq7wEx9fEKjQ1xez0U/58l7ebLntaVHOdkNhhwFjOTZBozmomKLf8G5oTL+BjM+DiHVjxbxKs1uES2SSKNTx59qw5UGsowbRPcI6XzcHMsbLD3CvFdStQ+ilj4zALK+Nwgs1510bRvQE9PYX2+pamAmgMhuNZ2C8oMabaQIDAQABAoGBAJK7xLLieSHqSMQuke7kxjpTObQW0TMncBuLmqmGElGybHHd6LzaLpe+8mz6TyeirYMACh9XIOfwxKt8LQFtHsFYzDLdbCQgatWNtfgspdQ3D5tUG82yHb5hRKkwnSNXEGXnFafLmgRCMs4BPBwX9uV/NpE4bnPLXSOAlomAwbWBAkEA9FHIcWJlSXU3Bgt5lTOO+tNfnHNEdOH6m5OKbT/cplVLe+kQAI0mg6ZTnArjOunUL70icfafKgREbfWmhCZVcQJBAMlRrZw42pg38Q5C52f/nWYOv0uyH+zFLMWmt+w8pfc80kdCeBUMaQzw/YFwfifWNs2fMzaFGnvUH59nLZ97SXkCQQDLyQtvx6rEQsjKeffHw2GXRYeSb3LCK1tlOQNVbNcWxj5X9GYsj494b9t9ZHd0RGWADDoW5KaN3VFWhneF8pOBAkATzqV2KWHYeCiPbqW15cBmuiy4Fd5uPTgaejy+UXlCygkmWbPW3lG3pD5M7fR7luftcyxmwNHKPSSfWldyyX6BAkEAw9w6rB8OWV6qwWJ4OFZ/cRLJO+aZqNVGDMx9s1Y8LTXCG6bHIqYOlijnhpLhkFuD6zf6S7lddg+hvNF5AjAC1A==";
static NSString * const PublicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDAIinxzq7wEx9fEKjQ1xez0U/58l7ebLntaVHOdkNhhwFjOTZBozmomKLf8G5oTL+BjM+DiHVjxbxKs1uES2SSKNTx59qw5UGsowbRPcI6XzcHMsbLD3CvFdStQ+ilj4zALK+Nwgs1510bRvQE9PYX2+pamAmgMhuNZ2C8oMabaQIDAQAB";


@interface RSADataSigner : NSObject

///**
// *  加密
// *  @param string     加密内容
// *  @param privateKey 公钥
// */
//- (NSString *)encryptByRsa:(NSString*)string publicKey:(NSString *)publicKey;
/**
 *  签名
 *  @param string     签名内容
 *  @param privateKey 私钥
 */
+ (NSString *)signString:(NSString *)string privateKey:(NSString *)privateKey;

@end
