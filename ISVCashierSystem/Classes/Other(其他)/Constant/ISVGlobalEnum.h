//
//  ISVGlobalEnum.h
//  ISV
//
//  Created by aaaa on 17/3/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#ifndef ISVGlobalEnum_h
#define ISVGlobalEnum_h

#import <UIKit/UIKit.h>

// 性别
typedef enum : NSUInteger {

    ISVSexMan        = 1,    // 男
    ISVSexWoman      = 2,    // 女
    ISVSexUnknown    = 3,    // 未知性别
} ISVSexType;

// 项目类型
typedef enum : NSUInteger {
    ISVProjectTypeAskFriend = 0, // 约动友
    ISVProjectTypeAskCoach = 1,  // 约便
    ISVProjectTypePlace = 2,     // 掌柜
    ISVProjectTypeRegimen = 3,   // 钱xx
} ISVProjectType;

// 便、掌柜、钱xx 申请状态
typedef enum : NSInteger {
    ISVStatusNotApply   = -1,    // 用户完善资料后
    ISVStatusApplying   = 1,    // 申请私中
    ISVStatusApplyPass  = 2,    // 审核通过后
    ISVStatusApplyFail  = 3,    // 审核失败后

} ISVStatusApply;

//--掌柜状态（-2，已冻结，-1，未通过，0：审核中，1：通过 ）
//--核审状态，暂定0：审核中，-1，未通过，1：通过
typedef NS_ENUM(NSInteger, ISVAuditStatus) {
    ISVAuditStatusFrozen   = -2,//已冻结
    ISVAuditStatusFail     = -1,//未通过
    ISVAuditStatusAuditing = 0,//审核中
    ISVAuditStatusPass     = 1,//审核通过
};

// 图片质量
typedef enum : NSUInteger {

    ISVImage_AUTO_QUAILTY = 0,   // 自动
    ISVImage_HEIGHT_QUAILTY,     // 高质量
    ISVImage_LOW_QUAILTY         // 低质量

} ISVImageQuailty;

// 排序
typedef NS_ENUM(NSUInteger, ISVSortOption)
{
    ISVSortOptionAscending = 0,    // 升序
    ISVSortOptionDescending = 1,   // 降序
};

// 编辑模式
typedef enum : NSUInteger{
    ISVEditModeAdd   = 0,
    ISVEditModeModify = 1,
    ISVEditModeDelete = 2,
    ISVEditModePreview= 3,
} ISVEditMode;

// 扫描后会执行哪个动作
//（key:value格式  key暂定有1代表用户、2代表群聊、3代表链接  value为对应的值用户ID、群聊ID、链接地址）
typedef enum : NSUInteger {
    ISVQRCodeToolRuleAll = 0,    // 所有的规则
    ISVQRCodeToolRuleAddFriend = 1, // 添加好友(加密)
    ISVQRCodeToolRuleJoinTribe = 2, // 加入群(加密)
    ISVQRCodeToolRuleWeb = 3,    // 网址(加密)
    ISVQRCodeToolRuleOther = 4,  // 其他(未加密)
    
} ISVQRCodeToolRule;

// 便被约的订单类型（便端）
typedef enum : NSUInteger {
    ISVCoachOrderStatusWaitCheck = 1,// 待确认1
    ISVCoachOrderStatusWaitPay = 2,      // 待支付2
    ISVCoachOrderStatusCancelled = 3,    // 已取消3
    ISVCoachOrderStatusCompleted = 4,    // 已完成4
    ISVCoachOrderStatusPayed = 5,        // 已支付5
    ISVCoachOrderStatusProcessedding = 6,// 处理中6
    ISVCoachOrderStatusSubsidy = 7,      // 已补贴7
    ISVCoachOrderStatusWaitVerification = 8,  // 待核销8
    ISVCoachOrderStatusWaitComment = 9,  // 未评价9
    ISVCoachOrderStatusClose = 10,  // 已关闭10
    ISVCoachOrderStatusDel = 11,  // 已删除11
} ISVCoachOrderStatus;

// 便被约的订单类型的描述
#define ISVCoachOrderStatusDesc \
        @{\
        @(ISVCoachOrderStatusWaitCheck):@"待确认",\
        @(ISVCoachOrderStatusWaitPay):@"待支付",\
        @(ISVCoachOrderStatusCancelled):@"已取消",\
        @(ISVCoachOrderStatusCompleted):@"已完成",\
        @(ISVCoachOrderStatusPayed):@"已支付",\
        @(ISVCoachOrderStatusProcessedding):@"处理中",\
        @(ISVCoachOrderStatusSubsidy):@"已补贴",\
        @(ISVCoachOrderStatusWaitVerification):@"待核销",\
        @(ISVCoachOrderStatusWaitComment):@"未评价",\
        @(ISVCoachOrderStatusClose):@"已关闭",\
        @(ISVCoachOrderStatusDel):@"已删除"\
}

