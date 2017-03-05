//
//  ISVSwitch.m
//  ISV
//
//  Created by aaaa on 15/11/17.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVSwitch.h"

@implementation ISVSwitch

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
