//
//  ISVError.h
//  ISV
//
//  Created by aaaa on 17/03/06.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISVError : NSObject

/// HTTP状态码
@property (nonatomic, copy) NSString *errCode;
/// 错误信息
@property (nonatomic, copy) NSString *errMsg;
/// 接口返回内容
@property (nonatomic, copy) NSString *responseString;
@property (nonatomic, strong) NSError *error;

@end
