//
//  ISVPayWayModel.h
//  ISV
//
//  Created by aaaa on 16/1/22.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISVPayWayModel : NSObject
@property (nonatomic, assign) NSUInteger ID;   // 支付ID
@property (nonatomic, copy) NSString *name; // 支付名称
@property (nonatomic, copy) NSString *iconUrl;// 图标路径
@property (nonatomic, assign) BOOL enable;  // 是否可用，1：可用，0：不可用
@property (nonatomic, assign) NSUInteger sort;// 排序标识

@property (nonatomic, assign, getter=isCheck) BOOL check;
@end
