//
//  ISVNetworking+Coach.m
//  ISV
//
//  Created by aaaa on 15/11/24.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVNetworking+Coach.h"

@implementation ISVNetworking (Coach)

/**
 * `获取资质列表`
 */
+ (void)coachQualificationWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure
{
    // 根据key拼接url
    
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&type=ALL",COACH_QUALIFICATION, [self token]];
    
    [self getWithURL:url success:^(id respondData) {
        ! success ? : success(respondData);
    } failure:^(ISVErrorModel *error) {
        ! failure ? : failure(error);
    }];
}

/**
 * `根据邀请码获取私教名称`
 */
+ (void)coachNameByInviteCode:(NSString *)inviteCode success:(RespondBlock)success failure:(ErrorBlock)failure
{
    // 根据key拼接url
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&inviteCode=%@",COACH_NameByInviteCode, [self token], inviteCode];
    
    [self getWithURL:url success:^(id respondData) {
        ! success ? : success(respondData);
    } failure:^(ISVErrorModel *error) {
        ! failure ? : failure(error);
    }];
}
/**
 * `获取私教信息`
 */
+ (void)coachInfoWithUserID:(NSString *)userID success:(RespondBlock)success failure:(ErrorBlock)failure
{
    // 根据key拼接url
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&user_id_self=%@",COACH_INFO, [self token], userID];
    
    [self getWithURL:url success:^(id respondData) {
        ! success ? : success(respondData);
    } failure:^(ISVErrorModel *error) {
        ! failure ? : failure(error);
    }];
}
/*
 3.私教注册
 网址：http://192.168.1.238:5000/trainer/OperatePersonalTrainer/key
 类型：post
 数据类型：Content-Type: text/json
 传入Json：
 {
 "ISV_PT_Name":"杨小二",
 "ISV_PT_IDCard":"430525188806236789",
 "ISV_PT_Education":1,
 "ISV_PT_Qualification":1,
 "ISV_PT_Team":"中国武术队",
 "ISV_PT_College":"中华武术学院",
 "ISV_PT_CourseCost":2000.00,
 "ISV_PT_ProfessionalProgram":1,
 "ISV_PT_TeachingProgram":"八级拳",
 "ISV_PT_Province":"广东",
 "ISV_PT_City":"广州",
 "ISV_PT_TeachingSite":"体育馆",
 "ISV_PT_Introduction":"全国武术冠军",
 "ISV_PT_InviteCode":"123456"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 ISV_PT_Name	是	姓名
 ISV_PT_IDCard	是	身份证号
 ISV_PT_Education	是	学历
 ISV_PT_Qualification	是	资质证明
 ISV_PT_CourseCost	是	课程费用
 ISV_PT_ProfessionalProgram	是	专业项目
 ISV_PT_TeachingProgram	是	可授课项目
 ISV_PT_Province	是	省份
 ISV_PT_City	是	城市
 ISV_PT_TeachingSite	是	教学场地
 ISV_PT_Introduction	是	个人简介
 ISV_PT_InviteCode	是	邀请码
 ISV_PT_Team	否	专业队
 ISV_PT_College	否	毕业学校
 
 返回说明Json：
 {
 "errmsg": 10019,
 "succeed": true,
 "MsgTime": "2015-10-10T14:54:13.7580035+08:00",
 "valuse": null
 }
 
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，私教注册成功，false，私教注册失败
 errmsg	操作完成后返回信息	私教申请失败 = 10018,
 私教申请成功 = 10019,
 您的申请正在审核中 = 10020,
 邀请码不存在 = 10021,
 会员信息不一致 = 10022,
 私教注册异常 = 10023,
 专业队和毕业学校必选其一 = 10096
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	无	null
 */
