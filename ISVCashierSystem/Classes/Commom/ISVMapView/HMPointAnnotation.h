//
//  HMPointAnnotation.h
//  HealthMall
//
//  Created by qiuwei on 15/12/28.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>

@interface HMPointAnnotation : NSObject<BMKAnnotation>

@property (nonatomic, copy) NSString *title;    // 标题（短地址）
@property (nonatomic, copy) NSString *subtitle; // 副标题（详细地址）
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;    // 标注view中心坐标.

//================== 以下 不是 必传的=====================
@property (nonatomic, copy) NSString *province; // 省份
@property (nonatomic, copy) NSString *city;     // 城市
@property (nonatomic, assign) NSUInteger type;      // 1 ：代表场馆
@property (nonatomic, assign, getter=isSelected) BOOL selected;     // 是否是选中

@end
