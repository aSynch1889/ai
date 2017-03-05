//
//  HMGlobalEnum.h
//  HealthMall
//
//  Created by qiuwei on 15/11/3.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#ifndef HMGlobalEnum_h
#define HMGlobalEnum_h

#import <UIKit/UIKit.h>

// 性别
typedef enum : NSUInteger {

    HMSexMan        = 1,    // 男
    HMSexWoman      = 2,    // 女
    HMSexUnknown    = 3,    // 未知性别
} HMSexType;

// 项目类型
typedef enum : NSUInteger {
    HMProjectTypeAskFriend = 0, // 约动友
    HMProjectTypeAskCoach = 1,  // 约私教
    HMProjectTypePlace = 2,     // 场馆
    HMProjectTypeRegimen = 3,   // 养生馆
} HMProjectType;

// 私教、场馆、养生馆 申请状态
typedef enum : NSInteger {
    HMStatusNotApply   = -1,    // 用户完善资料后
    HMStatusApplying   = 1,    // 申请私中
    HMStatusApplyPass  = 2,    // 审核通过后
    HMStatusApplyFail  = 3,    // 审核失败后

} HMStatusApply;

//--场馆状态（-2，已冻结，-1，未通过，0：审核中，1：通过 ）
//--核审状态，暂定0：审核中，-1，未通过，1：通过
typedef NS_ENUM(NSInteger, HMAuditStatus) {
    HMAuditStatusFrozen   = -2,//已冻结
    HMAuditStatusFail     = -1,//未通过
    HMAuditStatusAuditing = 0,//审核中
    HMAuditStatusPass     = 1,//审核通过
};

// 图片质量
typedef enum : NSUInteger {

    HMImage_AUTO_QUAILTY = 0,   // 自动
    HMImage_HEIGHT_QUAILTY,     // 高质量
    HMImage_LOW_QUAILTY         // 低质量

} HMImageQuailty;

// 排序
typedef NS_ENUM(NSUInteger, HMSortOption)
{
    HMSortOptionAscending = 0,    // 升序
    HMSortOptionDescending = 1,   // 降序
};

// 编辑模式
typedef enum : NSUInteger{
    HMEditModeAdd   = 0,
    HMEditModeModify = 1,
    HMEditModeDelete = 2,
    HMEditModePreview= 3,
} HMEditMode;

// 扫描后会执行哪个动作
//（key:value格式  key暂定有1代表用户、2代表群聊、3代表链接  value为对应的值用户ID、群聊ID、链接地址）
typedef enum : NSUInteger {
    HMQRCodeToolRuleAll = 0,    // 所有的规则
    HMQRCodeToolRuleAddFriend = 1, // 添加好友(加密)
    HMQRCodeToolRuleJoinTribe = 2, // 加入群(加密)
    HMQRCodeToolRuleWeb = 3,    // 网址(加密)
    HMQRCodeToolRuleOther = 4,  // 其他(未加密)
    
} HMQRCodeToolRule;

// 私教被约的订单类型（私教端）
typedef enum : NSUInteger {
    HMCoachOrderStatusWaitCheck = 1,// 待确认1
    HMCoachOrderStatusWaitPay = 2,      // 待支付2
    HMCoachOrderStatusCancelled = 3,    // 已取消3
    HMCoachOrderStatusCompleted = 4,    // 已完成4
    HMCoachOrderStatusPayed = 5,        // 已支付5
    HMCoachOrderStatusProcessedding = 6,// 处理中6
    HMCoachOrderStatusSubsidy = 7,      // 已补贴7
    HMCoachOrderStatusWaitVerification = 8,  // 待核销8
    HMCoachOrderStatusWaitComment = 9,  // 未评价9
    HMCoachOrderStatusClose = 10,  // 已关闭10
    HMCoachOrderStatusDel = 11,  // 已删除11
} HMCoachOrderStatus;

// 私教被约的订单类型的描述
#define HMCoachOrderStatusDesc \
        @{\
        @(HMCoachOrderStatusWaitCheck):@"待确认",\
        @(HMCoachOrderStatusWaitPay):@"待支付",\
        @(HMCoachOrderStatusCancelled):@"已取消",\
        @(HMCoachOrderStatusCompleted):@"已完成",\
        @(HMCoachOrderStatusPayed):@"已支付",\
        @(HMCoachOrderStatusProcessedding):@"处理中",\
        @(HMCoachOrderStatusSubsidy):@"已补贴",\
        @(HMCoachOrderStatusWaitVerification):@"待核销",\
        @(HMCoachOrderStatusWaitComment):@"未评价",\
        @(HMCoachOrderStatusClose):@"已关闭",\
        @(HMCoachOrderStatusDel):@"已删除"\
}