#pragma - 私教注册
+ (void)coachApplyWithName:(NSString *)ISV_PT_Name
                      card:(NSString *)ISV_PT_IDCard
                 education:(NSString *)ISV_PT_Education
             qualification:(NSString *)ISV_PT_Qualification
                      team:(NSString *)ISV_PT_Team
                   college:(NSString *)ISV_PT_College
                courseCost:(NSString *)ISV_PT_CourseCost
       professionalProgram:(NSString *)ISV_PT_ProfessionalProgram
           teachingProgram:(NSString *)ISV_PT_TeachingProgram
                  province:(NSString *)ISV_PT_Province
                      city:(NSString *)ISV_PT_City
              teachingSite:(NSArray *)ISV_PT_TeachingSite
              introduction:(NSString *)ISV_PT_Introduction
                inviteCode:(NSString *)ISV_PT_InviteCode
        orderDuration_Base:(NSArray *)ISV_PT_OrderDuration_Base
         certificateImages:(NSDictionary *)ISV_PT_Certificateimgs
             isHomeService:(BOOL)isHomeService
                   success:(RespondBlock)success
                   failure:(ErrorBlock)failure
{
    NSString *url = POST_URL;
    NSString *whichFunc = COACH_APPLY;
    NSString *key = [self token];
    
    NSNumber *ISV_PT_IsHomeService = @(isHomeService);

    NSDictionary *model = NSDictionaryOfVariableBindings(ISV_PT_Name,
                                                         ISV_PT_IDCard,
                                                         ISV_PT_Education,
                                                         ISV_PT_Qualification,
                                                         ISV_PT_Team,
                                                         ISV_PT_College,
                                                         ISV_PT_CourseCost,
                                                         ISV_PT_ProfessionalProgram,
                                                         ISV_PT_TeachingProgram,
                                                         ISV_PT_Province,
                                                         ISV_PT_City,
                                                         ISV_PT_TeachingSite,
                                                         ISV_PT_Introduction,
                                                         ISV_PT_InviteCode,
                                                         ISV_PT_OrderDuration_Base,
                                                         ISV_PT_Certificateimgs,
                                                         ISV_PT_IsHomeService
                                                         );
    
    NSDictionary *param = NSDictionaryOfVariableBindings(key, model, whichFunc);
    
    [self postWithURL:url params:param success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}


/*
 4.私教信息修改
 网址：http://192.168.1.238:5000/trainer/OperatePersonalTrainer/key
 类型：post
 数据类型：Content-Type: text/json
 传入Json：
 {
 "ISV_PT_Education":1,
 "ISV_PT_Team":"中国武术队",
 "ISV_PT_College":"中华武术学院",
 "ISV_PT_Province":"广东",
 "ISV_PT_City":"广州",
 "ISV_PT_TeachingSite":"体育馆",
 "ISV_PT_Introduction":"全国武术冠军",
 "ISV_PT_CourseCost":2000.00,
 "ISV_PT_TeachingProgram":"八级拳"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 ISV_PT_Education	是	学历
 ISV_PT_CourseCost	否	私教课程费用
 ISV_PT_Province	是	省份
 ISV_PT_City	是	城市
 ISV_PT_TeachingSite	是	教学场地
 ISV_PT_Introduction	是	个人简介
 ISV_PT_Team	否	专业队
 ISV_PT_College	否	毕业学校
 ISV_PT_TeachingProgram	否	私教授课项目
 
 返回说明Json：
 {
 "errmsg": 10025,
 "succeed": true,
 "MsgTime": "2015-10-10T15:02:25.3048262+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，私教修改成功，false，私教修改失败
 errmsg	操作完成后返回信息	私教信息修改失败 = 10024,
 私教信息修改成功 = 10025,
 私教信息修改异常 = 10026
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	无	null
 */
#pragma - 私教信息修改
+ (void)coachModifyWithEducation:(NSUInteger)education
                            team:(NSString *)ISV_PT_Team
                         college:(NSString *)ISV_PT_College
                        province:(NSString *)ISV_PT_Province
                            city:(NSString *)ISV_PT_City
                    teachingSite:(NSArray *)ISV_PT_TeachingSite
              orderDuration_Base:(NSArray *)ISV_PT_OrderDuration_Base
                    introduction:(NSString *)ISV_PT_Introduction
                      courseCost:(NSUInteger)courseCost
                 teachingProgram:(NSString *)ISV_PT_TeachingProgram
             professionalProgram:(NSUInteger)professionalProgram
                          IDCard:(NSString *)ISV_PT_IDCard
                            name:(NSString *)ISV_PT_Name
                   qualification:(NSUInteger)qualification
                 certificateimgs:(NSDictionary *)ISV_PT_Certificateimgs
                   isHomeService:(BOOL)isHomeService
                         isOrder:(BOOL)isOrder
                     isApplyFail:(BOOL)isApplyFail
                         success:(RespondBlock)success
                         failure:(ErrorBlock)failure
{
    NSString *url = SETMYWALLETPASSWORD;
    NSString *whichFunc = COACH_MODIFY;
    NSString *key = [self token];
    
    NSNumber *ISV_PT_IsHomeService = @(isHomeService);
    NSNumber *ISV_pt_isorder = @(isOrder);
    NSNumber *ISV_PT_CourseCost = @(courseCost);
    NSNumber *ISV_PT_Education = @(education);
    NSNumber *ISV_PT_ProfessionalProgram = @(professionalProgram);
    NSNumber *ISV_PT_Qualification = @(qualification);
    
    NSDictionary *model = NSDictionaryOfVariableBindings(
                                                         ISV_PT_Education,
                                                         ISV_PT_Team,
                                                         ISV_PT_College,
                                                         ISV_PT_Province,
                                                         ISV_PT_City,
                                                         ISV_PT_TeachingSite,
                                                         ISV_PT_OrderDuration_Base,
                                                         ISV_PT_Introduction,
                                                         ISV_PT_CourseCost,
                                                         ISV_PT_TeachingProgram,
                                                         ISV_PT_ProfessionalProgram,
                                                         ISV_PT_IDCard,
                                                         ISV_PT_Name,
                                                         ISV_PT_Qualification,
                                                         ISV_PT_Certificateimgs,
                                                         ISV_PT_IsHomeService,
                                                         ISV_pt_isorder
                                                         );
    
    NSNumber *yesOrNot = @(isApplyFail);
    
    NSDictionary *param = NSDictionaryOfVariableBindings(key, model, whichFunc, yesOrNot);
    
    [self postWithURL:url params:param success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}



/*
 5.私教开启接单模式
 网址：http://192.168.1.238:5000/trainer/StartOrderMode/key
 类型：post
 数据类型：Content-Type: text/json
 传入Json：
 {
 "ISV_OSM_OrderDuration": "19:00-20:00,20:00-21:00",
 "ISV_OSM_Longitude": 23.2,
 "ISV_OSM_Latitude": 113.3
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 ISV_OSM_OrderDuration	是	接单时段
 ISV_OSM_Longitude	是	私教经度
 ISV_OSM_Latitude	是	私教纬度
 
 返回说明Json：
 {
 "errmsg": 10028,
 "succeed": true,
 "MsgTime": "2015-10-10T15:36:08.8791434+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，接单模式开启成功false，接单模式开启失败
 errmsg	操作完成后返回信息	接单模式开启失败 = 10027,
 接单模式开启成功 = 10028,
 接单模式开启异常 = 10029
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	无	null
 */
//#pragma mark - 私教开启接单模式
//+ (void)startOrderModeWithOrderDuration:(NSArray *)ISV_OSM_OrderDuration success:(RespondBlock)success failure:(ErrorBlock)failure
//{
//#warning 需从定位模块获取
//    NSString *ISV_OSM_Longitude = @"113.27";
//    NSString *ISV_OSM_Latitude = @"23.13";
//    
//    NSString *url = [NSString stringWithFormat:@"%@/%@", START_ORDER_MODE, [ISVNetworking token]];
//    NSDictionary *param = NSDictionaryOfVariableBindings(ISV_OSM_OrderDuration, ISV_OSM_Longitude, ISV_OSM_Latitude);
//    
//    [self postWithURL:url params:param success:^(id respondData) {
//        success(respondData);
//    } failure:^(ISVErrorModel *error) {
//        failure(error);
//    }];
//}

/*
 12.私教操作订单
 网址：http://192.168.1.238:5000/trainer/trainerorder?key=&orderId=&isReceive=true
 类型：post
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 orderId	是	订单号
 isReceive	是	接受或者取消
 
 返回说明Json：
 {
 "errmsg": 10039,
 "succeed": true,
 "MsgTime": "2015-10-10T17:20:39.3777891+08:00",
 "valuse": {
 "orderId": "201510101720393305623"
 }
 }
 
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，用户实体获取成功false，用户实体获取失败
 errmsg	操作完成后返回信息	APP端私教接受订单成功提醒用户付款 = 10048,
 WAP端私教接受订单成功 = 10049,
 APP端私教取消订单成功 = 10050,
 WAP端私教取消订单成功申请退款 = 10051,
 私教操作订单异常 = 10052,
 预定项目不能为空 = 10053,
 预定时间不能为空 = 10054,
 手机号不能为空 = 10055,
 手机号不是11位数或者不全是数字 = 10056,
 服务地址不能为空 = 10057
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse.orderId	订单号	201510101720393305623
 */
#pragma mark - 私教操作订单
+ (void)coachDealOrderWithOrderId:(NSString *)ID yesOrNot:(BOOL)yOrN success:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *key = [self token];
    NSNumber *yesOrNot = @(yOrN);
    NSString *whichFunc = COACH_OPERATEORDER_PT;
    NSDictionary *param = NSDictionaryOfVariableBindings(key, ID, yesOrNot, whichFunc);
    
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

/**
 *  `私教获取私教被约订单`
 */
+ (void)coachOrderByAppointWithOrderId:(NSString *)orderId
                                  page:(NSUInteger)page
                                 count:(NSUInteger)count
                                  year:(NSUInteger)year
                                 month:(NSUInteger)month
                               success:(RespondBlock)success
                               failure:(ErrorBlock)failure
{

    // 根据key拼接url
    NSString *url = [NSString stringWithFormat:@"%@?type=trainer&year=%zd&month=%zd&page=%zd&count=%zd&key=%@",COACH_ORDER, year, month, page, count, [self token]];
    
    [self getWithURL:url success:^(id respondData) {
        ! success ? : success(respondData);
    } failure:^(ISVErrorModel *error) {
        ! failure ? : failure(error);
    }];
}

/**
 *  `私教小屋图片和视频管理`
 */
+ (void)coachImgOrVedioManagerWithId:(NSString *)Id
                                type:(NSString *)type
                              models:(NSArray *)model
                             success:(RespondBlock)success
                             failure:(ErrorBlock)failure
{
    NSString *key = [self token];
    NSString *whichFunc = COACH_PTWOODMANAGE;
    NSDictionary *param = NSDictionaryOfVariableBindings(key, Id, type, model, whichFunc);
    
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}


/**
 *  `143.获取图片或者视频`
 */
+ (void)coachGetImgOrVedioWithUserId:(NSString *)UserId
                                type:(NSString *)type
                                page:(NSUInteger)page
                                count:(NSUInteger)count
                             success:(RespondBlock)success
                             failure:(ErrorBlock)failure
{
    if (UserId == nil) {
        UserId = @"";
    }
    // 根据key拼接url
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&user_id=%@&type=%@&page=%zd&count=%zd",COACH_MOREWOODINFO, [self token], UserId, type, page, count];
    
    [self getWithURL:url success:^(id respondData) {
        ! success ? : success(respondData);
    } failure:^(ISVErrorModel *error) {
        ! failure ? : failure(error);
    }];
}

/**
 *  `119.私教小屋顶部背景图片管理`
 */
+ (void)coachCoverUploadWithCode:(NSString *)Id
                         success:(RespondBlock)success
                         failure:(ErrorBlock)failure
{
    NSString *key = [self token];
    NSString *whichFunc = COACH_PTWOODTOPIMG;
    NSDictionary *param = NSDictionaryOfVariableBindings(key, Id, whichFunc);
    
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}


/**
 *  私教团队
 */
+ (void)coashTeamWithPage:(NSUInteger)page count:(NSUInteger)count success:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&page=%zd&count=%zd",COASH_TEAM,self.token, page, count];
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

/**
 *  私教看用户约自己的订单列表时：
 */
+ (void)coachCourseOrderListWithPage:(NSInteger)page count:(NSInteger)count courseID:(NSString *)courseID type:(NSString *)type success:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *key = [self token];
    NSString *Which = @"trainer";
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&page=%zd&count=%zd&type=%@&groupbuy_id=%@&Which=%@",getCourseOrderList,key,page,count,type,courseID,Which];
    
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

/**
 * `获取课程订单详情 142`
 */
+ (void)coachCourseOrderDetailWithOrderdID:(NSString *)orderdID success:(RespondBlock)success failure:(ErrorBlock)failure
{
    // 根据key拼接url
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&grouporder_id=%@", COACH_CourseOrderDetail, [self token], orderdID];
    
    [self getWithURL:url success:^(id respondData) {
        ! success ? : success(respondData);
    } failure:^(ISVErrorModel *error) {
        ! failure ? : failure(error);
    }];
}
#pragma mark - 拉取商品
//##########################################################---拉取商品----###########################################################//

/*
 23-26拉取商品--逻辑分析
 1.按照不同条件获取商品，type=ALL时，获取商品分类cid下所有商品，type=ALLWITHOUTPT时，获取商品分类cid下，滤过私教已选取的商品，type=PT时，获取私教选取的商品，type=SEARCH时，按商品名称模糊搜索商品；
 2.这四种条件下获取的商品包括淘宝商品和便掌柜商品，它们分页显示，page为第几页，count为每页商品数量；
 3.
 4.由于新旧版匹配问题，验证用户登录的key目前暂时用于传用户id这个参数。
 23.获取cid下所有商品
 网址：http://192.168.1.238:5000/total/TotalProduct?key=&cid=&type=ALL&page=&count=
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是(暂时否)	用户登录后返回的token
 cid	是	商品所属分类id
 type	是	不同条件下获取商品的标识
 page	是	第几页
 count	是	每页商品数量
 
 返回说明Json：
 {
 "errmsg": 10207,
 "succeed": true,
 "MsgTime": "2015-10-15T20:49:31.8876385+08:00",
 "valuse": 以下是count为4时的拉取例子
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，产品拉取成功，false，无产品数据
 errmsg	操作完成后返回信息	产品拉取成功 = 10207,
 无产品数据 = 10208,
 拉取数据异常 = 10209
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	返回商品信息	以下是count为4时的拉取例子
 [
 {
 "totalp_id": "5xfir23v",
 "totalp_title": "阿胶糕450g/盒（新版粉铁）",
 "totalp_marketprice": 220,
 "totalp_price": 220,
 "totalp_istaobao": false,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":2307,\"ISV_product_id\":\"5xfir23v\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FvMoZ4fn93s5QJGJdMtWmxrQ0rpB?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FvMoZ4fn93s5QJGJdMtWmxrQ0rpB\"},{\"id\":2308,\"ISV_product_id\":\"5xfir23v\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FrIL3iPOvh2QmEHn22q3sS5NPPjF?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FrIL3iPOvh2QmEHn22q3sS5NPPjF\"},{\"id\":2309,\"ISV_product_id\":\"5xfir23v\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/Fs_ZCWpU0A9en1FOJwkuKYU-9a5j?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|Fs_ZCWpU0A9en1FOJwkuKYU-9a5j\"},{\"id\":2310,\"ISV_product_id\":\"5xfir23v\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/Fkuc_SIE-6mzaaC4WTSyc5OP3fhc?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|Fkuc_SIE-6mzaaC4WTSyc5OP3fhc\"}]",
 "totalp_commissionrate": 10,
 "totalp_mainurl": "http://7xl05m.com2.z0.glb.qiniucdn.com/FvMoZ4fn93s5QJGJdMtWmxrQ0rpB?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@"
 },
 {
 "totalp_id": "5xfjdj97",
 "totalp_title": "朴雪乳酸亚铁口服液10ml*90支",
 "totalp_marketprice": 109,
 "totalp_price": 109,
 "totalp_istaobao": false,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":1998,\"ISV_product_id\":\"5xfjdj97\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FpbVZtGcVlue2qgTi4ig4KOK3aRL?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FpbVZtGcVlue2qgTi4ig4KOK3aRL\"},{\"id\":1997,\"ISV_product_id\":\"5xfjdj97\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FsN_yMUFG99-5gySdCDSZv4hSlX9?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FsN_yMUFG99-5gySdCDSZv4hSlX9\"},{\"id\":1999,\"ISV_product_id\":\"5xfjdj97\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FvZV0wvd_HNxVkMxHSmiy43rHDkt?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FvZV0wvd_HNxVkMxHSmiy43rHDkt\"}]",
 "totalp_commissionrate": 0,
 "totalp_mainurl": "http://7xl05m.com2.z0.glb.qiniucdn.com/FsN_yMUFG99-5gySdCDSZv4hSlX9?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@"
 },
 {
 "totalp_id": "522023829288",
 "totalp_title": "【买3送1】固本堂大颗粒枸杞阿胶糕300g东阿即食阿胶固元膏",
 "totalp_marketprice": 168,
 "totalp_price": 99,
 "totalp_istaobao": true,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":\"0\",\"position\":\"0\",\"url\":\"http://img01.taobaocdn.com/bao/uploaded/i1/TB1OwdnJXXXXXXxXVXXXXXXXXXX_!!0-item_pic.jpg\"},{\"id\":\"108677255910\",\"position\":\"1\",\"url\":\"http://img02.taobaocdn.com/bao/uploaded/i2/765044778/TB2bRdBfpXXXXXfXXXXXXXXXXXX_!!765044778.jpg\"},{\"id\":\"108677255911\",\"position\":\"2\",\"url\":\"http://img03.taobaocdn.com/bao/uploaded/i3/765044778/TB25y..fXXXXXbLXpXXXXXXXXXX_!!765044778.jpg\"},{\"id\":\"108677255912\",\"position\":\"3\",\"url\":\"http://img01.taobaocdn.com/bao/uploaded/i1/765044778/TB25b0ifpXXXXXeXpXXXXXXXXXX_!!765044778.jpg\"}]",
 "totalp_commissionrate": 0.06999999999999999,
 "totalp_mainurl": "http://img01.taobaocdn.com/bao/uploaded/i1/TB1OwdnJXXXXXXxXVXXXXXXXXXX_!!0-item_pic.jpg"
 },
 {
 "totalp_id": "522023737065",
 "totalp_title": "【买3送1】东阿镇固本堂大颗粒传统阿胶糕300g固元膏即食ejiao",
 "totalp_marketprice": 168,
 "totalp_price": 99,
 "totalp_istaobao": true,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":\"0\",\"position\":\"0\",\"url\":\"http://img02.taobaocdn.com/bao/uploaded/i2/TB1xfNaJFXXXXa6XpXXXXXXXXXX_!!0-item_pic.jpg\"},{\"id\":\"107316874475\",\"position\":\"1\",\"url\":\"http://img03.taobaocdn.com/bao/uploaded/i3/765044778/TB2TWc_fXXXXXbYXpXXXXXXXXXX_!!765044778.jpg\"},{\"id\":\"107316874476\",\"position\":\"2\",\"url\":\"http://img04.taobaocdn.com/bao/uploaded/i4/765044778/TB2zDtnfpXXXXcoXXXXXXXXXXXX_!!765044778.jpg\"},{\"id\":\"107316874477\",\"position\":\"3\",\"url\":\"http://img03.taobaocdn.com/bao/uploaded/i3/765044778/TB2NippfpXXXXa9XXXXXXXXXXXX_!!765044778.jpg\"}]",
 "totalp_commissionrate": 0.06999999999999999,
 "totalp_mainurl": "http://img02.taobaocdn.com/bao/uploaded/i2/TB1xfNaJFXXXXa6XpXXXXXXXXXX_!!0-item_pic.jpg"
 }
 ]
 */








/*
 24.获取cid下，滤过私教已经选取的商品
 网址：http://192.168.1.238:5000/total/TotalProduct?key=&cid=&type=ALLWITHOUTPT&page=&count=
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 cid	是	商品所属分类id
 type	是	不同条件下获取商品的标识
 page	是	第几页
 count	是	每页商品数量
 
 返回说明Json：
 {
 "errmsg": 10207,
 "succeed": true,
 "MsgTime": "2015-10-15T20:49:31.8876385+08:00",
 "valuse": 以下是count为4时的拉取例子
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，产品拉取成功，false，无产品数据
 errmsg	操作完成后返回信息	产品拉取成功 = 10207,
 无产品数据 = 10208,
 拉取数据异常 = 10209
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	返回商品信息	以下是count为4时的拉取例子
 [
 {
 "totalp_id": "5xfir23v",
 "totalp_title": "阿胶糕450g/盒（新版粉铁）",
 "totalp_marketprice": 220,
 "totalp_price": 220,
 "totalp_istaobao": false,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":2307,\"ISV_product_id\":\"5xfir23v\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FvMoZ4fn93s5QJGJdMtWmxrQ0rpB?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FvMoZ4fn93s5QJGJdMtWmxrQ0rpB\"},{\"id\":2308,\"ISV_product_id\":\"5xfir23v\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FrIL3iPOvh2QmEHn22q3sS5NPPjF?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FrIL3iPOvh2QmEHn22q3sS5NPPjF\"},{\"id\":2309,\"ISV_product_id\":\"5xfir23v\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/Fs_ZCWpU0A9en1FOJwkuKYU-9a5j?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|Fs_ZCWpU0A9en1FOJwkuKYU-9a5j\"},{\"id\":2310,\"ISV_product_id\":\"5xfir23v\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/Fkuc_SIE-6mzaaC4WTSyc5OP3fhc?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|Fkuc_SIE-6mzaaC4WTSyc5OP3fhc\"}]",
 "totalp_commissionrate": 10,
 "totalp_mainurl": "http://7xl05m.com2.z0.glb.qiniucdn.com/FvMoZ4fn93s5QJGJdMtWmxrQ0rpB?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@"
 },
 {
 "totalp_id": "5xfjdj97",
 "totalp_title": "朴雪乳酸亚铁口服液10ml*90支",
 "totalp_marketprice": 109,
 "totalp_price": 109,
 "totalp_istaobao": false,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":1998,\"ISV_product_id\":\"5xfjdj97\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FpbVZtGcVlue2qgTi4ig4KOK3aRL?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FpbVZtGcVlue2qgTi4ig4KOK3aRL\"},{\"id\":1997,\"ISV_product_id\":\"5xfjdj97\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FsN_yMUFG99-5gySdCDSZv4hSlX9?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FsN_yMUFG99-5gySdCDSZv4hSlX9\"},{\"id\":1999,\"ISV_product_id\":\"5xfjdj97\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FvZV0wvd_HNxVkMxHSmiy43rHDkt?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FvZV0wvd_HNxVkMxHSmiy43rHDkt\"}]",
 "totalp_commissionrate": 0,
 "totalp_mainurl": "http://7xl05m.com2.z0.glb.qiniucdn.com/FsN_yMUFG99-5gySdCDSZv4hSlX9?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@"
 },
 {
 "totalp_id": "522023829288",
 "totalp_title": "【买3送1】固本堂大颗粒枸杞阿胶糕300g东阿即食阿胶固元膏",
 "totalp_marketprice": 168,
 "totalp_price": 99,
 "totalp_istaobao": true,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":\"0\",\"position\":\"0\",\"url\":\"http://img01.taobaocdn.com/bao/uploaded/i1/TB1OwdnJXXXXXXxXVXXXXXXXXXX_!!0-item_pic.jpg\"},{\"id\":\"108677255910\",\"position\":\"1\",\"url\":\"http://img02.taobaocdn.com/bao/uploaded/i2/765044778/TB2bRdBfpXXXXXfXXXXXXXXXXXX_!!765044778.jpg\"},{\"id\":\"108677255911\",\"position\":\"2\",\"url\":\"http://img03.taobaocdn.com/bao/uploaded/i3/765044778/TB25y..fXXXXXbLXpXXXXXXXXXX_!!765044778.jpg\"},{\"id\":\"108677255912\",\"position\":\"3\",\"url\":\"http://img01.taobaocdn.com/bao/uploaded/i1/765044778/TB25b0ifpXXXXXeXpXXXXXXXXXX_!!765044778.jpg\"}]",
 "totalp_commissionrate": 0.06999999999999999,
 "totalp_mainurl": "http://img01.taobaocdn.com/bao/uploaded/i1/TB1OwdnJXXXXXXxXVXXXXXXXXXX_!!0-item_pic.jpg"
 },
 {
 "totalp_id": "522023737065",
 "totalp_title": "【买3送1】东阿镇固本堂大颗粒传统阿胶糕300g固元膏即食ejiao",
 "totalp_marketprice": 168,
 "totalp_price": 99,
 "totalp_istaobao": true,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":\"0\",\"position\":\"0\",\"url\":\"http://img02.taobaocdn.com/bao/uploaded/i2/TB1xfNaJFXXXXa6XpXXXXXXXXXX_!!0-item_pic.jpg\"},{\"id\":\"107316874475\",\"position\":\"1\",\"url\":\"http://img03.taobaocdn.com/bao/uploaded/i3/765044778/TB2TWc_fXXXXXbYXpXXXXXXXXXX_!!765044778.jpg\"},{\"id\":\"107316874476\",\"position\":\"2\",\"url\":\"http://img04.taobaocdn.com/bao/uploaded/i4/765044778/TB2zDtnfpXXXXcoXXXXXXXXXXXX_!!765044778.jpg\"},{\"id\":\"107316874477\",\"position\":\"3\",\"url\":\"http://img03.taobaocdn.com/bao/uploaded/i3/765044778/TB2NippfpXXXXa9XXXXXXXXXXXX_!!765044778.jpg\"}]",
 "totalp_commissionrate": 0.06999999999999999,
 "totalp_mainurl": "http://img02.taobaocdn.com/bao/uploaded/i2/TB1xfNaJFXXXXa6XpXXXXXXXXXX_!!0-item_pic.jpg"
 }
 ]
 */







/*
 25获取私教选取商品
 网址：http://192.168.1.238:5000/total/TotalProduct?key=&cid=&type=PT&page=&count=
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是(key当用户id用)	用户登录后返回的token
 cid	是	商品所属分类id
 type	是	不同条件下获取商品的标识
 page	是	第几页
 count	是	每页商品数量
 
 返回说明Json：
 {
 "errmsg": 10207,
 "succeed": true,
 "MsgTime": "2015-10-15T20:49:31.8876385+08:00",
 "valuse": 以下是count为4时的拉取例子
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，产品拉取成功，false，无产品数据
 errmsg	操作完成后返回信息	产品拉取成功 = 10207,
 无产品数据 = 10208,
 拉取数据异常 = 10209
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	返回商品信息	以下是count为4时的拉取例子
 [
 {
 "totalp_id": "46ahl45e",
 "totalp_title": "日本花王纸尿裤S82片",
 "totalp_marketprice": 115,
 "totalp_price": 115,
 "totalp_istaobao": false,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":1321,\"ISV_product_id\":\"46ahl45e\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FopcXMCe_KFwZNpPNZ43we4UvfWR?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FopcXMCe_KFwZNpPNZ43we4UvfWR\"},{\"id\":1322,\"ISV_product_id\":\"46ahl45e\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/Ft3zoi0PKYI5mTJhLTsLnna-aZed?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|Ft3zoi0PKYI5mTJhLTsLnna-aZed\"},{\"id\":1323,\"ISV_product_id\":\"46ahl45e\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FvRjT66_F9C-ZJA_7vU1MfqeDSRz?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FvRjT66_F9C-ZJA_7vU1MfqeDSRz\"},{\"id\":1324,\"ISV_product_id\":\"46ahl45e\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/Fgf9tZS1HmdbjtxSSWfJ1SkrSAxt?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|Fgf9tZS1HmdbjtxSSWfJ1SkrSAxt\"}]",
 "totalp_commissionrate": 0,
 "totalp_mainurl": "http://7xl05m.com2.z0.glb.qiniucdn.com/FopcXMCe_KFwZNpPNZ43we4UvfWR?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@"
 },
 {
 "totalp_id": "2f5k60qh",
 "totalp_title": "日本Dr.scholl爽健QTTO瘦腿袜秋冬款外出健美裤-黑色M",
 "totalp_marketprice": 112,
 "totalp_price": 112,
 "totalp_istaobao": false,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":1361,\"ISV_product_id\":\"2f5k60qh\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FtQMpUKsoZwbVW3cqNex5BwXHUdp?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FtQMpUKsoZwbVW3cqNex5BwXHUdp\"},{\"id\":1362,\"ISV_product_id\":\"2f5k60qh\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FhicrZhbMqGOGtj79JhIGaVsenoy?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FhicrZhbMqGOGtj79JhIGaVsenoy\"},{\"id\":1363,\"ISV_product_id\":\"2f5k60qh\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/Fg24FbL_ozNICS4m8cvegwe2q6ky?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|Fg24FbL_ozNICS4m8cvegwe2q6ky\"}]",
 "totalp_commissionrate": 0,
 "totalp_mainurl": "http://7xl05m.com2.z0.glb.qiniucdn.com/FtQMpUKsoZwbVW3cqNex5BwXHUdp?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@"
 },
 {
 "totalp_id": "9912953516",
 "totalp_title": "十二花香新鲜蜂王浆 纯净天然油菜早春蜂皇浆农家自产【买1送1】",
 "totalp_marketprice": 286,
 "totalp_price": 218.02,
 "totalp_istaobao": true,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":\"0\",\"position\":\"0\",\"url\":\"http://img03.taobaocdn.com/bao/uploaded/i3/T1_pc8Fb0dXXXXXXXX_!!0-item_pic.jpg\"},{\"id\":\"1261784332\",\"position\":\"1\",\"url\":\"http://img04.taobaocdn.com/bao/uploaded/i4/TB1iAMNGXXXXXczaXXXXXXXXXXX_!!0-item_pic.jpg\"},{\"id\":\"1261784348\",\"position\":\"2\",\"url\":\"http://img04.taobaocdn.com/bao/uploaded/i4/674716091/TB2r9oNcFXXXXXGXFXXXXXXXXXX_!!674716091.jpg\"},{\"id\":\"1261784364\",\"position\":\"3\",\"url\":\"http://img02.taobaocdn.com/bao/uploaded/i2/674716091/TB2TvZ2cFXXXXckXpXXXXXXXXXX_!!674716091.jpg\"},{\"id\":\"1276486060\",\"position\":\"4\",\"url\":\"http://img04.taobaocdn.com/bao/uploaded/i4/674716091/TB2.2.4cFXXXXbyXpXXXXXXXXXX_!!674716091.jpg\"}]",
 "totalp_commissionrate": 0.03666666666666667,
 "totalp_mainurl": "http://img03.taobaocdn.com/bao/uploaded/i3/T1_pc8Fb0dXXXXXXXX_!!0-item_pic.jpg"
 },
 {
 "totalp_id": "43259916971",
 "totalp_title": "福赐德 2015年鲜蜂皇浆正品农家蜂王浆王 油菜蜜百花蜜蜂王浆250g",
 "totalp_marketprice": 338,
 "totalp_price": 169,
 "totalp_istaobao": true,
 "totalp_iscrossborder": false,
 "totalp_images": "[{\"id\":\"0\",\"position\":\"0\",\"url\":\"http://img02.taobaocdn.com/bao/uploaded/i2/TB1nQ9IHXXXXXXdaXXXXXXXXXXX_!!0-item_pic.jpg\"},{\"id\":\"17303082882\",\"position\":\"1\",\"url\":\"http://img01.taobaocdn.com/bao/uploaded/i1/1105033556/TB2JNm9bFXXXXbLXXXXXXXXXXXX_!!1105033556.jpg\"},{\"id\":\"17303082883\",\"position\":\"2\",\"url\":\"http://img03.taobaocdn.com/bao/uploaded/i3/1105033556/TB27.y2bFXXXXXOXpXXXXXXXXXX_!!1105033556.jpg\"},{\"id\":\"17303082884\",\"position\":\"3\",\"url\":\"http://img01.taobaocdn.com/bao/uploaded/i1/1105033556/TB2jcoAbpXXXXbtXpXXXXXXXXXX_!!1105033556.jpg\"}]",
 "totalp_commissionrate": 0.03666666666666667,
 "totalp_mainurl": "http://img02.taobaocdn.com/bao/uploaded/i2/TB1nQ9IHXXXXXXdaXXXXXXXXXXX_!!0-item_pic.jpg"
 }
 ]
 */







/*
 26按商品名称模糊搜索商品
 网址：http://192.168.1.238:5000/total/TotalProduct?key=&cid=&type=SEARCH&page=&count=
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是(暂时否)	用户登录后返回的token
 cid	是	用于模糊搜索的商品名称，名称分大小写
 type	是	不同条件下获取商品的标识
 page	是	第几页
 count	是	每页商品数量
 
 返回说明Json：
 {
 "errmsg": 10207,
 "succeed": true,
 "MsgTime": "2015-10-15T20:49:31.8876385+08:00",
 "valuse": 以下是count为4时的拉取例子
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，产品拉取成功，false，无产品数据
 errmsg	操作完成后返回信息	产品拉取成功 = 10207,
 无产品数据 = 10208,
 拉取数据异常 = 10209
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	返回商品信息	以下是count为4时的拉取例子
 [
 {
 "totalp_id": "o0jbbbs",
 "totalp_title": "NatureWise 绿咖啡豆提取物， 800毫克， 60粒，美国原装。",
 "totalp_marketprice": 159,
 "totalp_price": 159,
 "totalp_istaobao": false,
 "totalp_iscrossborder": true,
 "totalp_images": "[{\"id\":1482,\"ISV_product_id\":\"o0jbbbs\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/Ft2qRfadZXE90t4tXdTFbMbn_VZ-?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|Ft2qRfadZXE90t4tXdTFbMbn_VZ-\"},{\"id\":1483,\"ISV_product_id\":\"o0jbbbs\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FufIKOneuR8BoH9uhNDBeYMsAUlm?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FufIKOneuR8BoH9uhNDBeYMsAUlm\"},{\"id\":1484,\"ISV_product_id\":\"o0jbbbs\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FhzMNIo5T_sH7yc47WCCALLRIq8i?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FhzMNIo5T_sH7yc47WCCALLRIq8i\"},{\"id\":1485,\"ISV_product_id\":\"o0jbbbs\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/Fo37bv-8wCwLOurWVCRgFOtLXjb-?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|Fo37bv-8wCwLOurWVCRgFOtLXjb-\"},{\"id\":1486,\"ISV_product_id\":\"o0jbbbs\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FpCi8Iz8FwbX5MSOv8IU6nMIsNnb?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FpCi8Iz8FwbX5MSOv8IU6nMIsNnb\"}]",
 "totalp_commissionrate": 0,
 "totalp_mainurl": "http://7xl05m.com2.z0.glb.qiniucdn.com/Ft2qRfadZXE90t4tXdTFbMbn_VZ-?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@"
 },
 {
 "totalp_id": "2f5ix2jd",
 "totalp_title": "NatureWise超纯绿咖啡豆提取物，600毫克，90粒，美国原装。",
 "totalp_marketprice": 189,
 "totalp_price": 189,
 "totalp_istaobao": false,
 "totalp_iscrossborder": true,
 "totalp_images": "[{\"id\":1487,\"ISV_product_id\":\"2f5ix2jd\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FtNAAr2aYXUEK7Q4dQmwWY3bg0vD?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FtNAAr2aYXUEK7Q4dQmwWY3bg0vD\"},{\"id\":1488,\"ISV_product_id\":\"2f5ix2jd\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FpPY3_W3gQ1ATuK2OcNTfggooJP-?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FpPY3_W3gQ1ATuK2OcNTfggooJP-\"},{\"id\":1489,\"ISV_product_id\":\"2f5ix2jd\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FnJhvJuHMc41jI_cC8G-eoFeke2v?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FnJhvJuHMc41jI_cC8G-eoFeke2v\"},{\"id\":1490,\"ISV_product_id\":\"2f5ix2jd\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FgG2LLBJZbwumKdFcsZEnuLeZ63Z?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FgG2LLBJZbwumKdFcsZEnuLeZ63Z\"},{\"id\":1491,\"ISV_product_id\":\"2f5ix2jd\",\"url\":\"http://7xl05m.com2.z0.glb.qiniucdn.com/FtamE4doZmUHJf9XbkjFVl6eGCpF?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@\",\"img\":\"qn|xaya|FtamE4doZmUHJf9XbkjFVl6eGCpF\"}]",
 "totalp_commissionrate": 0,
 "totalp_mainurl": "http://7xl05m.com2.z0.glb.qiniucdn.com/FtNAAr2aYXUEK7Q4dQmwWY3bg0vD?imageView2/2/w/480/q/95/@w/$w$@/@h/$h$@"
 }
 ]
 */
//##########################################################---拉取商品----###########################################################//



/*
 4.2.2 点击更多跳转该私教的商品列表
 功能实现要求：列表app调用接口返回数据，实现商品列表展示。点击某个商品，进入商品详情页面（web）。
 
 http://shop.hdshl.com/product/product_list/?educationID=123456
 
 参数说明：
 输入参数	说明	必填	类型
 educationID	私教ID 	是	String
 
 */

@end
