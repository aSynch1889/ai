//
//  HMError.h
//  HealthMall
//
//  Created by jkl on 15/11/12.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMError : NSObject

/// HTTP状态码
@property (nonatomic, copy) NSString *errCode;
/// 错误信息
@property (nonatomic, copy) NSString *errMsg;
/// 接口返回内容
@property (nonatomic, copy) NSString *responseString;
@property (nonatomic, strong) NSError *error;

@end
