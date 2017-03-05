//
//  ISVNetworking+Place.h
//  ISV
//
//  Created by ISV005 on 15/12/22.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVNetworking.h"

#define kPlaceListSortDefault   ISV_NULL         // 默认排序
#define kPlaceListSortSynthesize @"synthesize"  // 综合排序
#define kPlaceListSortPrice @"price"            // 价格排序
#define kPlaceListSortDistance @"distance"      // 距离排序
#define kPlaceListSortScore @"score"            // 评分排序

#define kPlaceListTypeHot @"hot"       // 热门
#define kPlaceListTypeNothot @"nothot" // 推荐

#define kPlaceListSortTypeAsc @"asc"  // 升序
#define kPlaceListSortTypeDesc @"desc"  // 降序

@interface ISVNetworking (Place)

#pragma mark 约掌柜
/**
 *  100.掌柜入驻（申请或信息修改）
 *
 *  @param placeId                掌柜ID(添加时不用传)
 *  @param placeLicenceno         营业执照注册号
 *  @param placeLeagalIdcard      身份证号
 *  @param placeLegalName         法人或代理人姓名
 *  @param placeInvitecode        便提供的邀请码
 *  @param placeCertificateimages 相关证件图片(LicenceNo：证件照片，IDCard：身份证，ClientScans:委托人照片，ClientIDCard：委托人身份证)
 *  @param placeImages            掌柜图片
 *  @param placeName              掌柜名称
 *  @param placeOpentime          营业开始时间
 *  @param placeClosetime         营业结束时间
 *  @param placeCoordinate        掌柜坐标
 *  @param placeAddress           掌柜地址
 *  @param placePhone             掌柜电话 二选一
 *  @param placeMobile            掌柜手机
 *  @param placeIntroduction      掌柜简介
 *  @param placeType              1：社区掌柜，2：非社区掌柜，暂定两个，要改的时候再加，然后这个字段只需要后台查看
 *  @param placeSpecialServices   特色服务
 *  @param placeProgramContent    掌柜项目信息json
 （
 venue_id：掌柜ID添加时传-1，
 venueprogram_id：项目ID，
 ISV_vpc_workdayprice：工作日价格，
 ISV_vpc_weekendprice：周未价格，
 ISV_vpc_bookabletime：可预订时间段价格{"childVenueNo1:场地1：{"1":星期一{"6":6点：100.00：价格}}"}
 {"childVenueNo1:{"1":{"6":100.00：价格}}"}
 ）
 *  @param success                成功
 *  @param failure                失败
 */
+ (void)userApplyPlaceWithPlaceId:(NSString *)placeId
                   placeLicenceno:(NSString *)placeLicenceno
                placeLeagalIdcard:(NSString *)placeLeagalIdcard
                   placeLegalName:(NSString *)placeLegalName
                  placeInvitecode:(NSString *)placeInvitecode
           placeCertificateimages:(NSDictionary *)placeCertificateimages
                      placeImages:(NSMutableArray *)placeImages
                        placeName:(NSString *)placeName
                    placeOpentime:(NSString *)placeOpentime
                   placeClosetime:(NSString *)placeClosetime
                  placeCoordinate:(NSDictionary *)placeCoordinate
                     placeAddress:(NSString *)placeAddress
                       placePhone:(NSString *)placePhone
                      placeMobile:(NSString *)placeMobile
                placeIntroduction:(NSString *)placeIntroduction
                        placeType:(NSUInteger )placeType
             placeSpecialServices:(NSDictionary *)placeSpecialServices
              placeProgramContent:(NSMutableArray *)placeProgramContent
                         cityCode:(NSString *)ISV_vi_city
                          success:(RespondBlock)success
                          failure:(ErrorBlock)failure;

/**
 *  约掌柜(掌柜筛选)
 *
 *  @param page    页码
 *  @param count   条数
 *  @param type    类型（请使用头文件的宏）
 *  @param sort    排序（请使用头文件的宏）
 */
+ (void)invitListWithPage:(NSUInteger)page count:(NSUInteger)count type:(NSString *)type sort:(NSString *)sort itemId:(NSString *)itemId sortType:(NSString *)sortType success:(RespondBlock)success failure:(ErrorBlock)failure;


#pragma mark 获取掌柜详情
/**
 *  103.获取掌柜详情
 *
 *  @param venueId 掌柜ID
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)getPlaceDetailInfoWithVenueId:(NSString *)venueId
                              success:(RespondBlock)success
                              failure:(ErrorBlock)failure;
#pragma mark 获取掌柜项目列表
/**
 *  104.获取掌柜项目列表
 */
+ (void)getPlaceItemListSuccess:(RespondBlock)success failure:(ErrorBlock)failure;


