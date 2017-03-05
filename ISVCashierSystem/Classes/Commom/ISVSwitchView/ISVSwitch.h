//
//  ISVSwitch.h
//  ISV
//
//  Created by aaaa on 15/11/17.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISVSwitch : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *selectedIconName;


+ (instancetype)switchWithTitle:(NSString *)title iconName:(NSString *)iconName;
+ (instancetype)switchWithTitle:(NSString *)title iconName:(NSString *)iconName selectedIconName:(NSString *)selectedIconName;

@end
