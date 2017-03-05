//
//  HMSwitch.m
//  HealthMall
//
//  Created by qiuwei on 15/11/17.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMSwitch.h"

@implementation HMSwitch

- (instancetype)initWithTitle:(NSString *)title iconName:(NSString *)iconName selectedIconName:(NSString *)selectedIconName
{
    if (self = [super init]) {
        self.title = title;
        self.iconName = iconName;
        self.selectedIconName = selectedIconName;
    }
    return self;
}

+ (instancetype)switchWithTitle:(NSString *)title iconName:(NSString *)iconName
{
    return [[self alloc] initWithTitle:title iconName:iconName selectedIconName:nil];
}

+ (instancetype)switchWithTitle:(NSString *)title iconName:(NSString *)iconName selectedIconName:(NSString *)selectedIconName
{
    return [[self alloc] initWithTitle:title iconName:iconName selectedIconName:selectedIconName];
}
@end
