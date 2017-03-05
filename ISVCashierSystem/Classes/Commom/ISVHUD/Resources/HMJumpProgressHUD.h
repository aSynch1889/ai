//
//  HMJumpProgressHUD.h
//  加载动画
//
//  Created by jkl on 15/12/8.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMJumpProgressHUD : UIView

- (void)beginJump;

- (void)stopWithBlock:(void (^)())block;

@end
