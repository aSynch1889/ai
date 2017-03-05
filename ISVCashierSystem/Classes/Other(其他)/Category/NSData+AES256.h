//
//  NSData+AES256.h
//  HealthMall
//
//  Created by 健康猫技术 on 16/1/28.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end
