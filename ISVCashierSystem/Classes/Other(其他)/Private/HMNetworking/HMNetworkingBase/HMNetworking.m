//
//  HMNetworking.m
//  HealthMall
//
//  Created by jkl on 15/10/30.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMNetworking.h"
#import "HMUserTokenManager.h"
#import <AFNetworking.h>

NSString *const HM_NULL = @"HM_NULL_FLAG";
NSString *const reachabilityStatusChangeNotification = @"reachabilityStatusChangeNotification";

@interface HMNetworking ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/// 登录成功后的用户令牌
@property (nonatomic, readwrite, copy) NSString *token;
@end

@implementation HMNetworking
@synthesize token = _token;

#pragma mark - POST请求
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(RespondBlock)success
            failure:(ErrorBlock)failure
{
    [self postWithURL:url serverAddress:SERVER_ADRESS params:params success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

+ (void)postWithURL:(NSString *)url
      serverAddress:(NSString *)address
             params:(NSDictionary *)params
            success:(RespondBlock)success
            failure:(ErrorBlock)failure
{
    HMNetworking *networking = [HMNetworking sharedNetworking];
    
    if(networking.manager.reachabilityManager.isReachable)
    {
        [networking postWithURL:url
                  serverAddress:address
                         params:params
                        success:^(id respondData)
        {
            ! success ? : success(respondData);
        } failure:^(HMErrorModel *error)
        {
            ! failure ? : failure(error);
        }];
    }
    else
    {
        HMErrorModel *error = [[HMErrorModel alloc] init];
        error.errMsg = @"网络无法连接";
        error.errCode = @"-404";
        ! failure ? : failure(error);
    }
}

- (void)postWithURL:(NSString *)url
      serverAddress:(NSString *)address
             params:(NSDictionary *)params
            success:(RespondBlock)success
            failure:(ErrorBlock)failure
{
    @autoreleasepool {
        url = [NSString stringWithFormat:@"%@%@", address ? address : @"", url];
    }
    NSLog(@"url-POST:%@",url);
    
    // 清除value为空的参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:params.count];
    for (NSString *key in [params allKeys])
    {
        if (![params[key] isEqual:HM_NULL] )
        {
            [dict setObject:params[key] forKey:key];
        }
    }

    
    if ([dict[@"model"] isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *model = [NSDictionary dictionaryWithDictionary:dict[@"model"]];
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionary ];
        for (NSString *key in [model allKeys])
        {
            if (![model[key] isEqual:HM_NULL] )
            {
                [tempDict setObject:model[key] forKey:key];
            }
        }
        
        dict[@"model"] = tempDict;
    }
    
    params = [dict copy];
    NSLog(@"prama-最底层的参数打印-%@--1",params);
    
    [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respondData) {
        
        BOOL isSucceed = [[respondData[@"succeed"] description] boolValue];
        if (isSucceed)
        {
            // 判断是否有block, 防止崩溃
            ! success ? : success(respondData);
        }else
        {
            NSString *errCode = [respondData[@"errmsg"] description];
            
            if ((errCode.integerValue == 10003) ||  // 令牌错误
                (errCode.integerValue == 10007) ||  // 该用户长时间没有登录让用户重新登录
                (errCode.integerValue == 10263))    // 游客无操作权限
            {
                //创建通知
//                NSNotification *notification =[NSNotification notificationWithName:kNotification_NeedLogin object:nil];
                
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
            }else if (errCode.integerValue == 10000){
                
//                [[NSNotificationCenter defaultCenter]  postNotificationName:kNotification_LoginStateChange object:@(NO)];
            }
            
            HMErrorModel *error = [[HMErrorModel alloc] init];
            error.errCode = errCode;
            failure(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        HMErrorModel *err = [[HMErrorModel alloc] init];
        err.errCode = @(response.statusCode).description;
        err.error = error;
        failure(err);
        
    }];
}


#pragma - GET请求
+ (void)getWithURL:(NSString *)url
           success:(RespondBlock)success
           failure:(ErrorBlock)failure
{
    [self getWithURL:url serverAddress:SERVER_ADRESS success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

+ (void)getWithURL:(NSString *)url
     serverAddress:(NSString *)address
           success:(RespondBlock)success
           failure:(ErrorBlock)failure
{
    HMNetworking *networking = [HMNetworking sharedNetworking];
    
    if(networking.manager.reachabilityManager.isReachable)
    {
        @autoreleasepool
        {
            url = [url stringByReplacingOccurrencesOfString:HM_NULL withString:@""];
            url = [url stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            url = [url stringByReplacingOccurrencesOfString:@"null" withString:@""];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        [networking getWithURL:url serverAddress:address success:^(id respondData) {
            ! success ? : success(respondData);
        } failure:^(HMErrorModel *error) {
            ! failure ? : failure(error);
        }];
    }
    else
    {
        HMErrorModel *error = [[HMErrorModel alloc] init];
        error.errMsg = @"网络无法连接";
        error.errCode = @"-404";
        ! failure ? : failure(error);
    }
}

- (void)getWithURL:(NSString *)url
     serverAddress:(NSString *)address
           success:(RespondBlock)success
           failure:(ErrorBlock)failure
{
    @autoreleasepool {
        url = [NSString stringWithFormat:@"%@%@", address, url];
    }
    NSLog(@"url-GET:%@",url);
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable respondData) {
        
        if ([respondData isKindOfClass:[NSArray class]])
        {
            success(respondData);  // 兼容商城, 没有返回succeed
        }
        else
        {
            BOOL succeed = [[respondData[@"succeed"] description] boolValue];
            if (succeed)
            {
                success(respondData);
            }else
            {
                NSString *errCode = [respondData[@"errmsg"] description];
                
                if ((errCode.integerValue == 10003) ||  // 令牌错误
                    (errCode.integerValue == 10007) ||  // 该用户长时间没有登录让用户重新登录
                    (errCode.integerValue == 10263))    // 游客无操作权限
                {
                    //创建通知
//                    NSNotification *notification = [NSNotification notificationWithName:kNotification_NeedLogin object:nil];
//                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                }else if (errCode.integerValue == 10000){

//                    [[NSNotificationCenter defaultCenter]  postNotificationName:kNotification_LoginStateChange object:@(NO)];
                }

                HMErrorModel *err = [[HMErrorModel alloc] init];
                err.errCode = errCode;
                failure(err);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        HMErrorModel *err = [[HMErrorModel alloc] init];
        err.errCode = @(response.statusCode).description;
        err.error = error;
        
        failure(err);
    }];

}

#pragma mark - 单例模式
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static HMNetworking *instance;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

#pragma mark - shared
+ (instancetype)sharedNetworking
{
    return [[self alloc] init];
}

#pragma <getter和setter>
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil)
    {
        _manager = [AFHTTPSessionManager manager];
        _manager.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [_manager.reachabilityManager startMonitoring];
        [_manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        _manager.requestSerializer.timeoutInterval = 30;
        [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:reachabilityStatusChangeNotification
                                                                object:nil
                                                              userInfo:@{reachabilityStatusChangeNotification:@(status)}];
        }];
    }
    return _manager;
}

- (NSString *)token
{
    if (_token.length == 0)
    {
        _token = [HMUserTokenManager readToken];
    }
    return _token;
}

+ (NSString *)token
{
    return [[[HMNetworking alloc] init] token];
}


- (void)setToken:(NSString *)token
{
    _token = token;
    // 保存本地用于自动登录
#warning 需要增加是否自动登录选项
    [HMUserTokenManager saveToken:_token];
}


#pragma mark - 所有正在请求的任务列表
+ (NSArray *)tasks
{
    return [[HMNetworking sharedNetworking].manager tasks];
}
@end
