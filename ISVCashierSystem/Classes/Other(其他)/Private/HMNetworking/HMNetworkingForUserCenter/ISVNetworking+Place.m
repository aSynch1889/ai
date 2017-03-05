//
//  ISVNetworking+Place.m
//  ISV
//
//  Created by ISV005 on 15/12/22.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVNetworking+Place.h"

@implementation ISVNetworking (Place)


/*
 掌柜相关↓
 100.掌柜入驻（申请或信息修改）
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI1OTczNDE2MyIsImlhdCI6MTQ1MDE1MTY2OSwianRpIjpmYWxzZX0.WxnlFUZklSUkcCRbwLEunz6_vVoP0iOgb0EReIi81Bg",
 "model":{
 "venue_id":"V999999999",
 "ISV_vi_licenceno":"123456789",
 "ISV_vi_idcard":"440802199303112666",
 "ISV_vi_name":"神龙科技999",
 "ISV_vi_invitecode":"999999",
 "ISV_vi_certificateimages":{"LicenceNo":["img1","img2"],"IDCard":["img1","img2","img3"],"ClientScans":["img1"],"ClientIDCard":["img1","img2","img3"]},
 "ISV_vi_venueimages":["img1","img2","img3","img4","img5","img6"],
 "ISV_vi_venuename":"科技之都999",
 "ISV_vi_opentime":"08:00",
 "ISV_vi_closetime":"22:00",
 "ISV_vi_coordinate":{"ISV_venue_lat": 123, "ISV_venue_lng": 123},
 "ISV_vi_address":"广东省广州市天河体育馆999",
 "ISV_vi_phone":"15920455966",
 "ISV_vi_mobile":"0759-3285990",
 "ISV_vi_introduction":"科技健身999",
 "ISV_vi_venuetype":1,
 "ISV_vi_specialservices":{"WIFI":false,"Bath":true,"POS":true,"Store":true,"Parking":true,"Invoice":true,"RestArea":true,"Sale":false,"SportsShop":false},
 "ISV_venue_programcontent":[{"venueprogram_id":2,"ISV_vpc_workdayprice":100.00,"ISV_vpc_weekendprice":200.00,"ISV_vpc_bookabletime":{"childVenueNo1": {"1": {"6":100.00,"7":100.00,"8":100.00}, "2": {"6":100.00,"7":100.00,"8":100.00}, "3": {"6":100.00,"7":100.00,"8":100.00}, "4": {"6":100.00,"7":100.00,"8":100.00}, "5": {"6":100.00,"7":100.00,"8":100.00}},"childVenueNo2": {"1": {"6":100.00,"7":100.00,"8":100.00}, "2": {"6":100.00,"7":100.00,"8":100.00}, "3": {"6":100.00,"7":100.00,"8":100.00}, "4": {"6":100.00,"7":100.00,"8":100.00}, "5": {"6":100.00,"7":100.00,"8":100.00}},"childVenueNo3": {"1": {"6":100.00,"7":100.00,"8":100.00}, "2": {"6":100.00,"7":100.00,"8":100.00}, "3": {"6":100.00,"7":100.00,"8":100.00}, "4": {"6":100.00,"7":100.00,"8":100.00}, "5": {"6":100.00,"7":100.00,"8":100.00}}}}
	{"venueprogram_id":2,"ISV_vpc_workdayprice":100.00,"ISV_vpc_weekendprice":200.00,"ISV_vpc_bookabletime":{"childVenueNo1": {"1": {"6":100.00,"7":100.00,"8":100.00}, "2": {"6":100.00,"7":100.00,"8":100.00}, "3": {"6":100.00,"7":100.00,"8":100.00}, "4": {"6":100.00,"7":100.00,"8":100.00}, "5": {"6":100.00,"7":100.00,"8":100.00}},"childVenueNo2": {"1": {"6":100.00,"7":100.00,"8":100.00}, "2": {"6":100.00,"7":100.00,"8":100.00}, "3": {"6":100.00,"7":100.00,"8":100.00}, "4": {"6":100.00,"7":100.00,"8":100.00}, "5": {"6":100.00,"7":100.00,"8":100.00}},"childVenueNo3": {"1": {"6":100.00,"7":100.00,"8":100.00}, "2": {"6":100.00,"7":100.00,"8":100.00}, "3": {"6":100.00,"7":100.00,"8":100.00}, "4": {"6":100.00,"7":100.00,"8":100.00}, "5": {"6":100.00,"7":100.00,"8":100.00}}}}]
 },
 "whichFunc":"ADDVENUE"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 venue_id	否	掌柜ID(添加时不用传)
 ISV_vi_licenceno	是	营业执照注册号
 ISV_vi_idcard	是	身份证号
 ISV_vi_name	是	法人或代理人姓名
 ISV_vi_invitecode	是	便提供的邀请码
 ISV_vi_certificateimages	是	相关证件图片(LicenceNo：证件照片，IDCard：身份证，ClientScans:委托人照片，ClientIDCard：委托人身份证)

 ISV_vi_venueimages	是	掌柜图片
 ISV_vi_venuename	是	掌柜名称
 ISV_vi_opentime	是	营业开始时间
 ISV_vi_closetime	是	营业结束时间
 ISV_vi_coordinate	是	掌柜坐标
 ISV_vi_address	是	掌柜地址
 ISV_vi_phone	二选一	掌柜电话
 ISV_vi_mobile		掌柜手机
 ISV_vi_introduction	否	掌柜简介
 ISV_vi_venuetype	是	1：社区掌柜，2：非社区掌柜，暂定两个，要改的时候再加，然后这个字段只需要后台查看

 ISV_vi_specialservices	否	特色服务
 ISV_venue_programcontent	是	掌柜项目信息json（venue_id：掌柜ID添加时传-1，venueprogram_id：项目ID，ISV_vpc_workdayprice：工作日价格，ISV_vpc_weekendprice：周未价格，ISV_vpc_bookabletime：可预订时间段价格{"childVenueNo1:场地1：{"1":星期一{"6":6点：100.00：价格}}"}）
 whichFunc	是	决定调哪一个接口

 返回说明Json：
 {
 "errmsg": 10505,
 "succeed": true,
 "MsgTime": "2015-12-08T01:45:27.2748213+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，操作成功，false，成功失败
 errmsg	操作完成后返回信息	掌柜信息保存失败 = 10506,
 掌柜入驻申请成功 = 10505,
 入驻申请请码不正确 = 10516，
 掌柜信息修改成功=10517，
 申请审核中不能修改信息=10539，
 请勿非掌柜主操作=10542，
 游客无操作权限=10263，
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-12-08T01:45:27.2748213+08:00
 valuse	无	null
 */

