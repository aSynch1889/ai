//
//  NSString+ISVOrderStatus.m
//  ISV
//
//  Created by ISV005 on 16/1/4.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "NSString+ISVOrderStatus.h"

@implementation NSString (ISVOrderStatus)

//根据钱xx订单状态返回状态字符串
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
    //收支项目，0：提现，1：便订单费用，2：便订单补贴，3：便团购费用，4：便团购补贴，5：掌柜费用，6：掌柜补贴，7：钱xx费用，8：钱xx补贴 9 : 初始金额
    NSString *string = [NSString string];
    switch (ordertype) {
        case ISVInOrOutStatusWithdraw: {
            string = @"提现";
            break;
        }
        case ISVInOrOutStatusCoachOrderFee: {
            string = @"便订单费用";
            break;
        }
        case ISVInOrOutStatusCoachOrderSubsidy: {
            string = @"便订单补贴";
            break;
        }
        case ISVInOrOutStatusCourseFee: {
            string = @"便团购费用";
            break;
        }
        case ISVInOrOutStatusCourseSubsidy: {
            string = @"便团购补贴";
            break;
        }
        case ISVInOrOutStatusPlaceFee: {
            string = @"掌柜费用";
            break;
        }
        case ISVInOrOutStatusPlaceSubsidy: {
            string = @"掌柜补贴";
            break;
        }
        case ISVInOrOutStatusRegimenFee: {
            string = @"钱xx费用";
            break;
        }
        case ISVInOrOutStatusRegimenSubsidy: {
            string = @"钱xx补贴";
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
