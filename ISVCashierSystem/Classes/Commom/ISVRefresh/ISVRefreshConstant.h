//
//  ISVRefreshConstant.h
//  ISV
//
//  Created by aaaa on 16/2/23.
//  Copyright © 2016年 ISV. All rights reserved.
//

#ifndef ISVRefreshConstant_h
#define ISVRefreshConstant_h

#define kRefresh_icon_up_1 [UIImage imageNamed:@"refresh_icon_ISV_up_1"]
#define kRefresh_icon_up_2 [UIImage imageNamed:@"refresh_icon_ISV_up_2"]
#define kRefresh_icon_nor [UIImage imageNamed:@"refresh_icon_ISV_nor"]
#define kRefresh_icon_flat_1 [UIImage imageNamed:@"refresh_icon_ISV_flat_1"]
#define kRefresh_icon_flat_2 [UIImage imageNamed:@"refresh_icon_ISV_flat_2"]

#define kIdleImages @[kRefresh_icon_nor] // 普通状态的动画图片
#define kPullingImages @[kRefresh_icon_nor] // 即将刷新状态的动画图片（一松开就会刷新的状态）
#define kRefreshingImages @[kRefresh_icon_up_1, kRefresh_icon_up_2, kRefresh_icon_nor, kRefresh_icon_flat_1, kRefresh_icon_flat_2, kRefresh_icon_flat_1, kRefresh_icon_nor, kRefresh_icon_flat_1] // 正在刷新状态的动画图片

#endif /* ISVRefreshConstant_h */
