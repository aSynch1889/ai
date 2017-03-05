//
//  ISVMenuButton.h
//  test
//
//  Created by ISV005 on 15/12/2.
//  Copyright © 2017年 ISV005. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISVMenuButton : UIControl

@property (nonatomic, unsafe_unretained) BOOL isActive;
@property (nonatomic) CGGradientRef spotlightGradientRef;
@property (unsafe_unretained) CGFloat spotlightStartRadius;
@property (unsafe_unretained) float spotlightEndRadius;
@property (unsafe_unretained) CGPoint spotlightCenter;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *arrow;

- (UIImageView *)defaultGradient;

@end
