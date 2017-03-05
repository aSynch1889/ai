//
//  NSString+HMHash.h
//  HealthMall
//
//  Created by jkl on 15/10/31.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HMHash)
- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString *)sha512;
@end