// 场馆订单及养生馆订单状态
// --订单状态（1：待确认、2：未支付、3：已取消、4：已完成、5：已付款、6处理中、7：已补贴、8：待核销、9：未评价、已10关闭、11：删除）（关闭：是在退款完成后的状态）
typedef enum : NSUInteger{
    HMOrderStatusToBeConfirm        = 1,//1：待确认
    HMOrderStatusNoPayment          = 2,//2：未支付
    HMOrderStatusCanceled           = 3,//3：已取消
    HMOrderStatusCompleted          = 4,//4：已完成
    HMOrderStatusPaid               = 5,//5：已付款
    HMOrderStatusProcessing         = 6,//6处理中
    HMOrderStatusAllowance          = 7,//7：已补贴
    HMOrderStatusCancelAfterVerific = 8,//8：待核销
    HMOrderStatusWaitComment        = 9,//9：未评价
    HMOrderStatusClose              = 10,//10:已关闭
    HMOrderStatusDel                = 11,//11：删除
} HMOrderStatus;

//收支项目，0：提现，1：私教订单费用，2：私教订单补贴，3：私教团购费用，4：私教团购补贴，5：场馆费用，6：场馆补贴，7：养生馆费用，8：养生馆补贴，9：初始金额
typedef NS_ENUM(NSInteger, HMInOrOutStatus) {
    HMInOrOutStatusWithdraw          = 0,//提现
    HMInOrOutStatusCoachOrderFee     = 1,//私教订单费用
    HMInOrOutStatusCoachOrderSubsidy = 2,//私教订单补贴
    HMInOrOutStatusCourseFee         = 3,//私教团购费用
    HMInOrOutStatusCourseSubsidy     = 4,//私教团购补贴
    HMInOrOutStatusPlaceFee          = 5,//场馆费用
    HMInOrOutStatusPlaceSubsidy      = 6,//场馆补贴
    HMInOrOutStatusRegimenFee        = 7,//养生馆费用
    HMInOrOutStatusRegimenSubsidy    = 8,//养生馆补贴
    HMInOrOutStatusInitialAmount     = 9,//初始金额
};

//1：超时确认、 2：私教拒绝 3：超时支付 4：自行取消
typedef NS_ENUM(NSUInteger, HMOrderCancelStatus) {
    HMOrderTimeOutConfirm = 1,//1：超时确认
    HMOrderReject         = 2,//2：私教拒绝
    HMOrderTimeOutPay     = 3,//3：超时支付
    HMOrderUserCancel     = 4//4：自行取消
};

// 不同类型的订单的评价
typedef NS_ENUM(NSUInteger, HMEvaluateOrderType) {
    HMEvaluateOrderCoach   = 1,//私教订单评价
    HMEvaluateOrderCourse  = 2,//团购课程评价
    HMEvaluateOrderRegimen = 3,//养生馆订单评价
    HMEvaluateOrderPlace   = 4//场馆订单评价
};

// 下单者和被下单者区分 用于普通用户和拥有者订单查看
typedef enum :NSUInteger {
    HMOrderUser = 1,
    HMOrderOwner = 2
} HMOrderOwnerType;

#pragma mark - 支付/订单

// 支付方式
typedef enum : NSUInteger {
    HMPayWayAliPay = 1,    // 支付宝
    HMPayWayWXPay = 2,     // 微信支付
    HMPayWayBillPay = 3,   // 快钱支付
} HMPayWay;

// 订单类型
typedef enum : NSUInteger {
    HMOrderTypeCoach,       // 约私教订单
    HMOrderTypeCoachgroup,  // 课程团购订单
    HMOrderTypePlace,       // 约场馆订单
    HMOrderTypeRegimen,     // 养生馆订单
    HMOrderTypeShop,        // 商城
} HMOrderType;

// 订单类型描述
#define HMOrderTypeDesc \
@{\
@(HMOrderTypeCoach):@"privateteach",\
@(HMOrderTypeCoachgroup):@"Privateteachgroup",\
@(HMOrderTypePlace):@"Venue",\
@(HMOrderTypeRegimen):@"Pavilion",\
}

#endif /* HMGlobalEnum_h */
