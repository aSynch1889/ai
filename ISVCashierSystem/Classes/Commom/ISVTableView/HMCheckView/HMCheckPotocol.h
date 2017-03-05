//
//  HMCheckPotocol.h
//  HealthMall
//
//  Created by qiuwei on 15/12/14.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#ifndef HMCheckPotocol_h
#define HMCheckPotocol_h

@protocol HMCheckPotocol <NSObject>

@required
@property (nonatomic, assign) BOOL isCheck;   // 是否被选中
- (NSString *)title;    // 标题

@optional
- (NSString *)ID;
- (NSString *)iconName;// 图标名称（优先级比iconUrlString高）
- (NSString *)iconUrlString;// 图标url

@end

#endif /* HMCheckPotocol_h */
