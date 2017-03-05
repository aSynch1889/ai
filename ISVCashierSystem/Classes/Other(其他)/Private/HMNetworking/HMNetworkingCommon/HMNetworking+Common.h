//
//  HMNetworking+Common.h
//  HealthMall
//
//  Created by qiuwei on 15/11/24.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMNetworking.h"

// 公共网络接口
@interface HMNetworking (Common)

#pragma mark - 上传图片
/**
 * `上传图片`(如果上传头像请使用uploadAvatorWithPath:方法)
 * imagePaths: 图片路径数组
 */
+ (void)uploadImagesWithPaths:(NSArray<NSString *> *)imagePaths
                      success:(RespondBlock)success
                      failure:(ErrorBlock)failure;

#pragma mark - 上传头像
/**
 * `上传头像`
 * imagePath: 图片路径
 * userID: 用户ID号
 */
+ (void)uploadAvatorWithPath:(NSString *)imagePath
                      userID:(NSString *)userID
                     success:(RespondBlock)success
                     failure:(ErrorBlock)failure;


#pragma mark - 获取多种项目类型
/**
 *  获取多种项目类型
 */
+ (void)projectListWithProjectType:(HMProjectType)type
                           success:(RespondBlock)success
                           failure:(ErrorBlock)failure;
#pragma mark - 127.获取腾讯视频鉴权信息
+ (void)authenWithSuccess:(RespondBlock)success
                          failure:(ErrorBlock)failure;

#pragma mark - 139.获取城市列表
/**
 * `获取城市列表`
 * code: 城市编码, 传@""获取所有城市
 */
+ (void)cityListWithCityCode:(NSString *)code isHot:(BOOL)isHot success:(RespondBlock)success failure:(ErrorBlock)failure;


#pragma mark - 支付
/**
 * `获取支付方式列表`
 */
+ (void)getPaymentListWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure;

/**
 * `获取支付配置信息`
 */
+ (void)getPayConfigWithPayWay:(HMPayWay)payWay orderType:(HMOrderType)orderType orderId:(NSString *)orderId success:(RespondBlock)success failure:(ErrorBlock)failure;

/**
 *  `获取最新版本信息`
 */
+ (void)getLatestVersionWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure;

#pragma mark - 获取广告列表
+ (void)launchAdWithPage:(NSInteger)page
                   count:(NSInteger)count
              deviceType:(NSInteger)deviceType
                   width:(NSInteger)width
                  height:(NSInteger)height
                 success:(RespondBlock)success
                 failure:(ErrorBlock)failure;

#pragma mark - 点击广告记录
+ (void)upLogForAdClickWithAdID:(NSString *)adID
                        success:(RespondBlock)success
                        failure:(ErrorBlock)failure;
#pragma mark - 148.获取公共key
+ (void)commonKeyWithSuccess:(RespondBlock)success
                     failure:(ErrorBlock)failure;

@end
