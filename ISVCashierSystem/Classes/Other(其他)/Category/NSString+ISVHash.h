//
//  NSString+ISVHash.h
//  ISV
//
//  Created by aaaa on 15/10/31.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ISVHash)
- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString *)sha512;
@end
