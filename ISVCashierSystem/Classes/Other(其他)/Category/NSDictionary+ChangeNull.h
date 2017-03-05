//
//  NSDictionary+ChangeNull.h
//  ISV
//
//  Created by xmfish on 14-9-19.
//  Copyright (c) 2015年 Jinzhai Nature Health Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ChangeNull)

// 改变对象的值，不能为空
- (nonnull id)objectForKeyWithoutNull:(nonnull id)aKey;

// 改变对象的值，可为空或为0
- (nullable id)objectForKeyCanNull:(nonnull id)aKey;
@end