// 掌柜订单及钱xx订单状态
// --订单状态（1：待确认、2：未支付、3：已取消、4：已完成、5：已付款、6处理中、7：已补贴、8：待核销、9：未评价、已10关闭、11：删除）（关闭：是在退款完成后的状态）
typedef enum : NSUInteger{
    ISVOrderStatusToBeConfirm        = 1,//1：待确认
    ISVOrderStatusNoPayment          = 2,//2：未支付
    ISVOrderStatusCanceled           = 3,//3：已取消
    ISVOrderStatusCompleted          = 4,//4：已完成
    ISVOrderStatusPaid               = 5,//5：已付款
    ISVOrderStatusProcessing         = 6,//6处理中
    ISVOrderStatusAllowance          = 7,//7：已补贴
    ISVOrderStatusCancelAfterVerific = 8,//8：待核销
    ISVOrderStatusWaitComment        = 9,//9：未评价
    ISVOrderStatusClose              = 10,//10:已关闭
    ISVOrderStatusDel                = 11,//11：删除
} ISVOrderStatus;

//收支项目，0：提现，1：便订单费用，2：便订单补贴，3：便团购费用，4：便团购补贴，5：掌柜费用，6：掌柜补贴，7：钱xx费用，8：钱xx补贴，9：初始金额
typedef NS_ENUM(NSInteger, ISVInOrOutStatus) {
    ISVInOrOutStatusWithdraw          = 0,//提现
    ISVInOrOutStatusCoachOrderFee     = 1,//便订单费用
    ISVInOrOutStatusCoachOrderSubsidy = 2,//便订单补贴
    ISVInOrOutStatusCourseFee         = 3,//便团购费用
    ISVInOrOutStatusCourseSubsidy     = 4,//便团购补贴
    ISVInOrOutStatusPlaceFee          = 5,//掌柜费用
    ISVInOrOutStatusPlaceSubsidy      = 6,//掌柜补贴
    ISVInOrOutStatusRegimenFee        = 7,//钱xx费用
    ISVInOrOutStatusRegimenSubsidy    = 8,//钱xx补贴
    ISVInOrOutStatusInitialAmount     = 9,//初始金额
};

//1：超时确认、 2：便拒绝 3：超时支付 4：自行取消
typedef NS_ENUM(NSUInteger, ISVOrderCancelStatus) {
    ISVOrderTimeOutConfirm = 1,//1：超时确认
    ISVOrderReject         = 2,//2：便拒绝
    ISVOrderTimeOutPay     = 3,//3：超时支付
    ISVOrderUserCancel     = 4//4：自行取消
};

// 不同类型的订单的评价
typedef NS_ENUM(NSUInteger, ISVEvaluateOrderType) {
    ISVEvaluateOrderCoach   = 1,//便订单评价
    ISVEvaluateOrderCourse  = 2,//团购课程评价
    ISVEvaluateOrderRegimen = 3,//钱xx订单评价
    ISVEvaluateOrderPlace   = 4//掌柜订单评价
};

// 下单者和被下单者区分 用于普通用户和拥有者订单查看
typedef enum :NSUInteger {
    ISVOrderUser = 1,
    ISVOrderOwner = 2
} ISVOrderOwnerType;

#pragma mark - 支付/订单

// 支付方式
typedef enum : NSUInteger {
    ISVPayWayAliPay = 1,    // 支付宝
    ISVPayWayWXPay = 2,     // 微信支付
    ISVPayWayBillPay = 3,   // 快钱支付
} ISVPayWay;

// 订单类型
typedef enum : NSUInteger {
    ISVOrderTypeCoach,       // 约便订单
    ISVOrderTypeCoachgroup,  // 课程团购订单
    ISVOrderTypePlace,       // 约掌柜订单
    ISVOrderTypeRegimen,     // 钱xx订单
    ISVOrderTypeShop,        // 商城
} ISVOrderType;

// 订单类型描述
#define ISVOrderTypeDesc \
@{\
@(ISVOrderTypeCoach):@"privateteach",\
@(ISVOrderTypeCoachgroup):@"Privateteachgroup",\
@(ISVOrderTypePlace):@"Venue",\
@(ISVOrderTypeRegimen):@"Pavilion",\
}

#endif /* ISVGlobalEnum_h */
