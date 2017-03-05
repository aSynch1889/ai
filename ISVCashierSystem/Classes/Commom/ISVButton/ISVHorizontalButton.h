//
//  ISVHorizontalButton.h
//  ISV
//
//  Created by aaaa on 15/10/31.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

// 自定义横向按钮（如果需要设置间距就设置EdgeInsets）
@interface ISVHorizontalButton : UIButton

@property (nonatomic, assign) BOOL isTitleAtLeft;   // 是否标题在左边（默认是）
@property (nonatomic, assign) CGFloat margin;

+ (instancetype)buttonwithImageName:(NSString *)imageName title:(NSString *)title;

+ (instancetype)buttonwithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName title:(NSString *)title;

+ (instancetype)buttonwithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title;
@end
