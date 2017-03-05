//
//  HMSearchPotocol.h
//  HealthMall
//
//  Created by qiuwei on 15/12/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#ifndef HMSearchPotocol_h
#define HMSearchPotocol_h

@protocol HMSearchPotocol <NSObject>

@required
- (NSString *)title;    // 标题

@optional
- (NSString *)iconName;// 图标名称（优先级比iconUrlString高）
- (NSString *)iconUrlString;// 图标url

@end

#endif /* HMSearchPotocol_h */
