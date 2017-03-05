//
//  HMNetworking.h
//  HealthMall
//
//  Created by jkl on 15/10/30.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMNetworkingConst.h"
#import "NSDictionary+HMJoining.h"
#import "HMErrorModel.h"
#import "NSDictionary+ChangeNull.h"


FOUNDATION_EXPORT NSString *const HM_NULL;
FOUNDATION_EXPORT NSString *const reachabilityStatusChangeNotification;

#define kCountForPage_40 40  // 每页40条
#define kCountForPage_20 20  // 每页20条
#define kCountForPage_15 15  // 每页15条
#define kCountForPage_10 10  // 每页10条

#define HasError ([[respondData objectForKeyWithoutNull:@"succeed"] integerValue] != 1)
#define HasValuse ([respondData objectForKeyCanNull:@"valuse"] != nil )

#define Response_ErrCode [respondData objectForKeyWithoutNull:@"errmsg"]
#define Response_Valuse [respondData objectForKeyWithoutNull:@"valuse"]
#define Response_MsgTime [respondData objectForKeyWithoutNull:@"MsgTime"]

#define PrintNetDataJSON NSLog(@"\n============Result START=============\n%@\n============Result END=============",respondData)

/*********************************************************************************
 *
 *  注意:
 *        1.HMNetworking要求所有参数必须是`对象`类型 (回调的block除外)
 *        2.如果参数为空, 使用`HM_NULL` （参照HMHomeViewController.m中的示例）
 *
 *********************************************************************************/


typedef void (^RespondBlock)(id respondData);
typedef void (^ErrorBlock)(HMErrorModel *error);


@interface HMNetworking : NSObject
/// 登录成功后的用户令牌
@property (nonatomic, readonly ,copy) NSString *token;


/// 单例
+ (instancetype)sharedNetworking;

/// POST请求
+ (void)postWithURL:(NSString *)url
             params:(NSDictionary *)params
            success:(RespondBlock)success
            failure:(ErrorBlock)failure;

+ (void)postWithURL:(NSString *)url
      serverAddress:(NSString *)address
             params:(NSDictionary *)params
            success:(RespondBlock)success
            failure:(ErrorBlock)failure;

/// GET请求
+ (void)getWithURL:(NSString *)url
           success:(RespondBlock)success
           failure:(ErrorBlock)failure;

+ (void)getWithURL:(NSString *)url
     serverAddress:(NSString *)address
           success:(RespondBlock)success
           failure:(ErrorBlock)failure;

/**
 * `返回令牌` 注意:token可能为nil, 
 * 使用NSDictionaryOfVariableBindings(以下简称DOB)拼接参数时,需要手动转为HM_NULL
 * 建议使用DOB时, token单独拼接
 */
+ (NSString *)token;

/**
 *  所有正在请求的任务列表
 */
+ (NSArray *)tasks;


@end
