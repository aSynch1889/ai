//
//  ISVTimerLabel.h
//  ISV
//
//  Created by aaaa on 16/1/1.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISVTimerLabel;

@protocol ISVTimerLabelDelegate <NSObject>

@optional

/**
 *  更新时间
 *  @param leftTimeInterval 剩下的时间
 */
- (void)timeUpdateWithTimerLabel:(ISVTimerLabel *)timerLabel leftTimeInterval:(NSTimeInterval)leftTimeInterval;
/**
 *  倒计时完毕调用
 */
- (void)timeoutWithTimerLabel:(ISVTimerLabel *)timerLabel;

@end;

@interface ISVTimerLabel : UILabel

@property (nonatomic, strong) NSDate *startDate;        // 开始时间
/// 当前时间
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, assign) NSTimeInterval timerS;    // 定时长度（秒）默认600秒
@property (nonatomic, assign) NSTimeInterval delay;     // 定时间隔（秒）默认1.0
@property (nonatomic, weak) id<ISVTimerLabelDelegate> delegate;


/**
 *  停止定时器
 */
- (void)topTimer;

/**
 *  结束定时（会调用timeoutWithTimerLabel:）
 */
- (void)endTimer;

@end
