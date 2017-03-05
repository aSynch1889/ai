//
//  HMErrorModel.m
//  HealthMall
//
//  Created by jkl on 15/11/13.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMErrorModel.h"


static NSDictionary *errCodes_;

@implementation HMErrorModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"errCode = %@, errMsg = %@, error = %@", _errCode, _errMsg, _error];
}

- (NSString *)errMsg
{
    if (_errMsg == nil) {
        _errMsg = [HMErrorModel errMsgFromErrCode:self.errCode];
        if (_errMsg == nil)
        {
            
            _errMsg = @{@"404":@"无法连接服务器"}[self.errCode];
            
            if (_errMsg == nil)
            {
                _errMsg = self.error.localizedDescription;
            }
        }
    }
    return _errMsg;
}

/**
 *  利用错误码获得错误信息
 */
+ (NSString *)errMsgFromErrCode:(NSString *)errCode
{
    return self.errCodes[errCode];
}

#warning 打包前把 `HMErrCode.plist` 删除
// 调试错误码
+ (NSDictionary *)errCodes
{
    if (errCodes_ == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HMErrCode.plist" ofType:nil];
        errCodes_ = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return errCodes_;
}


@end
