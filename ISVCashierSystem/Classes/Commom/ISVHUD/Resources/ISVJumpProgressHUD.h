//
//  ISVJumpProgressHUD.h
//  加载动画
//
//  Created by aaaa on 15/12/8.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISVJumpProgressHUD : UIView

- (void)beginJump;

- (void)stopWithBlock:(void (^)())block;

@end
