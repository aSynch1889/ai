//
//  ISVNetworking+Coach.h
//  ISV
//
//  Created by aaaa on 15/11/24.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVNetworking.h"

#define kImgOrVedioManagerIdIMG @"IMG"
#define kImgOrVedioManagerIdVIDEO @"VIDEO"
#define kImgOrVedioManagerTypeADD @"ADD"
#define kImgOrVedioManagerTypeDEL @"DEL"

// 便接口类
@interface ISVNetworking (Coach)

#pragma mark -
#pragma mark - 便信息
/**
 * `获取资质列表`
 */
+ (void)coachQualificationWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure;

/**
 * `根据邀请码获取便名称`
 */
+ (void)coachNameByInviteCode:(NSString *)inviteCode success:(RespondBlock)success failure:(ErrorBlock)failure;

/**
 * `获取便信息`
 */
+ (void)coachInfoWithUserID:(NSString *)userID success:(RespondBlock)success failure:(ErrorBlock)failure;

/**
 * `便注册`(team和college至少选一个, 其他参数不可为空)
 * name:姓名
 * card:身份证号
 * education:学历
 * qualification:资质证明
 * courseCost:课程费用
 * professionalProgram:专业项目
 * teachingProgram:可授课项目
 * province:省份
 * city:城市
 * teachingSite:教学场地
 * introduction:个人简介
 * inviteCode:邀请码
 * orderDuration_Base 授课时间
 * team:专业队
 * college:毕业学校
 */
+ (void)coachApplyWithName:(NSString *)name
                      card:(NSString *)card
                 education:(NSString *)education
             qualification:(NSString *)qualification
                      team:(NSString *)team
                   college:(NSString *)college
                courseCost:(NSString *)courseCost
       professionalProgram:(NSString *)professionalProgram
           teachingProgram:(NSString *)teachingProgram
                  province:(NSString *)province
                      city:(NSString *)city
              teachingSite:(NSArray *)teachingSite
              introduction:(NSString *)introduction
                inviteCode:(NSString *)inviteCode
        orderDuration_Base:(NSArray *)ISV_PT_OrderDuration_Base
         certificateImages:(NSDictionary *)ISV_PT_Certificateimgs
             isHomeService:(BOOL)isHomeService
                   success:(RespondBlock)success
                   failure:(ErrorBlock)failure;


/**
 * `便信息修改`
 * Education:学历
 * CourseCost(可选):便课程费用
 * Province:省份
 * City:城市
 * TeachingSite:教学场地
 * Introduction:个人简介
 * Team(可选):专业队
 * College(可选):毕业学校
 * TeachingProgram(可选):便授课项目
 */
+ (void)coachModifyWithEducation:(NSUInteger)education
                            team:(NSString *)team
                         college:(NSString *)college
                        province:(NSString *)province
                            city:(NSString *)city
                    teachingSite:(NSArray *)teachingSite
              orderDuration_Base:(NSArray *)ISV_PT_OrderDuration_Base
                    introduction:(NSString *)introduction
                      courseCost:(NSUInteger)courseCost
                 teachingProgram:(NSString *)teachingProgram
             professionalProgram:(NSUInteger)professionalProgram
                          IDCard:(NSString *)ISV_PT_IDCard
                            name:(NSString *)ISV_PT_Name
                   qualification:(NSUInteger)qualification
                 certificateimgs:(NSDictionary *)ISV_PT_Certificateimgs
                   isHomeService:(BOOL)isHomeService
                         isOrder:(BOOL)isOrder
                     isApplyFail:(BOOL)isApplyFail
                         success:(RespondBlock)success
                         failure:(ErrorBlock)failure;


#pragma mark -
#pragma mark - 小屋管理

// 便订单
/**
 * `便开启接单模式`
 * orderDuration:接单时段
 * 例如:"9:00-10:00,20:00-21:00" -> @[@"9", @"20"];
 */
//+ (void)startOrderModeWithOrderDuration:(NSArray *)orderDuration
//                                success:(RespondBlock)success
//                                failure:(ErrorBlock)failure;

/**
 * `便操作订单`
 * orderId:订单号
 * isReceive:接受或者取消
 */
+ (void)coachDealOrderWithOrderId:(NSString *)orderId
                         yesOrNot:(BOOL)yesOrNot
                          success:(RespondBlock)success
                          failure:(ErrorBlock)failure;

/**
 *  `便获取便被约订单`
 *
 *  @param orderId 订单号（为空时获取订单列表）
 *  @param page    页码
 *  @param year    年份
 *  @param month   月份
 */
+ (void)coachOrderByAppointWithOrderId:(NSString *)orderId
                                  page:(NSUInteger)page
                                 count:(NSUInteger)count
                                  year:(NSUInteger)year
                                  month:(NSUInteger)month
                               success:(RespondBlock)success
                               failure:(ErrorBlock)failure;


/**
 *  `142.便小屋图片和视频管理`
 *
 *  @param Id      IMG：图片，VIDEO：视频  (请使用宏)
 *  @param type    ADD：添加 DEL：删除     (请使用宏)
 *  @param models  [{
 "iurl": "qwe2",
 "uploaddate": "2015-12-24",
 "thumbnail": "thumbnail2"--视图缩略图，删除时可不传，图片无此字段
 },{
 "vurl": "qwe3",
 "uploaddate": "2015-12-24",
 "thumbnail": "thumbnail3"
 }]
 */
+ (void)coachImgOrVedioManagerWithId:(NSString *)Id
                        type:(NSString *)type
                      models:(NSArray *)models
                     success:(RespondBlock)success
                     failure:(ErrorBlock)failure;

/**
 *  `143.获取图片或者视频`
 *
 *  @param UserId  游客获取时，必填；会员获取时，如果是看自己的，不输入；如果是看别人的，必填
 *  @param type    type=img，获取图片; type=video，获取视频；
 */
+ (void)coachGetImgOrVedioWithUserId:(NSString *)UserId
                                type:(NSString *)type
                                page:(NSUInteger)page
                               count:(NSUInteger)count
                             success:(RespondBlock)success
                             failure:(ErrorBlock)failure;

/**
 *  `119.便小屋顶部背景图片管理`
 *
 *  @param code    图片标识
 */
+ (void)coachCoverUploadWithCode:(NSString *)code
                         success:(RespondBlock)success
                         failure:(ErrorBlock)failure;

/**
 *  便团队
 */
+ (void)coashTeamWithPage:(NSUInteger)page count:(NSUInteger)count success:(RespondBlock)success failure:(ErrorBlock)failure;

/**
 *  便看用户约自己的订单列表时：
 */
+ (void)coachCourseOrderListWithPage:(NSInteger)page count:(NSInteger)count courseID:(NSString *)courseID type:(NSString *)type success:(RespondBlock)success failure:(ErrorBlock)failure;

/**
 * `获取课程订单详情 142`
 */
+ (void)coachCourseOrderDetailWithOrderdID:(NSString *)orderdID success:(RespondBlock)success failure:(ErrorBlock)failure;


@end
