//
//  ISVRefreshHeader.h
//  ISV
//
//  Created by aaaa on 16/2/23.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@class MJRefreshGifHeader;

@interface ISVRefreshHeader : NSObject

/**
 *  刷新带动画
 */
+ (MJRefreshGifHeader *)headerWithTarget:(id)target refreshingAction:(SEL)action;

@end
