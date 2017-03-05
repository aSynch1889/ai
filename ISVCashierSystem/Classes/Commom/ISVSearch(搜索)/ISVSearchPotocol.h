//
//  ISVSearchPotocol.h
//  ISV
//
//  Created by aaaa on 15/12/16.
//  Copyright © 2017年 ISV. All rights reserved.
//

#ifndef ISVSearchPotocol_h
#define ISVSearchPotocol_h

@protocol ISVSearchPotocol <NSObject>

@required
- (NSString *)title;    // 标题

@optional
- (NSString *)iconName;// 图标名称（优先级比iconUrlString高）
- (NSString *)iconUrlString;// 图标url

@end

#endif /* ISVSearchPotocol_h */
