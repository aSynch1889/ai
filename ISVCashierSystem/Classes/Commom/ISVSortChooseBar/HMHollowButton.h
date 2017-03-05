//
//  HMHollowButton.h
//  HealthMall
//
//  Created by jkl on 15/12/14.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMHollowButton : UIButton
@property (nonatomic, strong) UIColor *themeColor;// 主颜色

+ (instancetype)hollowButtonWithTitle:(NSString *)title frame:(CGRect)frame;

@end
