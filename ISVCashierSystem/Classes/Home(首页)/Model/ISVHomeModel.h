//
//  ISVHomeModel.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/3.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISVHomeModel : NSObject
//首页接收数据的模型
@property(nonatomic, copy)NSString *dayAmount;//!< 今日
@property(nonatomic, copy)NSString *weekAmount;//!< 本周
@property(nonatomic, copy)NSString *monthAmount;//!< 本月

@property(nonatomic, copy)NSString *dayPerAmount;//!< 今日同比
@property(nonatomic, copy)NSString *weekPerAmount;//!< 本周同比
@property(nonatomic, copy)NSString *monthPerAmount;//!< 本月同比

@end
