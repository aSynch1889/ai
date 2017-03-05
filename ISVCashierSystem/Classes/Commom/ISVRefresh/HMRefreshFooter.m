//
//  HMRefreshFooter.m
//  HealthMall
//
//  Created by qiuwei on 16/2/23.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "HMRefreshFooter.h"
#import "MJRefreshAutoGifFooter.h"
#import "HMRefreshConstant.h"

@implementation HMRefreshFooter

/**
 *  底部加载带动画
 */
+ (MJRefreshAutoGifFooter *)footerWithTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:target refreshingAction:action];
    
    // 设置刷新图片
    [footer setImages:kRefreshingImages forState:MJRefreshStateRefreshing];
    
    return footer;

}

@end
