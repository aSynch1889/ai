//
//  HMStarRatingView.h
//  HealthMall
//
//  Created by healthmall005 on 15/12/3.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMStarRatingView;
@protocol HMStarRatingViewDelegate<NSObject>
@optional
- (void)starRateView:(HMStarRatingView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface HMStarRatingView : UIView
@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO

@property (nonatomic, weak) id<HMStarRatingViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;
@end