+ (void)userApplyPlaceWithPlaceId:(NSString *)venue_id
                   placeLicenceno:(NSString *)ISV_vi_licenceno
                placeLeagalIdcard:(NSString *)ISV_vi_idcard
                   placeLegalName:(NSString *)ISV_vi_name
                  placeInvitecode:(NSString *)ISV_vi_invitecode
           placeCertificateimages:(NSDictionary *)ISV_vi_certificateimages
                      placeImages:(NSMutableArray *)ISV_vi_venueimages
                        placeName:(NSString *)ISV_vi_venuename
                    placeOpentime:(NSString *)ISV_vi_opentime
                   placeClosetime:(NSString *)ISV_vi_closetime
                  placeCoordinate:(NSDictionary *)ISV_vi_coordinate
                     placeAddress:(NSString *)ISV_vi_address
                       placePhone:(NSString *)ISV_vi_phone
                      placeMobile:(NSString *)ISV_vi_mobile
                placeIntroduction:(NSString *)ISV_vi_introduction
                        placeType:(NSUInteger )ISV_vi_venuetype
             placeSpecialServices:(NSDictionary *)ISV_vi_specialservices
              placeProgramContent:(NSMutableArray *)ISV_venue_programcontent
                         cityCode:(NSString *)ISV_vi_city
                          success:(RespondBlock)success
                          failure:(ErrorBlock)failure{
    NSString *key = [self token];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    if ([venue_id isEqualToString:ISV_NULL]) {
        
    }else{
        [data setValue:venue_id forKey:@"venue_id"];
    }
    [data setValue:ISV_vi_licenceno forKey:@"ISV_vi_licenceno"];
    [data setValue:ISV_vi_idcard forKey:@"ISV_vi_idcard"];
    [data setValue:ISV_vi_name forKey:@"ISV_vi_name"];
    [data setValue:ISV_vi_invitecode forKey:@"ISV_vi_invitecode"];
    [data setValue:ISV_vi_certificateimages forKey:@"ISV_vi_certificateimages"];
    [data setValue:ISV_vi_venueimages forKey:@"ISV_vi_venueimages"];
    [data setValue:ISV_vi_venuename forKey:@"ISV_vi_venuename"];
    [data setValue:ISV_vi_opentime forKey:@"ISV_vi_opentime"];
    [data setValue:ISV_vi_closetime forKey:@"ISV_vi_closetime"];
    [data setValue:ISV_vi_coordinate forKey:@"ISV_vi_coordinate"];
    [data setValue:ISV_vi_address forKey:@"ISV_vi_address"];
    data[@"ISV_vi_city"] = ISV_vi_city;
    
    if (ISV_vi_phone.length > 0) {
        [data setValue:ISV_vi_phone forKey:@"ISV_vi_phone"];
    }
    if (ISV_vi_mobile.length > 0) {
        [data setValue:ISV_vi_mobile forKey:@"ISV_vi_mobile"];
    }
    [data setValue:ISV_vi_introduction forKey:@"ISV_vi_introduction"];
    [data setValue:[NSNumber numberWithInteger:ISV_vi_venuetype] forKey:@"ISV_vi_venuetype"];
    
    [data setValue:ISV_vi_specialservices forKey:@"ISV_vi_specialservices"];
    [data setValue:ISV_venue_programcontent forKey:@"ISV_venue_programcontent"];
    
    NSMutableDictionary *model = [[NSMutableDictionary alloc]init];
    model = data;
    NSString *whichFunc = @"ADDVENUE";
    
    NSDictionary *param = NSDictionaryOfVariableBindings(key,whichFunc,model);
    
    [ISVNetworking postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
    
}

/*
 101.掌柜列表筛选+排序+分页
 网址：
 http://192.168.1.238:5000/Venue/GetListforscreen?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI1OTczNDE2MyIsImlhdCI6MTQ1MDE1MTY2OSwianRpIjpmYWxzZX0.WxnlFUZklSUkcCRbwLEunz6_vVoP0iOgb0EReIi81Bg&page=1&count=10&type=nothot&sort=synthesize&itemid=4&desc=desc
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 Page	是	当前页
 Count	是	每页显示数量
 Type	是	热门（hot）推荐(nothot)
 Sorts	是	（ynthesize：综合排序 price：价格排序 distance：距离排序 score：评分排序 默认不传）


 返回说明Json：
 {
 "errmsg": 10518,
 "succeed": true,
 "MsgTime": "2015-12-12T16:16:27.6708935+08:00",
 "valuse": [
 {
 "venue_id": "V888888888",--掌柜ID
 "ISV_vi_licenceno": null,
 "ISV_vi_idcard": null,
 "ISV_vi_name": null,
 "ISV_vi_invitecode": null,
 "ISV_vi_certificateimages": null,
 "ISV_vi_venueimages": ["img1", "img2", "img3", "img4", "img5", "img6"],--掌柜图片
 "ISV_vi_venuename": "科技之都",--掌柜名称
 "ISV_vi_opentime": "0001-01-01T00:00:00",
 "ISV_vi_closetime": "0001-01-01T00:00:00",
 "ISV_vi_coordinate": {"ISV_venue_lat": 33, "ISV_venue_lng": 33},--掌柜座标
 "ISV_vi_address": null,
 "ISV_vi_phone": null,
 "ISV_vi_mobile": null,
 "ISV_vi_introduction": null,
 "ISV_vi_venuetype": 0,
 "ISV_vi_specialservices": null,
 "ISV_vi_applydate": "2015-12-11T01:11:51.807072",--申请时间
 "ISV_vi_auditstatus": 0,
 "ISV_vi_auditdate": "0001-01-01T00:00:00",
 "ISV_vi_score": 0,--评分
 "ISV_vi_reservecount": 0,--预订数
 "ISV_vi_isrecommend": true,--是否推荐掌柜
 "ISV_venue_programcontent": null,
 "distance": 9086.56785131583,--距离km
 "venueprogram_ids": ["2","6","4"],--掌柜项目
 "ISV_vi_programcontent": [{"venueprogram_id":2,"ISV_vpc_workdayprice":100.00,"ISV_vpc_weekendprice":200.00},{"venueprogram_id":6,"ISV_vpc_workdayprice":200.00,"ISV_vpc_weekendprice":300.00},{"venueprogram_id":4,"ISV_vpc_workdayprice":100.00,"ISV_vpc_weekendprice":200.00}],
 --项目内容  venueprogram_id--项目ID  ISV_vpc_workdayprice--工作日价格  ISV_vpc_weekendprice--平日价格
 "ISV_vi_maxprice": "300",--最大价格
 "ISV_vi_minprice": "100"--最小价格
 }
 ]
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	筛选掌柜列表成功=10518,
 筛选掌柜列表异常=10519,
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示支付方式列表的json数组	如上面参数所示

 */
#pragma mark ---------------约掌柜，掌柜筛选列表
// 升序 asc
// 降序 desc
+ (void)invitListWithPage:(NSUInteger)page count:(NSUInteger)count type:(NSString *)type sort:(NSString *)sort itemId:(NSString *)itemId sortType:(NSString *)sortType success:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&page=%@&count=%@&type=%@&sort=%@&itemid=%@&desc=%@",INVIT_LIST,self.token,@(page),@(count),type,sort,itemId, sortType];
    [self getWithURL:url success:^(id respondData) {

        success(respondData);
    } failure:^(ISVErrorModel *error) {

        failure(error);
    }];

}

