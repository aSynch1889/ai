//
//  HMTimerLabel.m
//  HealthMall
//
//  Created by qiuwei on 16/1/1.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "HMTimerLabel.h"

@interface HMTimerLabel ()
{
    int _leftSecondsInterval; // 剩余时间（秒）
}
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HMTimerLabel

- (void)dealloc{
    [self removeTimer];
}

- (instancetype)init
{
    if (self = [super init]) {
        _timerS = kCoachOrderDetailByAppointSecondsInterval;
        _delay = 1.0;
    }
    return self;
}

// 停止定时器
- (void)topTimer
{
    [self removeTimer];
}

// 结束定时
- (void)endTimer
{
    [self setTimerS:0];
}


#pragma mark - Event
- (void)updateTimeEvent
{
    _leftSecondsInterval--;

    if (_leftSecondsInterval >= 0) {// 继续更新提示
        if ([self.delegate respondsToSelector:@selector(timeUpdateWithTimerLabel:leftTimeInterval:)]) {
            [self.delegate timeUpdateWithTimerLabel:self leftTimeInterval:_leftSecondsInterval];
        }
    }else{// 停止更新，停止定时器
        
        [self removeTimer];
        
        if ([self.delegate respondsToSelector:@selector(timeoutWithTimerLabel:)]) {
            [self.delegate timeoutWithTimerLabel:self];
        }
    }
}

#pragma mark - setter/getter
- (void)setStartDate:(NSDate *)startDate
{
    _startDate = startDate;
    
    if(!startDate) return;
    
    NSDate *cutrrenDate = self.currentDate;
    if (cutrrenDate == nil)
    {
        cutrrenDate = [NSDate date];
    }
    
    NSTimeInterval secondsInterval = [cutrrenDate timeIntervalSinceDate:startDate];
    
    // 剩余时间（秒）
    _leftSecondsInterval = _timerS - (int)secondsInterval - 1;
    
    // 计时中
    if(_leftSecondsInterval >= 0){
        [self addTimer];
    }else{
        [self removeTimer];
        
        if ([self.delegate respondsToSelector:@selector(timeoutWithTimerLabel:)]) {
            [self.delegate timeoutWithTimerLabel:self];
        }
    }
}

- (void)setTimerS:(NSTimeInterval)timerS
{
    _timerS = timerS;

    if (self.startDate) {
        [self setStartDate:self.startDate];
    }
}

- (void)addTimer
{
    if (self.delay == 0) {
        self.delay = 1;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.delay target:self selector:@selector(updateTimeEvent) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
@end
