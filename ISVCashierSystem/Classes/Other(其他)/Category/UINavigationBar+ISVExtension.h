//
//  UINavigationBar+ISVExtension.h
//  ISV
//
//  Created by ISV005 on 17/3/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ISVExtension)
- (void)ISV_setBackgroundColor:(UIColor *)backgroundColor;
- (void)ISV_setElementsAlpha:(CGFloat)alpha;
- (void)ISV_setTranslationY:(CGFloat)translationY;
- (void)ISV_reset;
@end
