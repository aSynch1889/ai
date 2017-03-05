//
//  ISVMenuConfiguration.h
//  test
//
//  Created by ISV005 on 15/12/2.
//  Copyright © 2017年 ISV005. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ISVMenuConfiguration : NSObject
//Menu width 宽度
+ (float)menuWidth;

//Menu item height 高度
+ (float)itemCellHeight;

//Animation duration of menu appearence 动画持续时间
+ (float)animationDuration;

//Menu substrate alpha value 背景透明度
+ (float)backgroundAlpha;

//Menu alpha value 菜单透明度
+ (float)menuAlpha;

//Value of bounce
+ (float)bounceOffset;

//Arrow image near title 下拉三角图标
+ (UIImage *)arrowImage;

//Distance between Title and arrow image 菜单标题和三角图标间距
+ (float)arrowPadding;

//Items color in menu cell颜色
+ (UIColor *)itemsColor;

//Menu color 菜单颜色
+ (UIColor *)mainColor;

//Item selection animation speed
+ (float)selectionSpeed;

//Menu item text color cell标题文本颜色
+ (UIColor *)itemTextColor;
@end