/*
 103.获取掌柜详情
 网址：
 http://192.168.1.238:5000/Venue/GetModelInfo?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI1OTczNDE2MyIsImlhdCI6MTQ1MDE1MTY2OSwianRpIjpmYWxzZX0.WxnlFUZklSUkcCRbwLEunz6_vVoP0iOgb0EReIi81Bg&venue_id=V999999999
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 venue_id	是	掌柜ID

 返回说明Json：
 {
 "errmsg": 10524,
 "succeed": true,
 "MsgTime": "2015-12-12T18:15:29.5022067+08:00",
 "valuse": {
 "venue_id": "V999999999",--掌柜ID
 "ISV_vi_licenceno": null,
 "ISV_vi_idcard": null,
 "ISV_vi_name": null,
 "ISV_vi_invitecode": null,
 "ISV_vi_certificateimages": null,
 "ISV_vi_venueimages": ["img1", "img2", "img3", "img4", "img5", "img6"],--掌柜图片
 "ISV_vi_venuename": "科技之都",--掌柜名称
 "ISV_vi_opentime": "08:00:00",
 "ISV_vi_closetime": "22:00:00",
 "ISV_vi_coordinate": {"ISV_venue_lat": 22, "ISV_venue_lng": 22},--掌柜座标
 "ISV_vi_address": "广东省广州市天河体育馆",--掌柜地址
 "ISV_vi_phone": "010-88888888",--掌柜电话
 "ISV_vi_mobile": "18020909399",--掌柜手机
 "ISV_vi_introduction": "科技健身",--掌柜简介
 "ISV_vi_venuetype": 0,--1：社区掌柜，2：非社区掌柜，暂定两个，要改的时候再加，然后这个字段只需要后台查看
 "ISV_vi_specialservices": {"POS": true, "Bath": true, "Sale": false, "WIFI": false, "Store": true, "Invoice": true, "Parking": true, "RestArea": true, "SportsShop": false},--特色服务
 "ISV_vi_applydate": "0001-01-01T00:00:00",
 "ISV_vi_auditstatus": 0,
 "ISV_vi_auditdate": "0001-01-01T00:00:00",
 "ISV_vi_score": 0,--评分
 "ISV_vi_reservecount": 0,--预订数
 "ISV_vi_isrecommend": false,--是否推荐掌柜
 "ISV_venue_programcontent": null,--掌柜项目信息
 "distance": 10121.9670705359,--距离
 "venueprogram_ids": ["4","2","3"],--掌柜项目
 "ISV_vi_programcontent": null,
 "ISV_vi_maxprice": "300",--最大价格
 "ISV_vi_minprice": "4"--最小价格
 }
 }

 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取掌柜信息成功=10524,
 获取掌柜信息异常=10525,
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示掌柜详情的json数组	如上面参数所示

 */

+ (void)getPlaceDetailInfoWithVenueId:(NSString *)venue_id success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&venue_id=%@",getPlaceModelInfo,key,venue_id];
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}


/*

 104.获取掌柜项目列表
 网址：
 http://192.168.1.238:5000/Venue/GetItemList?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI1OTczNDE2MyIsImlhdCI6MTQ1MDE1MTY2OSwianRpIjpmYWxzZX0.WxnlFUZklSUkcCRbwLEunz6_vVoP0iOgb0EReIi81Bg
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token

 返回说明Json：
 {
 "errmsg": 10530,
 "succeed": true,
 "MsgTime": "2015-12-15T12:02:09.8181906+08:00",
 "valuse": [{
 "venueprogram_id": 1,--递增ID
 "ISV_vp_name": "跑步",--项目名称
 "ISV_vp_sort": 1,--排序字段
 "ISV_vp_level": 0,--等级
 "ISV_vp_parentid": 0,--父级ID
 "ISV_vp_image": ""--图片
 },．．．．．．]
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取掌柜项目列表成功=10530,
 获取掌柜项目列表异常=10531,
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示掌柜项目列表的json数组	如上面参数所示

 */

