//
//  HMPayResult.h
//  HealthMall
//
//  Created by qiuwei on 15/12/20.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMPayModel;

typedef enum : NSUInteger {
    HMPayResultErrCodeSuccess       = 0,    // 支付成功
    HMPayResultErrCodeUserCancel    = -2,   // 用户取消
    HMPayResultErrCodeSentFail      = -3,   // 发送失败
    HMPayResultErrCodeAuthDeny      = -4,   // 拒绝认证
    HMPayResultErrCodeUnsupport     = -5,   // 不支持
    HMPayResultErrCodeSystemBusy    = -6,   // 系统繁忙
} HMPayResultErrCode;


/**
 *  支付结果
 */
@interface HMPayResult : NSObject

/** 错误码 */
@property (nonatomic, assign) HMPayResultErrCode errCode;
/** 错误提示字符串 */
@property (nonatomic, retain) NSString *errMsg;
/** 响应类型 */
@property (nonatomic, assign) int type;
/** 支付信息 */
@property (nonatomic, strong) HMPayModel *payModel;

@end
