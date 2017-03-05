//
//  HMRefreshConstant.h
//  HealthMall
//
//  Created by qiuwei on 16/2/23.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#ifndef HMRefreshConstant_h
#define HMRefreshConstant_h

#define kRefresh_icon_up_1 [UIImage imageNamed:@"refresh_icon_healthmall_up_1"]
#define kRefresh_icon_up_2 [UIImage imageNamed:@"refresh_icon_healthmall_up_2"]
#define kRefresh_icon_nor [UIImage imageNamed:@"refresh_icon_healthmall_nor"]
#define kRefresh_icon_flat_1 [UIImage imageNamed:@"refresh_icon_healthmall_flat_1"]
#define kRefresh_icon_flat_2 [UIImage imageNamed:@"refresh_icon_healthmall_flat_2"]

#define kIdleImages @[kRefresh_icon_nor] // 普通状态的动画图片
#define kPullingImages @[kRefresh_icon_nor] // 即将刷新状态的动画图片（一松开就会刷新的状态）
#define kRefreshingImages @[kRefresh_icon_up_1, kRefresh_icon_up_2, kRefresh_icon_nor, kRefresh_icon_flat_1, kRefresh_icon_flat_2, kRefresh_icon_flat_1, kRefresh_icon_nor, kRefresh_icon_flat_1] // 正在刷新状态的动画图片

#endif /* HMRefreshConstant_h */
