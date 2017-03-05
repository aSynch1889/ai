//
//  HMRefreshFooter.h
//  HealthMall
//
//  Created by qiuwei on 16/2/23.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@class MJRefreshAutoGifFooter;

@interface HMRefreshFooter : NSObject

/**
 *  底部加载带动画
 */
+ (MJRefreshAutoGifFooter *)footerWithTarget:(id)target refreshingAction:(SEL)action;


@end
