//
//  UINavigationBar+HMExtension.h
//  HealthMall
//
//  Created by healthmall005 on 15/11/6.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (HMExtension)
- (void)hm_setBackgroundColor:(UIColor *)backgroundColor;
- (void)hm_setElementsAlpha:(CGFloat)alpha;
- (void)hm_setTranslationY:(CGFloat)translationY;
- (void)hm_reset;
@end
