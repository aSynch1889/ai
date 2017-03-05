//
//  ISVPayResult.h
//  ISV
//
//  Created by aaaa on 15/12/20.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ISVPayModel;

typedef enum : NSUInteger {
    ISVPayResultErrCodeSuccess       = 0,    // 支付成功
    ISVPayResultErrCodeUserCancel    = -2,   // 用户取消
    ISVPayResultErrCodeSentFail      = -3,   // 发送失败
    ISVPayResultErrCodeAuthDeny      = -4,   // 拒绝认证
    ISVPayResultErrCodeUnsupport     = -5,   // 不支持
    ISVPayResultErrCodeSystemBusy    = -6,   // 系统繁忙
} ISVPayResultErrCode;


/**
 *  支付结果
 */
@interface ISVPayResult : NSObject

/** 错误码 */
@property (nonatomic, assign) ISVPayResultErrCode errCode;
/** 错误提示字符串 */
@property (nonatomic, retain) NSString *errMsg;
/** 响应类型 */
@property (nonatomic, assign) int type;
/** 支付信息 */
@property (nonatomic, strong) ISVPayModel *payModel;

@end
