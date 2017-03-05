//
//  NSString+HMOrderStatus.m
//  HealthMall
//
//  Created by healthmall005 on 16/1/4.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "NSString+HMOrderStatus.h"

@implementation NSString (HMOrderStatus)

//根据养生馆订单状态返回状态字符串
+ (NSString *)regimenOrderStatusHandleWithStatus:(NSUInteger )status{

    NSString *orderStatusStr;

    if (status == HMOrderStatusToBeConfirm) {
        orderStatusStr = @"待确认";
    }else if (status == HMOrderStatusNoPayment){
        orderStatusStr = @"未支付";
    }else if (status == HMOrderStatusCanceled){
        orderStatusStr = @"已取消";
    }else if (status == HMOrderStatusCompleted){
        orderStatusStr = @"已完成";
    }else if (status == HMOrderStatusPaid){
        orderStatusStr = @"已支付";
    }else if (status == HMOrderStatusProcessing){
        orderStatusStr = @"处理中";
    }else if (status == HMOrderStatusAllowance){
        orderStatusStr = @"已补贴";
    }else if (status == HMOrderStatusCancelAfterVerific){
        orderStatusStr = @"待核销";
    }else if(status == HMOrderStatusWaitComment){
        orderStatusStr = @"未评价";
    }else if(status == HMOrderStatusClose){
        orderStatusStr = @"已关闭";
    }else if(status == HMOrderStatusDel){
        orderStatusStr = @"已删除";
    }
    return orderStatusStr;
}

+ (NSString *)useOrdertypeWith:(HMInOrOutStatus )ordertype{
    //收支项目，0：提现，1：私教订单费用，2：私教订单补贴，3：私教团购费用，4：私教团购补贴，5：场馆费用，6：场馆补贴，7：养生馆费用，8：养生馆补贴 9 : 初始金额
    NSString *string = [NSString string];
    switch (ordertype) {
        case HMInOrOutStatusWithdraw: {
            string = @"提现";
            break;
        }
        case HMInOrOutStatusCoachOrderFee: {
            string = @"私教订单费用";
            break;
        }
        case HMInOrOutStatusCoachOrderSubsidy: {
            string = @"私教订单补贴";
            break;
        }
        case HMInOrOutStatusCourseFee: {
            string = @"私教团购费用";
            break;
        }
        case HMInOrOutStatusCourseSubsidy: {
            string = @"私教团购补贴";
            break;
        }
        case HMInOrOutStatusPlaceFee: {
            string = @"场馆费用";
            break;
        }
        case HMInOrOutStatusPlaceSubsidy: {
            string = @"场馆补贴";
            break;
        }
        case HMInOrOutStatusRegimenFee: {
            string = @"养生馆费用";
            break;
        }
        case HMInOrOutStatusRegimenSubsidy: {
            string = @"养生馆补贴";
            break;
        }
        case HMInOrOutStatusInitialAmount: {
            string = @"初始金额";
            break;
        }
    }
    return string;
}

@end
