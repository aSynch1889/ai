//
//  NSData+ISVDataCache.h
//  ISV
//
//  Created by aaaa on 17/03/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ISVDataCache)

- (void)saveDataCacheWithIdentifier:(NSString *)identifier;

+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier;

+ (void)clearCache;

@end
