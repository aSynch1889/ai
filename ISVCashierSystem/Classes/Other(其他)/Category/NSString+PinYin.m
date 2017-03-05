//
//  NSString+PinYin.m
//  HealthMall
//
//  Created by jkl on 16/1/10.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "NSString+PinYin.h"

@implementation NSString (PinYin)

- (NSString *)pinyin
{
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL,
                      kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL,
                      kCFStringTransformStripDiacritics, false);
    return mutableString;
}

@end
