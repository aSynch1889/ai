//
//  ISVCoverButton.h
//  ISV
//
//  Created by aaaa on 15/11/19.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

/******* 透明按钮, 点击高亮 *******/
@interface ISVCoverButton : UIButton
@property (nonatomic, strong) UIColor *highlightedColor;

+ (instancetype)coverButtonWithFrame:(CGRect)frame;

@end
