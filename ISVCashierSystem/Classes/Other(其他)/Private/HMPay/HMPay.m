//
//  HMPay.m
//  HealthMall
//
//  Created by qiuwei on 15/12/20.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMPay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "NSString+HMExtension.h"
#import "HMWebViewController.h"
#import "HMUserInterfaceTool.h"
#import "RSADataSigner.h"
#import "WXApi.h"
#import "HMHUD.h"

@interface HMPay ()<WXApiDelegate>
@property (nonatomic, copy) completeBlock completeBlock;
@property (nonatomic, strong) HMPayModel *payModel;
@end

@implementation HMPay

// 单例
HMSingletonM(Pay)

- (void)pay:(HMPayModel *)payModel completeBlock:(void(^)(HMPayResult *result))completeBlock;
{
    [HMHUD dismiss];
    _payModel = payModel;
    _completeBlock = [completeBlock copy];
    
    HMPayResult *result = [[HMPayResult alloc] init];
    result.payModel = payModel;
    
    switch (payModel.HM_PayWay) {
        case HMPayWayWXPay:    // 微信支付
        {
            // 检查微信是否已被用户安装
            BOOL isInstalled = [WXApi isWXAppInstalled];
            if (!isInstalled) {
                result.errCode = HMPayResultErrCodeUnsupport;
                result.errMsg = @"请安装微信客户端";
                ! completeBlock ? : completeBlock(result);
                return;
            }else{
                // 生成参数
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = payModel.HM_WXPay_Partner;
                request.prepayId = payModel.HM_WXPay_PrepayId;
                request.package = payModel.HM_WXPay_package;
                request.nonceStr = payModel.HM_WXPay_NonceStr;
                request.timeStamp = [payModel.HM_WXPay_TimeStamp intValue];
                request.sign = payModel.HM_WXPay_Sign;
                [WXApi sendReq:request];
            }
        }
            break;
        case HMPayWayAliPay:    // 支付宝
        {
            
            NSString *orderSpec = [payModel orderSpecForAliPay];
            NSLog(@"orderSpec ||| %@",orderSpec);
            // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
            NSString *signedString = [RSADataSigner signString:orderSpec privateKey:payModel.HM_Alipay_ApiKey];
            
            NSString *orderString = nil;
            if (signedString != nil) {
                orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
                
                NSLog(@"orderString ||| %@",orderString);
                
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:kAppScheme_com callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                    
                    [self AliPayCallBackWithDict:resultDic];
                }];
                
            }

        }
            break;
        case HMPayWayBillPay:    // 快钱
        {
            if (!payModel.HM_BillPay_ext1) {
                payModel.HM_BillPay_ext1 = @"";
            }
            // 请求体
            NSString *signMsgStr = [payModel.HM_BillPay_Sign urlStringEncoding];
            
            NSString *postBody = [NSString stringWithFormat:@"orderId=%@&orderAmount=%@&productName=%@&productNum=%zd&productDesc=%@&ext1=%@&signMsg=%@&merchantAcctId=%@&inputCharset=%@&bgUrl=%@&version=%@&language=%@&signType=%@&payerIdType=%@&payerId=%@&orderTime=%@&payType=%@",
                                  payModel.HM_OrderId,
                                  [NSString stringWithFormat:@"%.0f",((float)payModel.HM_BillPay_OrderRealPrice)],
                                  payModel.HM_OrderName,
                                  payModel.HM_OrderCount,
                                  payModel.HM_OrderDesc,
                                  payModel.HM_BillPay_ext1,
                                  signMsgStr,
                                  payModel.HM_BillPay_MerchantAcctId,
                                  payModel.HM_BillPay_inputCharset,
                                  payModel.HM_BillPay_CallBackUrl,
                                  payModel.HM_BillPay_Version,
                                  payModel.HM_BillPay_Language,
                                  payModel.HM_BillPay_Sign_Type,
                                  payModel.HM_BillPay_PayerIdType,
                                  payModel.HM_BillPay_PayerId,
                                  payModel.HM_OrderTime,
                                  payModel.HM_BillPay_PayType
                                  ];
            
            NSLog(@"postBody:%@",postBody);
            
            // 打开浏览器
            HMWebViewController *webVC = [[HMWebViewController alloc] init];
            webVC.title = @"支付";
            webVC.POSTBody = postBody;
            webVC.urlString = payModel.HM_BillPay_PostUrl;

            [[HMUserInterfaceTool topViewController].navigationController pushViewController:webVC animated:YES];
        }
            break;
        default:
            
            break;
    }
}

/**
 *  支付宝回来处理URL
 */
- (void)handleOpenURLForAliPay:(NSURL *)url
{
    // 支付宝
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);//返回的支付结果
        [self AliPayCallBackWithDict:resultDic];
    }];
}
/**
 *  微信支付回来处理URL
 */
- (BOOL)handleOpenURLForWxPay:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - <WXApiDelegate>
-(void)onResp:(id)resp
{
    NSLog(@"resp：%@",resp);
    if ([resp isKindOfClass:[PayResp class]]) {// 微信支付回来的结果
        if ([resp isKindOfClass:[PayResp class]]) {
            
            [self WXPayCallBack:resp];
        }
    }
    
    //    if ([resp isKindOfClass:[SendAuthResp class]]) {// 微信登录
    //        SendAuthResp*aresp=(SendAuthResp*)resp;
    //    }
    
}
#pragma mark - Private
- (void)WXPayCallBack:(PayResp *)note
{
    HMPayResult *result = [[HMPayResult alloc] init];
    result.payModel = _payModel;
    
    PayResp *response = (PayResp *)note;
    switch (response.errCode) {
        case WXSuccess:
        {
            // 服务器端查询支付通知或查询API返回的结果再提示成功
            NSLog(@"支付成功");
            result.errCode = HMPayResultErrCodeSuccess;
            
        }
            break;
        case WXErrCodeUserCancel:
        {
            NSLog(@"支付已取消");
            result.errCode = HMPayResultErrCodeUserCancel;

        }
            break;
        case WXErrCodeAuthDeny:
        {
            NSLog(@"拒绝授权");
            result.errCode = HMPayResultErrCodeAuthDeny;
            
        }
            break;
        default:
            NSLog(@"支付失败,请重新支付");
            result.errCode = HMPayResultErrCodeUserCancel;
            break;
    }
    
    ! _completeBlock ? : _completeBlock(result);
    
}

- (void)AliPayCallBackWithDict:(NSDictionary *)resultDic;
{
    HMPayResult *result = [[HMPayResult alloc] init];
    result.payModel = _payModel;
    
    NSInteger errCode = [[resultDic objectForKey:@"resultStatus"] integerValue];
    
    if (errCode == 9000) {
        
        // 服务器端查询支付通知或查询API返回的结果再提示成功
        result.errCode = HMPayResultErrCodeSuccess;
        NSLog(@"支付宝支付成功");
        
    }else{
        
        NSLog(@"支付宝支付失败");
        if (errCode == 6001) { // 用户取消支付
            result.errCode = HMPayResultErrCodeUserCancel;
            
        }else if(errCode == 1000){// 系统繁忙
            
            result.errCode = HMPayResultErrCodeSystemBusy;
            
        }else{
            result.errCode = HMPayResultErrCodeUserCancel;
        }
    }
    
    ! _completeBlock ? : _completeBlock(result);
}

@end
