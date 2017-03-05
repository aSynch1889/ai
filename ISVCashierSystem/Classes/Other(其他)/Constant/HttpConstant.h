//
//  HttpConstant.h
//  ISV
//
//  Created by aaaa on 15/10/29.
//  Copyright © 2017年 ISV. All rights reserved.
//

/**
 *  网络请求宏
 */
#ifndef HttpConstant_h
#define HttpConstant_h

#pragma mark -
#pragma mark - 各种域名


#define URL_MAIN @"http://ISV.me"
#define URL_MAIN_tv @"http://ISV.tv"

#define URL_MAINHOSTNAME  @"http://183.3.138.130:6000"       //移动api域名
#define URL_SHOPHOSTNAME  @"http://192.168.1.238:887"        //动力商城域名
#define URL_DLQHOSTNAME   @"http://183.3.138.130:84"         //动力圈域名
#define URL_SHAREHOSTNAME @"http://183.3.138.130:777"       //分享域名
#define URL_HMAHOSTNAME   @"http://ISVa.ISV.tv:8056/ISVa/index.php?" //统计分析域名
#define URL_UPLOADHOSTNAME @"http://img.ISV.me:85" //图片上传域名
#define URL_IMAGE_PATH @"http://img.ISV.me" //图片域名

#pragma mark -
#pragma mark - 其他链接

#define URL_LOGO_URLSTRING [NSString stringWithFormat:@"%@/logo.jpg", URL_IMAGE_PATH] // logo链接

#define URL_IMAGE_photos @"photos"
#define URL_IMAGE_URLSTRING [NSString stringWithFormat:@"%@/%@/", URL_IMAGE_PATH, URL_IMAGE_photos] // 图片路径

#define URL_Download_APP_ForiOS @"https://itunes.apple.com/cn/app/jian-kang-mao-rang-yun-dong/id966436668?mt=8" // 下载链接
#define URL_Download_APP_ForiOS_Tencent @"http://t.cn/RAlRBj3"
#define URL_CreateQRcode @"http://ISV.tv/common/qrcode" // 二维码链接

#pragma mark -
#pragma mark - H5交互

#define URL_WebConnect_Login @"/Login/Login"// 发送登录路径


#pragma mark - 
#pragma mark - 商城

#define URL_SHOP_ProductManager @"/product/pt_product_list/?"   // 小屋动力商城管理
#define URL_SHOP_ProductMore @"/product/product_list/?"         // 更多私教的商品
#define URL_Shop_ProductList @"/jkmajax/GetProduct/?"  // 商品列表


#define URL_Proxy_Template @"/doc/proxyscan.html" //委托书范本
#define URL_Settled_Proxy @"/doc/venue_ruzhu.html" //商家入驻协议



#endif /* HttpConstant_h */
