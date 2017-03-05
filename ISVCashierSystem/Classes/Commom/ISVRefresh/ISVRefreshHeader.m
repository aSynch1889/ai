//
//  ISVRefreshHeader.m
//  ISV
//
//  Created by aaaa on 16/2/23.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "ISVRefreshHeader.h"
#import "MJRefreshGifHeader.h"
#import "ISVRefreshConstant.h"

@implementation ISVRefreshHeader

/**
 *  刷新带动画
 */
+ (MJRefreshGifHeader *)headerWithTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
    
    // 设置普通状态的动画图片
    [header setImages:kIdleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:kPullingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:kRefreshingImages duration:0.5 forState:MJRefreshStateRefreshing];
    
    return header;
}

@end
