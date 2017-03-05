//
//  UIControl+ISVPreventRepeatClick.h
//  test
//
//  Created by aaaa on 15/11/5.
//  Copyright © 2015年 qiuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  防止重复点击扩展
 *  testBtn.pr_acceptEventInterval = 1.0; (1秒内不允许再点击)
 */
@interface UIControl (ISVPreventRepeatClick)

@property (nonatomic, assign) NSTimeInterval pr_acceptEventInterval;// 可以用这个给重复点击加间隔
@property (nonatomic, assign) BOOL           pr_ignoreEvent;

@end
