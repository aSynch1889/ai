//
//  HMPayModel.m
//  HealthMall
//
//  Created by qiuwei on 15/12/20.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#define kInputCharset	@"utf-8"
#define kTimeout	30
#define kAlipay_Service	@"mobile.securitypay.pay"
#define kAlipay_ShowUrl @"m.alipay.com"

#import "HMPayModel.h"
#import <NSObject+MJCoding.h>

@implementation HMPayModel

// 映射表，{“本地”：“服务器”}， 使用MJExtension时有效
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             
             @"HM_OrderTime" : @"orderTime",
             @"HM_OrderName": @"productName",
             @"HM_OrderDesc": @"productDesc",
             @"HM_OrderName": @"productName",
             @"HM_OrderCount": @"productNum",
             
             @"HM_Alipay_ApiKey" : @"ApiKey",
             @"HM_Alipay_Partner" : @"AppId",
             @"HM_Alipay_Seller_id" : @"AppSecret",
             @"HM_Alipay_MchId" : @"MchID",
             @"HM_Alipay_CallBackUrl" : @"NotifyUrl",
             
             @"HM_WXPay_Appid" : @"appid",
             @"HM_WXPay_NonceStr" : @"nonceStr",
             @"HM_WXPay_package" : @"package",
             @"HM_WXPay_Partner" : @"partnerId",
             @"HM_WXPay_PayType" : @"payType",
             @"HM_WXPay_PrepayId": @"prepayId",
             @"HM_WXPay_Sign" : @"sign",
             @"HM_WXPay_TimeStamp" : @"timeStamp",
             
             @"HM_BillPay_OrderRealPrice" : @"orderAmount",
             @"HM_BillPay_MerchantAcctId" : @"MerchantAcctId",
             @"HM_BillPay_CallBackUrl" : @"Bg_Url",
             @"HM_BillPay_PostUrl" : @"PostUrl",
             @"HM_BillPay_Sign" : @"SignMsg",
             @"HM_BillPay_inputCharset" : @"InputCharset",
             @"HM_BillPay_Version" : @"Version",
             @"HM_BillPay_Language" : @"Language",
             @"HM_BillPay_Sign_Type" : @"SignType",
             @"HM_BillPay_ext1" : @"ext1",
             @"HM_BillPay_PayerId" : @"payerId",
             @"HM_BillPay_PayerIdType" : @"PayerIdType",
             @"HM_BillPay_PayType" : @"PayType",
             
             };
    
}

/**
 *  将商品信息拼接成字符串(针对支付宝)
 */
- (NSString *)orderSpecForAliPay
{
    NSMutableString *discription = [NSMutableString string];
    if (self.HM_Alipay_Partner) {
        [discription appendFormat:@"partner=\"%@\"", self.HM_Alipay_Partner];
    }
    
    if (self.HM_Alipay_Seller_id) {
        [discription appendFormat:@"&seller_id=\"%@\"", self.HM_Alipay_Seller_id];
    }
    if (self.HM_OrderId) {
        [discription appendFormat:@"&out_trade_no=\"%@\"", self.HM_OrderId];
    }
    if (self.HM_OrderName) {
        [discription appendFormat:@"&subject=\"%@\"", self.HM_OrderName];
    }
    
    if (self.HM_OrderDesc) {
        [discription appendFormat:@"&body=\"%@\"", self.HM_OrderDesc];
    }
    if (self.HM_OrderPrice) {
        [discription appendFormat:@"&total_fee=\"%@\"", [NSString stringWithFormat:@"%.2f", (double)self.HM_OrderPrice]];
    }
    if (self.HM_Alipay_CallBackUrl) {
        [discription appendFormat:@"&notify_url=\"%@\"", self.HM_Alipay_CallBackUrl];
    }
    
    [discription appendFormat:@"&service=\"%@\"",kAlipay_Service];
    
    if (self.HM_Alipay_PayType) {
        [discription appendFormat:@"&payment_type=\"%zd\"",self.HM_Alipay_PayType];// 1
    }
    
    [discription appendFormat:@"&_input_charset=\"%@\"", kInputCharset];
    
    [discription appendFormat:@"&it_b_pay=\"%zdm\"",kTimeout];
    
    [discription appendFormat:@"&show_url=\"%@\"", kAlipay_ShowUrl];
    
//    if (self.rsaDate) {
//        [discription appendFormat:@"&sign_date=\"%@\"",self.rsaDate];
//    }
//    if (self.appID) {
//        [discription appendFormat:@"&app_id=\"%@\"",self.appID];
//    }
    for (NSString * key in [self.HM_Alipay_extraParams allKeys]) {
        [discription appendFormat:@"&%@=\"%@\"", key, [self.HM_Alipay_extraParams objectForKey:key]];
    }
    return discription;

}

// 支付宝的额外参数
- (NSMutableDictionary *)HM_Alipay_extraParams
{
    return nil;
}

- (NSInteger)HM_Alipay_PayType
{
    if(!_HM_Alipay_PayType){
        _HM_Alipay_PayType = 1;
    }
    return _HM_Alipay_PayType;
}

- (NSString *)HM_Alipay_Goods_type
{
    if(!_HM_Alipay_Goods_type){
        _HM_Alipay_Goods_type = @"1";
    }
    return _HM_Alipay_Goods_type;
}

/**
 *  归档/解档
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        [self decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [self encode:encoder];
}


@end