+ (void)getPlaceItemListSuccess:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:@"%@?key=%@",getPlaceItemList, key];
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];

}



/*
 105.根据项目ID查询掌柜列表
 网址：
 http://192.168.1.238:5000/Venue/GetListforitem?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI1OTczNDE2MyIsImlhdCI6MTQ1MDE1MTY2OSwianRpIjpmYWxzZX0.WxnlFUZklSUkcCRbwLEunz6_vVoP0iOgb0EReIi81Bg&venueprogram_id=1&page=1&count=10
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 venueprogram_id	是	项目ID
 Page	是	当前页
 Count	是	每页显示数量

 返回说明Json：
 {
 "errmsg": 10532,
 "succeed": true,
 "MsgTime": "2015-12-15T12:04:17.5970946+08:00",
 "valuse": [
 {
 "venue_id": "V834457183",--掌柜ID
 "ISV_vi_licenceno": null,
 "ISV_vi_idcard": null,
 "ISV_vi_name": null,
 "ISV_vi_invitecode": null,
 "ISV_vi_certificateimages": null,
 "ISV_vi_venueimages":  ["img1", "img2", "img3", "img4", "img5", "img6"],--掌柜图片
 "ISV_vi_venuename": "科技之都666",--掌柜名称
 "ISV_vi_opentime": null,
 "ISV_vi_closetime": null,
 "ISV_vi_coordinate": {"ISV_venue_lat": 123, "ISV_venue_lng": 123},--掌柜座标
 "ISV_vi_address": null,
 "ISV_vi_phone": null,
 "ISV_vi_mobile": null,
 "ISV_vi_introduction": null,
 "ISV_vi_venuetype": 0,
 "ISV_vi_specialservices": null,
 "ISV_vi_applydate": "2015-12-12T02:27:30.24801",--申请时间
 "ISV_vi_auditstatus": 0,
 "ISV_vi_auditdate": "0001-01-01T00:00:00",
 "ISV_vi_score": 0,--评分
 "ISV_vi_reservecount": 0,--预订数
 "ISV_vi_isrecommend": true,--是否推荐掌柜
 "ISV_venue_programcontent": null,
 "ISV_vi_city": 2,--城市ID
 "distance": 13629.5702176737,--距离
 "venueprogram_ids": ["1","2"],--掌柜项目
 "ISV_vi_programcontent": [{"venueprogram_id":1,"ISV_vpc_workdayprice":222.00,"ISV_vpc_weekendprice":222.00,"ISV_vpc_bookabletime":{"childVenueNo1": {"1": {"work": 888, "weekend": 888}, "2": {"work": 100, "weekend": 200}, "3": {"work": 100, "weekend": 200}, "4": {"work": 100, "weekend": 200}, "5": {"work": 100, "weekend": 200}}, "childVenueNo2": {"1": {"work": 100, "weekend": 200}, "2": {"work": 100, "weekend": 200}, "3": {"work": 100, "weekend": 200}, "4": {"work": 100, "weekend": 200}, "5": {"work": 100, "weekend": 200}}, "childVenueNo3": {"1": {"work": 100, "weekend": 200}, "2": {"work": 100, "weekend": 200}, "3": {"work": 100, "weekend": 200}, "4": {"work": 100, "weekend": 200}, "5": {"work": 100, "weekend": 200}}}},{"venueprogram_id":2,"ISV_vpc_workdayprice":222.00,"ISV_vpc_weekendprice":222.00,"ISV_vpc_bookabletime":{"childVenueNo1": {"1": {"work": 100, "weekend": 200}, "2": {"work": 100, "weekend": 200}, "3": {"work": 100, "weekend": 200}, "4": {"work": 100, "weekend": 200}, "5": {"work": 100, "weekend": 200}}, "childVenueNo2": {"1": {"work": 100, "weekend": 200}, "2": {"work": 100, "weekend": 200}, "3": {"work": 100, "weekend": 200}, "4": {"work": 100, "weekend": 200}, "5": {"work": 100, "weekend": 200}}, "childVenueNo3": {"1": {"work": 100, "weekend": 200}, "2": {"work": 100, "weekend": 200}, "3": {"work": 100, "weekend": 200}, "4": {"work": 100, "weekend": 200}, "5": {"work": 100, "weekend": 200}}}}],
 --项目内容  venueprogram_id--项目ID  ISV_vpc_workdayprice--工作日价格  ISV_vpc_weekendprice--平日价格
 "ISV_vi_maxprice": "222",--最高价格
 "ISV_vi_minprice": "222"--最低价格
 }
 ]
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取掌柜列表成功=10532,
 获取掌柜列表异常=10533,
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示掌柜列表的json数组	如上面参数所示

 */


+ (void)getPlaceListforitemWithVenueId:(NSString *)venueId page:(NSInteger )page count:(NSInteger )count success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&venueprogram_id=%@&page=%zd&count=%zd",getPlaceListforitem,key,venueId,page,count];
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

