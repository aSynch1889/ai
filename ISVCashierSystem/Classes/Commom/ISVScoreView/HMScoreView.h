//
//  HMScoreView.h
//  HealthMall
//
//  Created by jkl on 15/11/27.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

/********** 评分五角星 ************/
@interface HMScoreView : UIView
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) CGFloat score;
/// 是否是大号的(默认NO)
@property (nonatomic, assign, getter=isLarge) BOOL large;

/**
 * `评分五角星`
 * point: x,y(width和height无需设定, 分别为固定值W:58, H:10)
 * score: 分数, 取值范围 0.0~5.0
 */
+ (instancetype)scoreViewWithPoint:(CGPoint)point score:(CGFloat)score;


/**
 * `评分五角星`
 * point: x,y(width和height无需设定, 分别为固定值W:58, H:10)
 */
+ (instancetype)scoreViewWithPoint:(CGPoint)point;


/**
 * `设置point`
 * width和height无需设定
 */
- (void)setPointWithX:(CGFloat)x andY:(CGFloat)y;


/**
 * `添加点击五角星事件`
 */
- (void)addTarget:(id)target actionForTouchUpInside:(SEL)action;

@end

