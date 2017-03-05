//
//  HMUrlManager.h
//  HealthMall
//
//  Created by qiuwei on 15/9/18.
//  Copyright (c) 2015年 Jinzhai Nature Health Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMUrlManager : NSObject

/**
 *  生成滴滴打车URL
 *
 *  @return 返回滴滴打车NSString
 */
+ (NSString *)didiTaxiUrl;


/*
    获取用户的优惠券
 */
+ (NSURL*)getMyCouponUrl:(BOOL)isUse;

/*
 * 生成分享页URL
 * type : 场馆Venuepage | 好友分享Inviteuser|私教小屋Coachpage|课程分享Classesinfo|养生馆分享Pavilionpage|约动友分享Impetusfriend
 * params : 参数字典 k	数据id
                    t	用户token
                    s	分享交互形式 t1:app 纯原生  t2:h5 纯web  t3:apph5 两者结合
                    mark	业务类型（外部不需传）
                    market	分享渠道（外部不需传）
 */

+ (NSString *)generateShareUrlWithType:(NSString *)type params:(NSDictionary*)params;

/**
 *  根据路径数组返回缩略图路径数组
 *
 *  @param URLStrings 原路径数组
 *
 *  @return 缩略图路径数组
 */
+ (NSMutableArray *)getThumbURLsWithURLStrings:(NSArray *)URLStrings;

@end
