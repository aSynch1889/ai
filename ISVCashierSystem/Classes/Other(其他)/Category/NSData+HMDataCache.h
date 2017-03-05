//
//  NSData+HMDataCache.h
//  HealthMall
//
//  Created by jkl on 15/11/4.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HMDataCache)

- (void)saveDataCacheWithIdentifier:(NSString *)identifier;

+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier;

+ (void)clearCache;

@end
