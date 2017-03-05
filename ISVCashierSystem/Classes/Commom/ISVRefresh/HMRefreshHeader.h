//
//  HMRefreshHeader.h
//  HealthMall
//
//  Created by qiuwei on 16/2/23.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@class MJRefreshGifHeader;

@interface HMRefreshHeader : NSObject

/**
 *  刷新带动画
 */
+ (MJRefreshGifHeader *)headerWithTarget:(id)target refreshingAction:(SEL)action;

@end