#pragma mark 根据项目ID查询掌柜列表
/**
 *  105.根据项目ID查询掌柜列表
 *
 *  @param venueId 项目ID
 *  @param page    当前页
 *  @param count   每页显示数量
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)getPlaceListforitemWithVenueId:(NSString *)venueId
                                  page:(NSInteger )page
                                 count:(NSInteger )count
                               success:(RespondBlock)success
                               failure:(ErrorBlock)failure;

#pragma mark 获取掌柜订单详情
/**
 *  获取掌柜订单详情
 *
 *  @param venueOrderId 掌柜订单ID
 *  @param status       订单状态
 *  @param success      成功
 *  @param failure      失败
 */
+ (void)getPlaceOrderDetailInfoWithVenueOrderId:(NSString *)venueOrderId
                                        success:(RespondBlock)success
                                        failure:(ErrorBlock)failure;

#pragma mark 根据年月日掌柜ID、获取用户订单  //网址：(掌柜馆主获取自己掌柜的订单)
/**
 *   112.根据年月日掌柜ID、获取用户订单 网址：(掌柜馆主获取自己掌柜的订单)
 *
 *  @param venueID 掌柜ID
 *  @param page    当前页
 *  @param count   每页显示数量
 *  @param year    年份
 *  @param month   月份
 *  @param type    （VENUE或者ELSE）
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)getVenueOrderListWithVenueID:(NSString *)venueID
                                page:(NSInteger )page
                               count:(NSInteger )count
                                year:(NSString *)year
                               month:(NSString *)month
                                type:(NSString *)type
                             success:(RespondBlock)success
                             failure:(ErrorBlock)failure;
#pragma mark  网址：(用户获取掌柜订单列表)

/**
 *  用户获取掌柜订单列表
 *
 *  @param page    当前页
 *  @param count   每页显示数量
 *  @param type    （VENUE或者ELSE）
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)userGetVenueOrderListWithPage:(NSInteger )page
                                count:(NSInteger )count
                                 type:(NSString *)type
                              success:(RespondBlock)success
                              failure:(ErrorBlock)failure;

#pragma mark 掌柜订单核销
/**
 *    113.掌柜订单核销
 *
 *  @param venueorderId 掌柜订单ID
 *  @param verifycode   验证码
 *  @param success      成功
 *  @param failure      失败
 */
+ (void)placeOnOrderCancelWithVenueOrderID:(NSString *)venueorderId
                                verifycode:(NSString *)verifycode
                                   success:(RespondBlock)success
                                   failure:(ErrorBlock)failure;


/**
 *  // 135.评价掌柜
 *
 *  @param venue_id       掌柜id
 *  @param venueorder_id  订单id
 *  @param ISV_voc_content 评价内容
 *  @param ISV_voc_score   评分
 *  @param ISV_voc_program 订单项目
 *  @param success        成功
 *  @param failure        失败
 */
+ (void)userEvaluatePlaceOrderWithPlaceID:(NSString *)venue_id
                                  orderID:(NSString *)venueorder_id
                                  content:(NSString *)ISV_voc_content
                                    score:(NSString *)ISV_voc_score
                                  program:(NSString *)ISV_voc_program
                                  success:(RespondBlock)success
                                  failure:(ErrorBlock)failure;


/**
 *  140.获取我的掌柜列表
 *
 *  @param page    当前页
 *  @param count   每页记录数
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)userGetOwnPlaceListWithPage:(NSUInteger )page
                              count:(NSUInteger )count
                            success:(RespondBlock)success
                            failure:(ErrorBlock)failure;
/**
 *  151.获取掌柜详情（只能获取属于自己的掌柜用于掌柜修改)
 *
 *  @param venue_id 掌柜ID
 *  @param success  成功
 *  @param failure  失败
 */
+ (void)userGetOwnPlaceDetailInfoWithPlaceId:(NSString *)venue_id
                                     success:(RespondBlock)success
                                     failure:(ErrorBlock)failure;

#pragma mark - 掌柜预约(即下单)
/**
 * `掌柜预约(即下单)`
 *
 */
+ (void)placeOrderWithPlaceID:(NSString *)placeID
                      sportID:(NSString *)sportID
                         date:(NSString *)date
                          tel:(NSString *)tel
                       amount:(NSInteger)amount
                      reserve:(NSArray *)reserve
                       payWay:(ISVPayWay)payWay
                    orderFrom:(NSString *)orderFrom
                       remark:(NSString *)remark
                isRelease:(BOOL)lockORrelease
                      success:(RespondBlock)success
                      failure:(ErrorBlock)failure;

/**
 *  掌柜团队
 */
+ (void)placeTeamWithPage:(NSUInteger)page count:(NSUInteger)count success:(RespondBlock)success failure:(ErrorBlock)failure;
@end
