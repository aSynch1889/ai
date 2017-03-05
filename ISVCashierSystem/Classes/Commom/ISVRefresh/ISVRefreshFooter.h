//
//  ISVRefreshFooter.h
//  ISV
//
//  Created by aaaa on 16/2/23.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@class MJRefreshAutoGifFooter;

@interface ISVRefreshFooter : NSObject

/**
 *  底部加载带动画
 */
+ (MJRefreshAutoGifFooter *)footerWithTarget:(id)target refreshingAction:(SEL)action;


@end
