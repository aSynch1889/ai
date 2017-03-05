//
//  HMBaseCellModel.h
//  HealthMall
//
//  Created by qiuwei on 15/11/14.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

// 通用cell的类，使用时最好继承此Model
@interface HMBaseCellModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;    // 标题
@property (nonatomic, copy) NSString *iconName; // 图标
@property (nonatomic, copy) NSString *className;// 类名

@property (nonatomic, copy) NSString *subTitle; // 副标题

@end
