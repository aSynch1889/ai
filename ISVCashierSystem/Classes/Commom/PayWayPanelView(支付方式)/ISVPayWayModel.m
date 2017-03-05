//
//  ISVPayWayModel.m
//  ISV
//
//  Created by aaaa on 16/1/22.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "ISVPayWayModel.h"

@implementation ISVPayWayModel

// 映射表，{“本地”：“服务器”}， 使用MJExtension时有效
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"ISV_p_id",
             @"name" : @"ISV_p_name",
             @"iconUrl" : @"ISV_p_icon",
             @"enable" : @"ISV_p_enable",
             @"sort" : @"ISV_p_sort",
             };
    
}
@end
