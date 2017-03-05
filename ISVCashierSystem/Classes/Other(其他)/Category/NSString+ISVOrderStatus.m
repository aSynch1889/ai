//
//  NSString+ISVOrderStatus.m
//  ISV
//
//  Created by ISV005 on 16/1/4.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "NSString+ISVOrderStatus.h"

@implementation NSString (ISVOrderStatus)

//根据养生馆订单状态返回状态字符串
+ (NSString *)regimenOrderStatusHandleWithStatus:(NSUInteger )status{

    NSString *orderStatusStr;

    if (status == ISVOrderStatusToBeConfirm) {
        orderStatusStr = @"待确认";
    }else if (status == ISVOrderStatusNoPayment){
        orderStatusStr = @"未支付";
    }else if (status == ISVOrderStatusCanceled){
        orderStatusStr = @"已取消";
    }else if (status == ISVOrderStatusCompleted){
        orderStatusStr = @"已完成";
    }else if (status == ISVOrderStatusPaid){
        orderStatusStr = @"已支付";
    }else if (status == ISVOrderStatusProcessing){
        orderStatusStr = @"处理中";
    }else if (status == ISVOrderStatusAllowance){
        orderStatusStr = @"已补贴";
    }else if (status == ISVOrderStatusCancelAfterVerific){
        orderStatusStr = @"待核销";
    }else if(status == ISVOrderStatusWaitComment){
        orderStatusStr = @"未评价";
    }else if(status == ISVOrderStatusClose){
        orderStatusStr = @"已关闭";
    }else if(status == ISVOrderStatusDel){
        orderStatusStr = @"已删除";
    }
    return orderStatusStr;
}

+ (NSString *)useOrdertypeWith:(ISVInOrOutStatus )ordertype{
    //收支项目，0：提现，1：私教订单费用，2：私教订单补贴，3：私教团购费用，4：私教团购补贴，5：场馆费用，6：场馆补贴，7：养生馆费用，8：养生馆补贴 9 : 初始金额
    NSString *string = [NSString string];
    switch (ordertype) {
        case ISVInOrOutStatusWithdraw: {
            string = @"提现";
            break;
        }
        case ISVInOrOutStatusCoachOrderFee: {
            string = @"私教订单费用";
            break;
        }
        case ISVInOrOutStatusCoachOrderSubsidy: {
            string = @"私教订单补贴";
            break;
        }
        case ISVInOrOutStatusCourseFee: {
            string = @"私教团购费用";
            break;
        }
        case ISVInOrOutStatusCourseSubsidy: {
            string = @"私教团购补贴";
            break;
        }
        case ISVInOrOutStatusPlaceFee: {
            string = @"场馆费用";
            break;
        }
        case ISVInOrOutStatusPlaceSubsidy: {
            string = @"场馆补贴";
            break;
        }
        case ISVInOrOutStatusRegimenFee: {
            string = @"养生馆费用";
            break;
        }
        case ISVInOrOutStatusRegimenSubsidy: {
            string = @"养生馆补贴";
            break;
        }
        case ISVInOrOutStatusInitialAmount: {
            string = @"初始金额";
            break;
        }
    }
    return string;
}

@end
