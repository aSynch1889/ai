//
//  ISVPayModel.m
//  ISV
//
//  Created by aaaa on 15/12/20.
//  Copyright © 2017年 ISV. All rights reserved.
//

#define kInputCharset	@"utf-8"
#define kTimeout	30
#define kAlipay_Service	@"mobile.securitypay.pay"
#define kAlipay_ShowUrl @"m.alipay.com"

#import "ISVPayModel.h"
#import <NSObject+MJCoding.h>

@implementation ISVPayModel

// 映射表，{“本地”：“服务器”}， 使用MJExtension时有效
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             
             @"ISV_OrderTime" : @"orderTime",
             @"ISV_OrderName": @"productName",
             @"ISV_OrderDesc": @"productDesc",
             @"ISV_OrderName": @"productName",
             @"ISV_OrderCount": @"productNum",
             
             @"ISV_Alipay_ApiKey" : @"ApiKey",
             @"ISV_Alipay_Partner" : @"AppId",
             @"ISV_Alipay_Seller_id" : @"AppSecret",
             @"ISV_Alipay_MchId" : @"MchID",
             @"ISV_Alipay_CallBackUrl" : @"NotifyUrl",
             
             @"ISV_WXPay_Appid" : @"appid",
             @"ISV_WXPay_NonceStr" : @"nonceStr",
             @"ISV_WXPay_package" : @"package",
             @"ISV_WXPay_Partner" : @"partnerId",
             @"ISV_WXPay_PayType" : @"payType",
             @"ISV_WXPay_PrepayId": @"prepayId",
             @"ISV_WXPay_Sign" : @"sign",
             @"ISV_WXPay_TimeStamp" : @"timeStamp",
             
             @"ISV_BillPay_OrderRealPrice" : @"orderAmount",
             @"ISV_BillPay_MerchantAcctId" : @"MerchantAcctId",
             @"ISV_BillPay_CallBackUrl" : @"Bg_Url",
             @"ISV_BillPay_PostUrl" : @"PostUrl",
             @"ISV_BillPay_Sign" : @"SignMsg",
             @"ISV_BillPay_inputCharset" : @"InputCharset",
             @"ISV_BillPay_Version" : @"Version",
             @"ISV_BillPay_Language" : @"Language",
             @"ISV_BillPay_Sign_Type" : @"SignType",
             @"ISV_BillPay_ext1" : @"ext1",
             @"ISV_BillPay_PayerId" : @"payerId",
             @"ISV_BillPay_PayerIdType" : @"PayerIdType",
             @"ISV_BillPay_PayType" : @"PayType",
             
             };
    
}

/**
 *  将商品信息拼接成字符串(针对支付宝)
 */
- (NSString *)orderSpecForAliPay
{
    NSMutableString *discription = [NSMutableString string];
    if (self.ISV_Alipay_Partner) {
        [discription appendFormat:@"partner=\"%@\"", self.ISV_Alipay_Partner];
    }
    
    if (self.ISV_Alipay_Seller_id) {
        [discription appendFormat:@"&seller_id=\"%@\"", self.ISV_Alipay_Seller_id];
    }
    if (self.ISV_OrderId) {
        [discription appendFormat:@"&out_trade_no=\"%@\"", self.ISV_OrderId];
    }
    if (self.ISV_OrderName) {
        [discription appendFormat:@"&subject=\"%@\"", self.ISV_OrderName];
    }
    
    if (self.ISV_OrderDesc) {
        [discription appendFormat:@"&body=\"%@\"", self.ISV_OrderDesc];
    }
    if (self.ISV_OrderPrice) {
        [discription appendFormat:@"&total_fee=\"%@\"", [NSString stringWithFormat:@"%.2f", (double)self.ISV_OrderPrice]];
    }
    if (self.ISV_Alipay_CallBackUrl) {
        [discription appendFormat:@"&notify_url=\"%@\"", self.ISV_Alipay_CallBackUrl];
    }
    
    [discription appendFormat:@"&service=\"%@\"",kAlipay_Service];
    
    if (self.ISV_Alipay_PayType) {
        [discription appendFormat:@"&payment_type=\"%zd\"",self.ISV_Alipay_PayType];// 1
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
    for (NSString * key in [self.ISV_Alipay_extraParams allKeys]) {
        [discription appendFormat:@"&%@=\"%@\"", key, [self.ISV_Alipay_extraParams objectForKey:key]];
    }
    return discription;

}

// 支付宝的额外参数
- (NSMutableDictionary *)ISV_Alipay_extraParams
{
    return nil;
}

- (NSInteger)ISV_Alipay_PayType
{
    if(!_ISV_Alipay_PayType){
        _ISV_Alipay_PayType = 1;
    }
    return _ISV_Alipay_PayType;
}

- (NSString *)ISV_Alipay_Goods_type
{
    if(!_ISV_Alipay_Goods_type){
        _ISV_Alipay_Goods_type = @"1";
    }
    return _ISV_Alipay_Goods_type;
}

/**
 *  归档/解档
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
#warning decode
//        [self decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
#warning decode
    //    [self encode:encoder];
}


@end
