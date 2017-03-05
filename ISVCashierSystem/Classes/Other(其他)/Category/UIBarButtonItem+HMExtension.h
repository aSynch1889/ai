//
//  UIBarButtonItem+HMExtension.h
//  HealthMall
//
//  Created by qiuwei on 15/10/31.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HMExtension)

+ (instancetype)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

+ (instancetype)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName title:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  返回按钮
 */
+ (instancetype)backBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
