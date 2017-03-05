//
//  HMSwitch.h
//  HealthMall
//
//  Created by qiuwei on 15/11/17.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSwitch : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *selectedIconName;


+ (instancetype)switchWithTitle:(NSString *)title iconName:(NSString *)iconName;
+ (instancetype)switchWithTitle:(NSString *)title iconName:(NSString *)iconName selectedIconName:(NSString *)selectedIconName;

@end
