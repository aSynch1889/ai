//
//  HMPay.h
//  HealthMall
//
//  Created by qiuwei on 15/12/20.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMPayModel.h"
#import "HMPayResult.h"

typedef void(^completeBlock)(HMPayResult *result);

@interface HMPay : NSObject

// 单例
HMSingletonH(Pay)

/**
 *  到支付平台付款
 *
 *  @param payModel      支付信息
 *  @param completeBlock 支付结果回调
 */
- (void)pay:(HMPayModel *)payModel completeBlock:(completeBlock)completeBlock;

/**
 *  支付宝回来处理URL
 */
- (void)handleOpenURLForAliPay:(NSURL *)url;
/**
 *  微信支付回来处理URL
 */
- (BOOL)handleOpenURLForWxPay:(NSURL *)url;
@end
