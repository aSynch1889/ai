//
//  HMCheck.h
//  HealthMall
//
//  Created by qiuwei on 15/11/17.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMCheckPotocol.h"

@interface HMCheck : NSObject<HMCheckPotocol>

@property (nonatomic, copy, nullable) NSString *ID;
@property (nonatomic, copy, nonnull) NSString *title;    // 标题
@property (nonatomic, copy, nullable) NSString *iconName;// 图标名称（优先级比iconUrlString高）
@property (nonatomic, copy, nullable) NSString *iconUrlString;// 图标url

@property (nonatomic, assign) BOOL isCheck;   // 是否被选中
@end