/*
 106.掌柜预约（即下单）
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "model": 
 {
 "venue_id": "V999999999",
 "ISV_vo_telephone": "15219232554",
 "ISV_vo_price": "888",
 "ISV_vo_reserve": [ ] ,
 "ISV_vo_payment": 1,
 "ISV_vo_from": "推荐",
 "ISV_vo_paystatus": 3,
 "ISV_vo_remark": "无",
 "venueprogram_id": 1,
 "ISV_vo_reservedate": "2015-12-17",
 },
 "type": "lock",
 "whichFunc": "ADDVENUEORDER"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 model.venue_id	是	掌柜ID
 model.ISV_vo_telephone	是	下单用户手机
 model.ISV_vo_price	是	订单金额
 model.ISV_vo_reserve	是	订单预定信息{childVenueNo1：场地 "时间段"：价格}
 model.ISV_vo_payment:	是	支付方式（1：支付宝，2：微信，3：快钱）
 model.ISV_vo_from	否	订单来源
 model.ISV_vo_remark:	否	备注
 venueprogram_id	是	订单项目
 model.ISV_vo_reservedate:	是	预订日期
 type	是	lock：下单并且锁定时段
 release：释放时段
 whichFunc	是	决定调哪一个接口
 
 返回说明Json：
 {
 "errmsg": 10543,
 "succeed": true,
 "MsgTime": "2015-12-08T01:45:27.2748213+08:00",
 "valuse": Vo201512190009363629955--订单ID
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，操作成功，false，成功失败
 errmsg	操作完成后返回信息	游客无操作权限 = 10263,
 掌柜下单成功 = 10543,
 掌柜下单失败 = 10544，
 掌柜下单异常=10545，
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-12-08T01:45:27.2748213+08:00
 valuse	无	null
 */
#pragma mark - 掌柜预约（即下单）
+ (void)placeOrderWithPlaceID:(NSString *)venue_id
                      sportID:(NSString *)venueprogram_id
                         date:(NSString *)ISV_vo_reservedate
                          tel:(NSString *)ISV_vo_telephone
                       amount:(NSInteger)amount
                      reserve:(NSArray *)ISV_vo_reserve
                       payWay:(ISVPayWay)payWay
                    orderFrom:(NSString *)ISV_vo_from
                       remark:(NSString *)ISV_vo_remark
                isRelease:(BOOL)lockORrelease
                      success:(RespondBlock)success
                      failure:(ErrorBlock)failure
{
    
    NSString *key = [self token];
    NSString *whichFunc = @"ADDVENUEORDER";
    NSString *type = lockORrelease ? @"release": @"lock";
    
    NSNumber *ISV_vo_price = @(amount);
    NSNumber *ISV_vo_payment = @(payWay);
    
    NSDictionary *model = NSDictionaryOfVariableBindings(key,
                                                         venue_id,
                                                         ISV_vo_telephone,
                                                         ISV_vo_price,
                                                         ISV_vo_reserve,
                                                         ISV_vo_payment,
                                                         ISV_vo_from,
                                                         ISV_vo_remark,
                                                         venueprogram_id,
                                                         ISV_vo_reservedate);

    NSDictionary *param = NSDictionaryOfVariableBindings(key,
                                                         model,
                                                         type,
                                                         whichFunc);
    
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}



/*
 111.获取掌柜订单详情
 网址：
 http://192.168.1.238:5000/Venue/GetVenueOrderdetail?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI1OTczNDE2MyIsImlhdCI6MTQ1MDE1MTY2OSwianRpIjpmYWxzZX0.WxnlFUZklSUkcCRbwLEunz6_vVoP0iOgb0EReIi81Bg&venueorder_id=Vo201512162331397956063&Status=3
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 Venueorder	是	订单ID
 Status	是	订单状态

 返回说明Json：
 {
 "errmsg": 10577,
 "succeed": true,
 "MsgTime": "2015-12-19T15:17:10.390694+08:00",
 "valuse": {
 "venueorder_id": "Vo201512162331397956063",--订单ID
 "user_id": "59734163",--用户ID
 "venue_id": null,
 "ISV_vo_telephone": "15219232554",--下单用户手机
 "ISV_vo_date": "2015-12-16T23:31:39.796736",--下单日期
 "ISV_vo_price": 888,--订单金额
 "ISV_vo_reserve": [--订单预定信息 childVenueNo1：星期1 childVenueNo2：星期2...
 {
 "childVenueNo1": {
 "6": 100,
 "7": 100,
 "8": 100,
 "9": 100
 }
 },
 {
 "childVenueNo2": {
 "6": 100,
 "7": 100,
 "8": 100,
 "9": 100
 }
 },
 {
 "childVenueNo3": {
 "6": 100,
 "7": 100,
 "8": 100,
 "9": 100
 }
 }
 ],
 "ISV_vo_payment": 0,
 "ISV_vo_orderstatus": 2,--订单状态（1：待确认、2：未支付、3：已取消、4：已完成、5：已付款、6处理中、7：已补贴、8：待核销）
 "ISV_vo_from": null,
 "ISV_vo_paystatus": 0,
 "ISV_vo_remark": null,
 "ISV_vo_sysremark": null,
 "venueprogram_id": 1,--订单项目
 "ISV_vo_reservedate": "2015/12/17 0:00:00",--预定日期
 "ISV_vo_verifycode": "0123456789",--验证码
 "ISV_u_nickname": "haha"--用户昵称
 }
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取掌柜订单详情成功=10577,
 获取掌柜订单详情异常=10578,
 已补贴的订单不能查看=10579，
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示掌柜订单详情的json数组	如上面参数所示

 */


+ (void)getPlaceOrderDetailInfoWithVenueOrderId:(NSString *)venueOrderId success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&venueorder_id=%@",getPlaceOrderDetailInfo,key,venueOrderId];
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}


