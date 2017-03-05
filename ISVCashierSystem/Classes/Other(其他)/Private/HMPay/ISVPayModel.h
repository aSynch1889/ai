//
//  ISVPayModel.h
//  ISV
//
//  Created by aaaa on 15/12/20.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISVPayModel : NSObject

/* 支付客户端需要的支付配置信息：*/

/* ================== begin 公共(需要手动传值) =================== */
@property (nonatomic, copy) NSString *ISV_OrderId;       // 本地订单ID;
@property (nonatomic, copy) NSString *ISV_OrderPayId;	// 支付订单ID
@property (nonatomic, assign) NSInteger ISV_OrderCount;	// 数量;
@property (nonatomic, copy) NSString *ISV_OrderName;     // 订单名称
@property (nonatomic, copy) NSString *ISV_OrderDesc;     // 订单描述
@property (nonatomic, assign) NSInteger ISV_OrderPrice;	// 订单价格 (支付宝的保留两位小数)
@property (nonatomic, copy) NSString *ISV_OrderTime; 	// 订单时间
@property (nonatomic, assign) ISVPayWay ISV_PayWay;		// 支付方式 enum (支付宝、微信支付、快钱支付)
@property (nonatomic, assign) ISVOrderType ISV_OrderType; // 订单类型 enum (便、课程、掌柜、钱xx)
/* ================== end 公共(需要手动传值) =================== */


/* ================== Alipay（支付宝） =================== */
@property (nonatomic, copy) NSString *ISV_Alipay_ApiKey;     // 密钥
@property (nonatomic, copy) NSString *ISV_Alipay_Partner;    // 合作者身份ID	(商户ID)
@property (nonatomic, copy) NSString *ISV_Alipay_Seller_id;  // 收款支付宝账号
@property (nonatomic, copy) NSString *ISV_Alipay_MchId;      // 安全核验码
@property (nonatomic, copy) NSString *ISV_Alipay_CallBackUrl;// 回调服务器地址
@property (nonatomic, assign) NSInteger ISV_Alipay_PayType;	// 支付类型		默认值为：1（商品购买）
@property (nonatomic, copy) NSString *ISV_Alipay_Goods_type;	// 商品类型		默认值为：1（实物交易）1：实物交易；0：虚拟交易。
@property (nonatomic, copy) NSMutableDictionary *ISV_Alipay_extraParams;   // 额外参数（可空）


/* ================== WXPay（微信） =================== */
@property (nonatomic, copy) NSString *ISV_WXPay_Partner; // 合作者身份ID	(商户ID)
@property (nonatomic, copy) NSString *ISV_WXPay_Appid;   // (商户ID)
@property (nonatomic, copy) NSString *ISV_WXPay_package;	// 商家根据财付通文档填写的数据和签名
@property (nonatomic, copy) NSString *ISV_WXPay_NonceStr;// 随机字符串
@property (nonatomic, copy) NSString *ISV_WXPay_TimeStamp;// 时间戳（在服务器生成订单时）
@property (nonatomic, assign) NSInteger ISV_WXPay_PayType;  // 支付类型
@property (nonatomic, copy) NSString *ISV_WXPay_PrepayId; // 不知道用来干嘛的
@property (nonatomic, copy) NSString *ISV_WXPay_Sign;       // 签名

/* ================== BillPay（快钱） =================== */
@property (nonatomic, assign) NSInteger ISV_BillPay_OrderRealPrice;	//订单真实价格(快钱支付时需要，后台传的)
@property (nonatomic, copy) NSString *ISV_BillPay_PostUrl;	// 请求支付地址
@property (nonatomic, copy) NSString *ISV_BillPay_CallBackUrl;// 回调服务器地址
@property (nonatomic, copy) NSString *ISV_BillPay_ext1;      // 扩展字段1，便掌柜用于区分订单类型  约掌柜订单 = 0 ， 课程团购订单 = 1， 约便订单 = 2 ， 动力产品订单 = 3 ， 体验店订单 = 4；
@property (nonatomic, copy) NSString *ISV_BillPay_MerchantAcctId; // 人民币网关账号
@property (nonatomic, copy) NSString *ISV_BillPay_inputCharset;	// 字符编码
@property (nonatomic, copy) NSString *ISV_BillPay_Version;	// 网关版本，固定值：v2.0,该参数必填。
@property (nonatomic, copy) NSString *ISV_BillPay_Language;  // 语言种类，1代表中文显示，2代表英文显示。默认为1,该参数必填。
@property (nonatomic, copy) NSString *ISV_BillPay_Sign_Type;	// 签名类型
@property (nonatomic, copy) NSString *ISV_BillPay_PayType;   // 支付类型
@property (nonatomic, copy) NSString *ISV_BillPay_PayerId;	// 会员ID(mall用户)
@property (nonatomic, copy) NSString *ISV_BillPay_PayerIdType;	// 会员类型
@property (nonatomic, copy) NSString *ISV_BillPay_Sign;      // 签名

/* ================== readonly（固定值, 不需要业务层传值） =================== */
@property (nonatomic, copy, readonly) NSString *ISV_AppKey;  // APPKey
@property (nonatomic, assign, readonly) NSInteger ISV_Timeout;     // 超时时间 s

/**
 *  将商品信息拼接成字符串(针对支付宝)
 */
- (NSString *)orderSpecForAliPay;
@end
