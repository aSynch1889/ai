//
//  ISVRefreshFooter.m
//  ISV
//
//  Created by aaaa on 16/2/23.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "ISVRefreshFooter.h"
#import "MJRefreshAutoGifFooter.h"
#import "ISVRefreshConstant.h"

@implementation ISVRefreshFooter

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