/*
 112.根据年月日掌柜ID、获取用户订单
 网址：(掌柜馆主获取自己掌柜的订单)
 http://192.168.1.238:5000/Venue/GetVenueorderList?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIyNTA1NTI0NyIsImlhdCI6MTQ1MDE1MTc1OSwianRpIjpmYWxzZX0.LY9ksgnG6QJPnbsWAbC1AoLvSpmE7Xq_BcROtaDY0PY&venue_id=V999999999&page=1&count=10&year=2015&month=12&type=VENUE
 网址：(用户获取掌柜订单列表)
 http://localhost:18524/Venue/GetVenueorderList?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI1OTczNDE2MyIsImlhdCI6MTQ1MDE1MTY2OSwianRpIjpmYWxzZX0.WxnlFUZklSUkcCRbwLEunz6_vVoP0iOgb0EReIi81Bg&venue_id=V999999999&page=1&count=10&year=2015&month=12&type=else
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 venue_id	是	掌柜ID
 Page	是	当前页
 Count	是	每页显示数量
 Year	是	年份
 Month	是	月份
 Type	是	（VENUE或者ELSE）

 返回说明Json：
 {
 "errmsg": 10575,
 "succeed": true,
 "MsgTime": "2015-12-19T16:07:24.1336999+08:00",
 "valuse": [
 {
 "venueorder_id": "Vo201512162331397956063",--订单ID
 "user_id": "59734163",--用户ID
 "venue_id": "V999999999",--掌柜ID
 "ISV_vo_telephone": null,--掌柜电话
 "ISV_vo_date": "2015-12-16T23:31:39.796736",--下单时间
 "ISV_vo_price": 0,
 "ISV_vo_reserve": [--订单预定信息 childVenueNo1：星期1 childVenueNo2：星期2...
 {
 "childVenueNo1": {
 "6": 100,
 "7": 100,
 "8": 100,
 "9": 100
 }
 },
 {
 "childVenueNo2": {
 "6": 100,
 "7": 100,
 "8": 100,
 "9": 100
 }
 },
 {
 "childVenueNo3": {
 "6": 100,
 "7": 100,
 "8": 100,
 "9": 100
 }
 }
 ],
 "ISV_vo_payment": 0,
 "ISV_vo_orderstatus": 2,,--订单状态（1：待确认、2：未支付、3：已取消、4：已完成、5：已付款、6处理中、7：已补贴、8：待核销）
 "ISV_vo_from": null,
 "ISV_vo_paystatus": 0,
 "ISV_vo_remark": null,
 "ISV_vo_sysremark": null,
 "venueprogram_id": 1,--订单项目
 "ISV_vo_reservedate": "2015/12/17 0:00:00",--预约时间
 "ISV_vo_verifycode": null,
 "ISV_u_nickname": "haha"--用户昵称
 },
 {
 "venueorder_id": "Vo201512190009363629955",
 "user_id": "59734163",
 "venue_id": "V999999999",
 "ISV_vo_telephone": null,
 "ISV_vo_date": "2015-12-19T00:09:38.855051",
 "ISV_vo_price": 0,
 "ISV_vo_reserve": [
 {
 "childVenueNo1": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 },
 {
 "childVenueNo2": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 },
 {
 "childVenueNo3": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 }
 ],
 "ISV_vo_payment": 0,
 "ISV_vo_orderstatus": 2,
 "ISV_vo_from": null,
 "ISV_vo_paystatus": 0,
 "ISV_vo_remark": null,
 "ISV_vo_sysremark": null,
 "venueprogram_id": 1,
 "ISV_vo_reservedate": "2015/12/20 0:00:00",
 "ISV_vo_verifycode": null,
 "ISV_u_nickname": "haha"
 },
 {
 "venueorder_id": "Vo201512191429512435534",
 "user_id": "59734163",
 "venue_id": "V999999999",
 "ISV_vo_telephone": null,
 "ISV_vo_date": "2015-12-19T14:29:51.258314",
 "ISV_vo_price": 0,
 "ISV_vo_reserve": [
 {
 "childVenueNo1": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 },
 {
 "childVenueNo2": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 },
 {
 "childVenueNo3": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 }
 ],
 "ISV_vo_payment": 0,
 "ISV_vo_orderstatus": 2,
 "ISV_vo_from": null,
 "ISV_vo_paystatus": 0,
 "ISV_vo_remark": null,
 "ISV_vo_sysremark": null,
 "venueprogram_id": 1,
 "ISV_vo_reservedate": "2015/12/20 0:00:00",
 "ISV_vo_verifycode": null,
 "ISV_u_nickname": "haha"
 }
 ]
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取掌柜订单成功=10575,
 获取掌柜订单异常=10576,
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示掌柜订单列表的json数组	如上面参数所示
*/
//网址：(掌柜馆主获取自己掌柜的订单)
+ (void)getVenueOrderListWithVenueID:(NSString *)venueID page:(NSInteger )page count:(NSInteger )count year:(NSString *)year month:(NSString *)month type:(NSString *)type success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&venue_id=%@&page=%zd&count=%zd&year=%@&month=%@&type=%@",getPlaceOrderList,key,venueID,page,count,year,month,type];

    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];

}
// 网址：(用户获取掌柜订单列表)
+ (void)userGetVenueOrderListWithPage:(NSInteger )page count:(NSInteger )count type:(NSString *)type success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&page=%zd&count=%zd&type=%@",getPlaceOrderList,key,page,count,type];

    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

/*
  113.掌柜订单核销
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIyNTA1NTI0NyIsImlhdCI6MTQ1MDE1MTc1OSwianRpIjpmYWxzZX0.LY9ksgnG6QJPnbsWAbC1AoLvSpmE7Xq_BcROtaDY0PY",
 "model": {
 "venueorder_id": "Vo201512162331397956063",
 "ISV_vcr_verifycode": "0123456789"
 },
 "whichFunc":"VALUEONORDERCANCEL"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 venueorder_id	是	订单ID
 ISV_vcr_verifycode	是	验证码
 whichFunc	是	决定调哪一个接口

 返回说明Json：
 {
 "errmsg": 10591,
 "succeed": true,
 "MsgTime": "2015-12-08T01:45:27.2748213+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，操作成功，false，成功失败
 errmsg	操作完成后返回信息	掌柜订单核销成功=10591，
 掌柜订单核销失败=10592，
 验证码不正确=10594，
 掌柜订单核销异常=10593，
 请勿非掌柜主操作=10542，
 游客无操作权限=10263，
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-12-08T01:45:27.2748213+08:00
 valuse	无	null
 */
