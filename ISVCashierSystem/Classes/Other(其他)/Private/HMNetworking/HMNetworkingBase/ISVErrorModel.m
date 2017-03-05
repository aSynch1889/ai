//
//  ISVErrorModel.m
//  ISV
//
//  Created by aaaa on 15/11/13.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVErrorModel.h"


static NSDictionary *errCodes_;

@implementation ISVErrorModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"errCode = %@, errMsg = %@, error = %@", _errCode, _errMsg, _error];
}

- (NSString *)errMsg
{
    if (_errMsg == nil) {
        _errMsg = [ISVErrorModel errMsgFromErrCode:self.errCode];
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

#warning 打包前把 `ISVErrCode.plist` 删除
// 调试错误码
+ (NSDictionary *)errCodes
{
    if (errCodes_ == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ISVErrCode.plist" ofType:nil];
        errCodes_ = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return errCodes_;
}


@end
