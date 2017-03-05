//
//  NSString+HMDistance.h
//  HealthMall
//
//  Created by jkl on 15/11/27.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HMDistance)

/**
 * 小于1000m的，显示为xxxm，比如200m；超过1000m显示为xkm，比如2.8km，保留1位小数
 */
- (NSString *)distance;

@end