+ (void)placeOnOrderCancelWithVenueOrderID:(NSString *)venueorder_id verifycode:(NSString *)ISV_vcr_verifycode success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *whichFunc = @"VALUEONORDERCANCEL";
    NSDictionary *model = NSDictionaryOfVariableBindings(venueorder_id,ISV_vcr_verifycode);

    NSDictionary *param = NSDictionaryOfVariableBindings(key,whichFunc,model);
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

/*
 135.评价掌柜
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "model": {
 "venue_id": "V999999999",
 "venueorder_id": "Vo201512190009363629955",
 "ISV_voc_content": "跑步机不错哦，跑跑跑，生命在于奔跑",
 "ISV_voc_score": 5,
 "ISV_voc_program": "跑步"
 },
 "whichFunc": "VOCOMMENT"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 venue_id	是	掌柜id
 venueorder_id	是	订单id
 ISV_voc_content	是	评价内容
 ISV_voc_score	是	评分
 ISV_voc_program	是	订单项目
 whichFunc	是	决定调哪一个接口
 
 返回说明Json：
 {
 "errmsg": 10712,
 "succeed": true,
 "MsgTime": "2016-01-04T15:47:25.6769425+08:00",
 "valuse": "3"
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，操作成功，false，成功失败
 errmsg	操作完成后返回信息	订单时段释放成功 = 10692,
 掌柜评价成功 = 10712,
 用户对一个订单只能评价一次 = 10713,
 不是下单人不能评价 = 10714,
 掌柜评价失败 = 10715,
 掌柜评价异常 = 10716，
 游客无操作权限=10263，
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-12-08T01:45:27.2748213+08:00
 valuse	掌柜订单评价id	int
 */

+ (void)userEvaluatePlaceOrderWithPlaceID:(NSString *)venue_id orderID:(NSString *)venueorder_id content:(NSString *)ISV_voc_content score:(NSString *)ISV_voc_score program:(NSString *)ISV_voc_program success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *whichFunc = @"VOCOMMENT";
    NSDictionary *model = NSDictionaryOfVariableBindings(venue_id,venueorder_id,ISV_voc_content,ISV_voc_score,ISV_voc_program);
    NSDictionary *params = NSDictionaryOfVariableBindings(key,whichFunc,model);
    [ISVNetworking postWithURL:POST_URL params:params success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

/*
 137.获取掌柜评价列表
 网址：
 http://192.168.1.238:5000/Venue/GetVenueCommentList?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI1OTczNDE2MyIsImlhdCI6MTQ1MDk3NDk2NSwianRpIjpmYWxzZX0.gCj6clY4Q8W1AxMvgun4oWvFptMXXa6STbDuO1ChHv0&venue_id=V999999999&page=1&count=10
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 venue_id	是	掌柜ID
 page	是	页数
 count	是	每页记录数
 
 返回说明Json：
 {
 "errmsg": 10722,
 "succeed": true,
 "MsgTime": "2016-01-04T18:28:22.1972286+08:00",
 "valuse": [
 {
 "vocomment_id": 3,--掌柜评价id
 "user_id": "59734163", --用户id
 "venue_id": "V999999999", --掌柜id
 "venueorder_id": null,
 "ISV_voc_content": "跑步机不错哦，跑跑跑，生命在于奔跑", --评论内容
 "ISV_voc_score": 5, --评分
 "ISV_voc_program": "跑步", --项目
 "ISV_voc_date": "2016-01-04T15:47:22.450214", --评论日期
 "headImageUser": "http://img.hdshl.com/photos/4FF7CA5A43D797AB48D6121C41B6330C"--评价人头像
 },
 {
 "vocomment_id": 2,
 "user_id": "59734163",
 "venue_id": "V999999999",
 "venueorder_id": null,
 "ISV_voc_content": "跑步机不错哦，跑跑跑，生命在于奔跑",
 "ISV_voc_score": 5,
 "ISV_voc_program": "跑步",
 "ISV_voc_date": "2016-01-04T15:37:22.616154",
 "headImageUser": "http://img.hdshl.com/photos/4FF7CA5A43D797AB48D6121C41B6330C"
 }
 ]
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取掌柜评论列表成功 = 10722,
 获取掌柜评论列表异常 = 10723,
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示掌柜评价列表的json数组	如上面参数所示
 */
//getVenueCommentList



/*
 140.获取我的掌柜列表
 网址：
 http://192.168.1.238:5000/Venue/GetVenueList?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI0NjY0Njc3NyIsImlhdCI6MTQ1MDE1MTI0NSwianRpIjpmYWxzZX0.ArcRTd58djPbqaxRpzdd0WU6Yex9xUytf3yIVyXoh30&page=1&count=10
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 Page	是	当前页
 Count	是	每页显示数量
 
 返回说明Json：
 {
 "errmsg": 10726,
 "succeed": true,
 "MsgTime": "2016-01-05T18:17:57.5371347+08:00",
 "valuse": [
 {
 "venue_id": "V888888888",--掌柜ID
 "ISV_vi_venueimages": "img1",--掌柜图片
 "ISV_vi_venuename": "科技之都",--掌柜名称
 "venueprogram_ids": [--掌柜项目
 "6",
 "2",
 "4"
 ],
 "ISV_vi_auditstatus": 1,--掌柜状态
 "user_id": "46646777",--用户ID
 "ISV_vi_applydate": "2015-12-11T01:11:51.807072"--申请时间
 }
 ]
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取城市列表成功 = 10726,
 获取城市列表异常 = 10727,
 游客无操作权限=10263，
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示掌柜列表的json数组	如上面参数所示
 
 */
+ (void)userGetOwnPlaceListWithPage:(NSUInteger )page count:(NSUInteger )count success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&page=%zd&count=%zd",userGetOwnPlaceList,key,page,count];
    [ISVNetworking getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];

}

