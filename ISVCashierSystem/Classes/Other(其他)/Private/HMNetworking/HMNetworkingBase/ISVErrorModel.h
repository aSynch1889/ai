//
//  ISVErrorModel.h
//  ISV
//
//  Created by aaaa on 15/11/13.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISVErrorModel : NSObject
/// 错误代码
@property (nonatomic, copy) NSString *errCode;
/// 错误信息
@property (nonatomic, copy) NSString *errMsg;

@property (nonatomic, strong) NSError *error;

/**
 *  利用错误码获得错误信息
 */
+ (NSString *)errMsgFromErrCode:(NSString *)errCode;
@end
