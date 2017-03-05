//
//  ISVStarRatingView.h
//  ISV
//
//  Created by ISV005 on 15/12/3.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISVStarRatingView;
@protocol ISVStarRatingViewDelegate<NSObject>
@optional
- (void)starRateView:(ISVStarRatingView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface ISVStarRatingView : UIView
@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO

@property (nonatomic, weak) id<ISVStarRatingViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;
@end
