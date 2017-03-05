//
//  HMCoverButton.h
//  HealthMall
//
//  Created by jkl on 15/11/19.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

/******* 透明按钮, 点击高亮 *******/
@interface HMCoverButton : UIButton
@property (nonatomic, strong) UIColor *highlightedColor;

+ (instancetype)coverButtonWithFrame:(CGRect)frame;

@end
