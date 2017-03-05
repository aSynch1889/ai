//
//  HMPayWayModel.m
//  HealthMall
//
//  Created by qiuwei on 16/1/22.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "HMPayWayModel.h"

@implementation HMPayWayModel

// 映射表，{“本地”：“服务器”}， 使用MJExtension时有效
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"hm_p_id",
             @"name" : @"hm_p_name",
             @"iconUrl" : @"hm_p_icon",
             @"enable" : @"hm_p_enable",
             @"sort" : @"hm_p_sort",
             };
    
}
@end
