//
//  ISVBaseCellModel.h
//  ISV
//
//  Created by aaaa on 15/11/14.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

// 通用cell的类，使用时最好继承此Model
@interface ISVBaseCellModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *title;    // 标题
@property (nonatomic, copy) NSString *iconName; // 图标
@property (nonatomic, copy) NSString *className;// 类名

@property (nonatomic, copy) NSString *subTitle; // 副标题

@end