/*
 151.获取掌柜详情（只能获取属于自己的掌柜用于掌柜修改)
 网址：
 http://192.168.1.238:5000/Venue/GetModelInfoex?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI0NjY0Njc3NyIsImlhdCI6MTQ1MjIyMjcwNCwianRpIjpmYWxzZX0.KSMSTSrA5KVUNBmtZ2E4hFtzVA2RcYs3Qj6Th2ddn0g&venue_id=V888888888
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 venue_id	是	掌柜ID
 
 返回说明Json：
 {
 "errmsg": 10524,
 "succeed": true,
 "MsgTime": "2016-01-11T20:02:47.2447764+08:00",
 "valuse": {
 "venue_id": "V888888888",--掌柜ID
 "ISV_vi_licenceno": "88888888",--营业执照注册号
 "ISV_vi_idcard": "123456199906164597",--身份证号
 "ISV_vi_name": "神蛇科技",--法人或代理人姓名
 "ISV_vi_invitecode": "999999",--便提供的邀请码，验证成功后存储进数据库
 "ISV_vi_certificateimages": {--相关证件图片
 "IDCard": [----身份证
 "img1",
 "img2",
 "img3"
 
 ],
 "ClientScans": [--委托人照片
 "img1"
 ],
 "ClientIDCard": [--委托人身份证
 "img1",
 "img2",
 "img3"
 ],
 "LicenceNo": [--证件照片
 "img1",
 "img2"
 ]
 },
 "ISV_vi_venueimages": [--掌柜图片
 "http://img.hdshl.com/photos/img1",
 "http://img.hdshl.com/photos/img2",
 "http://img.hdshl.com/photos/img3",
 "http://img.hdshl.com/photos/img4",
 "http://img.hdshl.com/photos/img5",
 "http://img.hdshl.com/photos/img6"
 ],
 "ISV_vi_venuename": "科技之都",--掌柜名称
 "ISV_vi_opentime": "06:00:00",--营业开始时间
 "ISV_vi_closetime": "1.00:00:00",--营业结束时间
 "ISV_vi_coordinate": {--掌柜座标，{"ISV_venue_lat": 1.33, "ISV_venue_lng": 1.22}
 "ISV_venue_lat": 33,
 "ISV_venue_lng": 33
 },
 "ISV_vi_address": "广东省广州市天河体育馆",--掌柜地址
 "ISV_vi_phone": "010-99999999",--掌柜电话
 "ISV_vi_mobile": "19999999999",--掌柜手机
 "ISV_vi_introduction": "科技强身",--掌柜简介
 "ISV_vi_venuetype": 1,--1：社区掌柜，2：非社区掌柜，暂定两个，要改的时候再加，然后这个字段只需要后台查看
 "ISV_vi_specialservices": {
 "POS": true,
 "Bath": true,
 "Sale": false,
 "WIFI": false,
 "Store": true,
 "Invoice": true,
 "Parking": true,
 "RestArea": true,
 "SportsShop": false
 },--特色服务{"WIFI":true,"Bath":true,"POS":true,"Store":true,"Parking":true,"Invoice":true,"RestArea":true,"Sale":false,"SportsShop":false}
 "ISV_vi_applydate": "2015-12-11T01:11:51.807072",--申请时间
 "ISV_vi_auditstatus": 1,--核审状态，暂定0：审核中，-1，未通过，1：通过
 "ISV_vi_auditdate": "0001-01-01T00:00:00",--核审时间
 "ISV_vi_score": 0,--评分
 "ISV_vi_reservecount": 3096,--预定次数
 "ISV_vi_isrecommend": true,--是否推荐掌柜
 "ISV_venue_programcontent": null,--掌柜项目信息json
 "ISV_vi_city": 1,--城市
 "user_id": "46646777",--入驻用户id
 "distance": 9086.56785131583,--距离
 "venueprogram_ids": [--馆项目ids（数组形式）
 "6",
 "2",
 "4"
 ],
 "ISV_vi_programcontent": [
 {
 "venueprogram_id": 6,
 "ISV_vpc_workdayprice": 200,
 "ISV_vpc_weekendprice": 300,
 "ISV_vpc_bookabletime": {
 "childVenueNo1": {
 "1": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "2": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "3": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "4": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "5": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 },
 "childVenueNo2": {
 "1": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "2": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "3": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "4": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "5": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 },
 "childVenueNo3": {
 "1": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "2": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "3": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "4": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "5": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 }
 }
 },
 {
 "venueprogram_id": 2,
 "ISV_vpc_workdayprice": 100,
 "ISV_vpc_weekendprice": 200,
 "ISV_vpc_bookabletime": {
 "childVenueNo1": {
 "1": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "2": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "3": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "4": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "5": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 },
 "childVenueNo2": {
 "1": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "2": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "3": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "4": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "5": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 },
 "childVenueNo3": {
 "1": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "2": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "3": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "4": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "5": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 }
 }
 },
 {
 "venueprogram_id": 4,
 "ISV_vpc_workdayprice": 100,
 "ISV_vpc_weekendprice": 200,
 "ISV_vpc_bookabletime": {
 "childVenueNo1": {
 "1": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "2": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "3": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "4": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "5": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 },
 "childVenueNo2": {
 "1": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "2": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "3": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "4": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "5": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 },
 "childVenueNo3": {
 "1": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "2": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "3": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "4": {
 "6": 100,
 "7": 100,
 "8": 100
 },
 "5": {
 "6": 100,
 "7": 100,
 "8": 100
 }
 }
 }
 }
 ],--项目内容
 "ISV_vi_minprice": "100",--最低价
 "ISV_vi_maxprice": "300"--最高价
 }
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取掌柜信息成功=10524,
 获取掌柜信息异常=10525,
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示掌柜详情的json数组	如上面参数所示
 */

+ (void)userGetOwnPlaceDetailInfoWithPlaceId:(NSString *)venue_id success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&venue_id=%@",userGetOwnPlaceDetailInfo,key,venue_id];
    [ISVNetworking getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
    
}

/**
 *  掌柜团队
 */
+ (void)placeTeamWithPage:(NSUInteger)page count:(NSUInteger)count success:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&page=%zd&count=%zd",Place_Team,self.token, page, count];
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

@end
