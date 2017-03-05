//
//  HMNetworking+UserCenter.m
//  HealthMall
//
//  Created by jkl on 15/10/30.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMNetworking+UserCenter.h"
#import "NSString+HMHash.h"

@implementation HMNetworking (UserCenter)

#pragma - 用户登录(会员登录)
+ (void)userLoginWithUserName:(NSString *)User_Name password:(NSString *)pwd success:(RespondBlock)success failure:(ErrorBlock)failure
{
    // 判断是否游客
    NSNumber *isVisitor = nil;
    if ([User_Name isEqualToString:HM_NULL])
    {
        isVisitor = @(YES);
    }
    else
    {
        isVisitor = @(NO);
        pwd = [pwd md5];
    }


    // 1.生成随机数
    NSString *nonce = @(arc4random()).description;

    // 2.生成时间戳
    NSString *timestamp = @(@(NSDate.date.timeIntervalSinceReferenceDate * 10).integerValue).description;

    // 3.排序
    NSArray *arr = @[nonce, timestamp, pwd];

    NSArray *sortedArr = [arr sortedArrayUsingSelector:@selector(compare:)];
    NSString *sortedString = [sortedArr componentsJoinedByString:@""];

    // 4.计算哈希值
    NSString *signature = [sortedString sha1];

    // 5.拼接参数
    NSString *url = SETMYWALLETPASSWORD;
    NSDictionary *model = NSDictionaryOfVariableBindings(signature, timestamp, nonce, User_Name, isVisitor);
    NSString *whichFunc = @"LOGIN_SHARED";
    NSDictionary *param = NSDictionaryOfVariableBindings(model, whichFunc);


    // 6.开始POST请求
    [self postWithURL:url params:param success:^(id respondData) {

        // 保存令牌
        NSString *token = [respondData valueForKeyPath:@"valuse.Access_token"];
        if (NotNilAndNull(token) && token.length) {
            [[[HMNetworking alloc] init] performSelectorOnMainThread:@selector(setToken:) withObject:token waitUntilDone:YES];
        }
    
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];

}

#pragma - 用户登录(游客登录)
+ (void)userLoginForVisitorWithSuccess:(RespondBlock)success
                               failure:(ErrorBlock)failure
{
    [self userLoginWithUserName:HM_NULL password:@"42a29777faaf3b0d7c8a" success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

/*
 97.获取新Token
 网址：
 http://192.168.1.238:5000/user/OperateUser/GetNewToken?key=
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token

 返回说明Json：
 {
 "errmsg": 10458,
 "succeed": true,
 "MsgTime": "2015-12-02T00:24:44.4490952+08:00",
 "valuse": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI4NzMxMjM4MCIsImlhdCI6MTQ0ODk4NzA3OSwianRpIjp0cnVlfQ.NnF5dvglquyUZGqMdXV7eoNWkJsZ7mAs-OEkvPEJfQY"--新token
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取新Token成功 = 10458,
 令牌错误=10003,
 该用户长时间没有登录让用户重新登录=10007,
 游客登录成功=10253
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示Token信息的json数组	如上面参数所示
 */
#pragma mark - 获取新Token
+ (void)userGetNewTokenWithSuccess:(RespondBlock)success
                               failure:(ErrorBlock)failure
{
    NSString *key = self.token;
    NSString *url = [NSString stringWithFormat:@"%@?key=%@", USER_GET_NEW_TOKEN, key];
    [self getWithURL:url success:^(id respondData) {

        NSLog(@"get new token sucess--%@--1",respondData);
        NSString *token = [respondData valueForKeyPath:@"valuse"];
        if (NotNilAndNull(token) && token.length) {
            [[[HMNetworking alloc] init] performSelectorOnMainThread:@selector(setToken:) withObject:token waitUntilDone:YES];
        }
        success(respondData);
    } failure:^(HMErrorModel *error) {
         NSLog(@"get new token fail--%@--1",error);
        failure(error);
    }];
}




/*
 1.用户注册
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "model": {
 "HM_U_Telephone": "13900000010",
 "HM_U_Pwd": "123456",
 "HM_U_NickName": "湖南光头强",
 "HM_UI_Sex": 1
 },
 "whichFunc": "ADDUSER"
 }
 参数说明：
 参数	是否必须	描述
 model	是	传入实体名称
 model.HM_U_Telephone	是	电话号码
 model.HM_U_Pwd	是(手机端先进行
 MD5加密)	密码
 model.HM_U_NickName	是	昵称
 model.HM_UI_Sex	是	性别
 whichFunc	是	决定调用哪个接口
 key： 微信openid，微信注册时传入； id： 微信unionID，微信注册时传入；type 微信注册时传入（WECHAT）
 返回说明Json：
 {
 "errmsg": 10009,
 "succeed": true,
 "MsgTime": "2015-11-20T22:01:04.0207959+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，用户注册成功，false，用户注册失败
 errmsg	操作完成后返回信息	会员注册失败 = 10008,
 会员注册成功 =10009,
 手机号码已存在 = 10010,
 用户注册异常 = 10011
 MsgTime	操作完成后信息返回时间	国际标准时间
 valuse	无	null
 */
#pragma mark - 用户注册
+ (void)userRegisterWithTelephone:(NSString *)HM_U_Telephone password:(NSString *)pwd nickname:(NSString *)HM_U_NickName sex:(NSString *)HM_UI_Sex type:(NSString *)type key:(NSString *)key ID:(NSString *)ID success:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *whichFunc = @"ADDUSER";
    NSString *HM_U_Pwd = [pwd md5];
    NSDictionary *model = NSDictionaryOfVariableBindings(HM_U_Telephone, HM_U_Pwd, HM_U_NickName,HM_UI_Sex);
    NSDictionary *param = NSDictionaryOfVariableBindings(whichFunc,model,type,key,ID);
//    NSDictionary *param = NSDictionaryOfVariableBindings(whichFunc,model,type);
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

/*
 70.用户退出登录
 网址：
 http://192.168.1.238:5000/Post
 http://192.168.1.238:5000/user/OperateUser/ExitLogin?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI4NzMxMjM4MCIsImlhdCI6MTQ0Nzc2NDczMCwianRpIjpmYWxzZX0.zKjT8zMqMbVTcopDGLLhgikctXxMrUzw_PWObUibIMk
 类型：POST
 数据类型：Content-Type: application/json
 传入JSON:
 {
 "key":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI4NzMxMjM4MCIsImlhdCI6MTQ0Nzc2NDczMCwianRpIjpmYWxzZX0.zKjT8zMqMbVTcopDGLLhgikctXxMrUzw_PWObUibIMk",
 "whichFunc": "EXITLOGIN"
 }
 参数说明：
 参数	是否必须	描述	参数类型
 key	是	用户登录后返回的token	String
 whichFunc	是	决定调用哪个接口	string

 返回参数：
 {
 "errmsg": 10308,
 "succeed": true,
 "MsgTime": "2015-11-19T11:22:33.4227855+08:00",
 "valuse": null
 }

 参数	说明	值
 errmsg	返回状态	用户退出登录成功= 10308,
 用户退出登录失败 =10309,
 用户退出登录异常 = 10311，
 游客无操作权限=10263,
 登录失败=10000
 MsgTime	返回时间	操作时间
 succeed	操作是否成功	true/false
 valuse	无	null
 */

#pragma - 用户退出登录
+ (void)userLogoutWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *whichFunc = @"EXITLOGIN";
    NSDictionary *param = NSDictionaryOfVariableBindings(key,whichFunc);
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];

}


/*
 4.用户信息添加或者修改(私教课时费和授课项目在这儿修改)
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 详细信息
 {
 "key":"",
 "model": {
 "HM_UI_Age": 18,
 "HM_UI_Province": "广东",
 "HM_UI_City": "广州",
 "HM_UI_Job": "IT程序猿",
 "HM_UI_CaseHistory": "无",
 "HM_UI_Height": 170,
 "HM_UI_Weight": 60,
 "HM_UI_Signature": "良辰必有重谢",
 "HM_PT_TeachingProgram": "1,2",
 "HM_PT_CourseCost": 1000
 },
 "whichFunc": "UPDATEUSER"
 }
 或者
 昵称
 {
 "key":"",
 "model": {
 "HM_U_NickName":"hahaha"
 },
 "whichFunc": "UPDATEUSER"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 model	是	传入实体名称
 model.HM_U_NickName	是	昵称
 model.HM_UI_Age	是	年龄
 model.HM_UI_Province	是	所在省份
 model.HM_UI_City	是	所在城市
 model.HM_UI_Job	否	职业
 model.HM_UI_CaseHistory	否	过往病史
 model.HM_UI_Height	否	身高
 model.HM_UI_Weight	否	体重
 model.HM_UI_Signature	否	个性签名
 model.HM_PT_TeachingProgram	否	私教可授课项目
 model.HM_PT_CourseCost	否	私教课程费用
 whichFunc	是	决定调用哪个接口
 说明：
 返回说明Json：
 详细信息
 {
 "errmsg": 10016,
 "succeed": true,
 "MsgTime": "2015-10-10T14:47:43.0010804+08:00",
 "valuse": null
 }
 昵称
 {
 "errmsg": 10013,
 "succeed": true,
 "MsgTime": "2015-10-10T14:48:44.0178397+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，用户修改成功，false，用户修改失败
 errmsg	操作完成后返回信息	    昵称修改：
 昵称修改失败 = 10012,
 昵称修改成功 = 10013,
 昵称修改异常 = 10014

 会员详情修改：
 会员信息修改失败 = 10015,
 会员信息修改成功 = 10016,
 用户详情修改异常 = 10017
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	无	null
 */
#pragma - 用户信息修改  // 昵称必须单独请求, 其他用户信息可以组合请求也可以单独请求
+ (void)userModifyWithAge:(NSUInteger )age
                     city:(NSString *)HM_UI_City
                      job:(NSString *)HM_UI_Job
              caseHistory:(NSString *)HM_UI_CaseHistory
                   height:(NSUInteger )height
                   weight:(NSUInteger )weight
                signature:(NSString *)HM_UI_Signature
                  success:(RespondBlock)success
                  failure:(ErrorBlock)failure
{
    // 1.根据key拼接url
    NSString *key = [self token];
    NSString *whichFunc = @"UPDATEUSER";
    NSNumber *HM_UI_Age = [NSNumber numberWithUnsignedInteger:age];
    NSNumber *HM_UI_Height = [NSNumber numberWithUnsignedInteger:height];
    NSNumber *HM_UI_Weight = [NSNumber numberWithUnsignedInteger:weight];
    if (IsStrEmpty(HM_UI_Job)) {
        HM_UI_Job = HM_NULL;
    }
    if (IsStrEmpty(HM_UI_CaseHistory)){
        HM_UI_CaseHistory = HM_NULL;
    }
    if (IsStrEmpty(HM_UI_Signature)){
        HM_UI_Signature = HM_NULL;
    }
    // 2.拼接参数字典
    NSDictionary *model = NSDictionaryOfVariableBindings(HM_UI_Age,
                                                         HM_UI_City,
                                                         HM_UI_Job,
                                                         HM_UI_CaseHistory,
                                                         HM_UI_Height,
                                                         HM_UI_Weight,
                                                         HM_UI_Signature
                                                         );
    NSDictionary *param = NSDictionaryOfVariableBindings(key,model,whichFunc);
    // 3.开始请求
    [self postWithURL:SETMYWALLETPASSWORD params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

#pragma - 修改昵称或头像
+ (void)userModifyWithNickname:(NSString *)HM_U_NickName
                 headImageCode:(NSString *)hm_u_headImage
                      success:(RespondBlock)success
                      failure:(ErrorBlock)failure
{
    NSString *key = [self token];
    NSString *whichFunc = @"UPDATEUSER";
    NSDictionary *model = NSDictionaryOfVariableBindings(HM_U_NickName, hm_u_headImage);
    NSDictionary *param = NSDictionaryOfVariableBindings(key,model,whichFunc);
    [self postWithURL:SETMYWALLETPASSWORD params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}




/*
 2.请求验证码
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "model": {
 "signature": "E519301B8CD6DE745188A65C08E6C97E3FD147F3",
 "timestamp": "1443934594",
 "nonce": "123456",
 "User_Name": "13912345678"
 },
 "type":  "voice",
 "whichFunc": "SENDVERIFYCODE"
 }
 参数说明：
 参数	是否必须	说明	数据类型
 model	是	传入实体名称
 model.signature	是	签名，加密秘钥+时间戳+随机数，先进行数组排序，再通过SHA1加密而成	string
 model.timestamp	是	时间戳	string
 model.nonce	是	随机数	string
 model.User_Name	是	手机号码	string
 加密密钥	隐藏参数，自己定义	JKM!#%&()*^$@SUCCESS	String
 type	是	message：短信发送验证码；voice：电话通知验证码	string
 whichFunc	是	决定调用哪个接口	string
 exte  否 微信注册获取验证码时传wechat
 返回说明Json：
 {
 "errmsg": 10031,
 "succeed": true,
 "MsgTime": "2015-11-20T22:49:53.6206893+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，验证码发送成功false，验证码发送失败
 errmsg	操作完成后返回信息	验证码发送失败 = 10030,
 验证码发送成功 = 10031,
 验证码已发送 = 10032,
 验证码发送异常 = 10033,
 手机号不是11位数或者不全是数字 = 10059,
 请输入手机号码 = 10060,
 您的验证码是 = 10314,
 每日请求次数不能超过10次 = 10325
 MsgTime	操作完成后信息返回时间	国际标准时间
 valuse	无	null
 */

#pragma mark - 请求验证码
+ (void)requestSMSCodeWithTel:(NSString *)User_Name codeType:(NSString *)codeType key:(NSString *)keyType exte:(NSString *)exte success:(RespondBlock)success failure:(ErrorBlock)failure
{
    // 1.生成随机数
    NSString *nonce = @(arc4random()).description;

    // 2.生成时间戳
    NSString *timestamp = @(@(NSDate.date.timeIntervalSinceReferenceDate * 10).integerValue).description;

    // 3.排序
    NSArray *arr = @[nonce, timestamp, @"JKM!#%&()*^$@SUCCESS"];
    NSArray *sortedArr = [arr sortedArrayUsingSelector:@selector(compare:)];
    NSString *sortedString = [sortedArr componentsJoinedByString:@""];

    // 4.计算哈希值
    NSString *signature = [sortedString sha1];

    // 5.开始请求
    NSDictionary *model = NSDictionaryOfVariableBindings(signature, timestamp, nonce, User_Name);
    NSString *whichFunc = @"SENDVERIFYCODE";
    NSString *type = codeType;
    NSString *key = keyType;
    
    NSDictionary *param = nil;
    
    // 判断是否是微信登陆
    NSString *ID = @"";
    if (exte && exte.length) {
        ID = exte;
        param = NSDictionaryOfVariableBindings(model,whichFunc,type,key,ID);
    }else{
        param = NSDictionaryOfVariableBindings(model,whichFunc,type,key);
    }
    
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}





/*
 3.验证验证码
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "13912345678",
 "id": "853559",
 "whichFunc": "VERIFYVCODE"
 }
 参数说明：
 参数	是否必须	说明
 key	是	注册电话号
 id	是	验证码
 whichFunc	是	决定调用哪个接口

 返回说明Json：
 {
 "errmsg": 10327,
 "succeed": false,
 "MsgTime": "2015-11-20T22:58:26.4604171+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，验证码验证成功false，验证码验证失败
 errmsg	操作完成后返回信息	验证码已过期 = 10061,
 验证码不正确 = 10062,
 验证码通过 = 10063,
 验证码验证异常 = 10064,
 验证码已使用过 = 10315,
 从未向该手机号码发送过验证码 = 10326,
 未向该手机号码发送过该验证码 = 10327
 MsgTime	操作完成后信息返回时间	国际标准时间
 valuse	无	null
 */
#pragma mark - 验证验证码
+ (void)verifySMSCodeWithTel:(NSString *)telephone code:(NSString *)code success:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *key = telephone;
    NSString *ID = code;
    NSString *whichFunc = @"VERIFYVCODE";
    NSDictionary *param = NSDictionaryOfVariableBindings(key,whichFunc,ID);

    [self postWithURL:VERIFY_SMS_CODE params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

/*
 9.获取用户实体信息
 网址：http://192.168.1.238:5000/user/OperateUser/key?type=
 类型：get
 参数说明：
 参数	是否必须	说明
 key	是	用户登录后返回的token
 type	是	是否把私教信息一起取出来的条件；type=user，只取用户信息，type=trainer，且用户是私教，取用户和私教信息

 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，用户实体获取成功false，用户实体获取失败
 errmsg	操作完成后返回信息	用户实体获取失败 = 10034,
 用户实体获取成功 = 10035,
 该用户不是私教 = 10248
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse.HM_U_NickName	昵称	例子在此表下
 valuse.UserModel	用户实体	例子在此表下
 valuse.PTrainerModel	私教实体	例子在此表下
 {
 "errmsg": 10035,
 "succeed": true,
 "MsgTime": "2015-11-12T10:56:37.6946242+08:00",
 "valuse": {
 "HM_U_NickName": null,
 "UserModel": {
 "User_Id": "25055247",   --用户id
 "HM_UI_Sex": 0,   --性别
 "HM_UI_Age": 19,   --年龄
 "HM_UI_Province": "gd",   --所在省份
 "HM_UI_City": "gz",   --所在城市
 "HM_UI_Job": null,   --职业
 "HM_UI_CaseHistory": null,   --过往病史
 "HM_UI_Height": 0,   --身高
 "HM_UI_Weight": 0,   --体重
 "HM_UI_Signature": null,   --个性签名
 "HM_UI_TrainerStatus": 1   --私教状态
 },
 "PTrainerModel": {
 "User_Id": "25055247",   --私教id
 "HM_PT_Name": "lhc",   --姓名
 "HM_PT_IDCard": "430525",   --身份证号
 "HM_PT_Education": 1,   --学历
 "HM_PT_Qualification": 1,   --资质
 "HM_PT_Team": "华山派",   --专业团队
 "HM_PT_College": "笑傲江湖",   --毕业学校
 "HM_PT_CourseCost": 60000,   --课时费
 "HM_PT_ProfessionalProgram": 1,   --专业项目
 "HM_PT_TeachingProgram": "独孤九剑",   --授课项目
 "HM_PT_Province": "广东",   --所在省份
 "HM_PT_City": "广州",   --所在城市
 "HM_PT_TeachingSite": "天河",   --授课地点
 "HM_PT_Introduction": "逍遥不羁",   --简介
 "HM_PT_InviteCode": "100000",   --邀请码
 "HM_PT_Level": 1,   --私教等级
 "HM_PT_Inviter": "99999999",   --邀请人
 "HM_PT_ApplicationDate":"2015-10-06T12:34:52.309892",   --申请时间
 "HM_PT_PassDate": "0001-01-01T00:00:00"   --审核通过时间
 }
 }
 }
 */

#pragma mark - 获取用户实体信息
+ (void)userModelWithUserID:(NSString *)userID
                    success:(RespondBlock)success
                    failure:(ErrorBlock)failure
{

    NSString *key = [self token];
    NSString *url = nil;

    // 1.获取自己的信息
    if ((userID==nil) || ([userID.description isEqualToString:HM_NULL]))
    {
        url = [NSString stringWithFormat:@"%@/%@", USER_OPERATE, key];
    }
    // 2.获取他人信息
    else
    {
        url = [NSString stringWithFormat:@"%@/%@?type=%@", USER_OPERATE, key, userID];
    }

    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}


/*
 10.用户列表排序+筛选+分页（先进行用户位置存储）
 网址：http://192.168.1.238:5000/user/OperateUser?key=&page=1&count=3&sex=1&sort=desc
 类型：get
 数据类型：Content-Type: application/json
 传入Json：无
 传入参数说明：
 参数	是否必须	说明
 key	是	用户登录后返回的token
 page	是	第几页
 count	是	每页多少条
 sex	否	1：男，2：女，其他(不填)：所有
 sort	否	desc：按距离降序，asc：按距离升序，不填默认按距离升序

 返回参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，用户拉取成功，false，用户拉取失败
 errmsg	操作完成后返回信息	用户拉取失败 = 10045,
 用户拉取成功 = 10046,
 用户拉取异常 = 10047
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	返回表示附近用户的json数组，每个对象就是一个用户实体	例子在此表下
 {
 "errmsg": 10046,
 "succeed": true,
 "MsgTime": "2015-11-18T17:34:45.1082705+08:00",
 "valuse": [
 {
 "User_Id": "34181576",   --用户id
 "HM_UI_Sex": 1,   --性别
 "HM_UI_Age": 18,   --年龄
 "HM_UI_Province": "广东",   --所在省份
 "HM_UI_City": "广州",   --所在城市
 "HM_UI_Job": "IT程序猿",   --职业
 "HM_UI_CaseHistory": "无",   --过往病史
 "HM_UI_Height": 170,   --身高
 "HM_UI_Weight": 60,   --体重
 "HM_UI_Signature": "良辰必有重谢",   --个性签名
 "HM_UI_TrainerStatus": 0,   --私教状态，0：不是私教，1：申请中，2：申请成功，3：申请失败
 "distance": 11443.5458362365   --双方距离
 "headImageUser":    --用户头像
 "http://192.168.1.238:83/photos/69EE6F864F065B1E73FB501D78C5CA68"
 },
 {
 "User_Id": "62814729",
 "HM_UI_Sex": 1,
 "HM_UI_Age": 18,
 "HM_UI_Province": "广东",
 "HM_UI_City": "广州",
 "HM_UI_Job": "IT程序猿",
 "HM_UI_CaseHistory": "无",
 "HM_UI_Height": 170,
 "HM_UI_Weight": 60,
 "HM_UI_Signature": "良辰必有重谢",
 "HM_UI_TrainerStatus": 0,
 "distance": 11443.5458362365
 "headImageUser":    --用户头像
 "http://192.168.1.238:83/photos/69EE6F864F065B1E73FB501D78C5CA68"
 }
 ]
 }
 */


#pragma mark - 拉取附近用户
+ (void)getListOfNearUserWithPage:(NSUInteger )page
                            count:(NSUInteger )count
                     genderOption:(HMSexType)gender
                       sortOption:(HMSortOption)sortOption
                          success:(RespondBlock)success
                          failure:(ErrorBlock)failure
{
    // 根据key拼接url
    NSString *key = [self token];
    NSString *sex = @(gender%3).description;
    NSString *sort = @[@"asc", @"desc"][sortOption%2];
    NSString *url = [NSString stringWithFormat:
                     @"%@?key=%@&page=%ld&count=%zd&sex=%@&sort=%@",
                     USER_OPERATE, key, page, count, sex, sort];

    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}






/*
 10.存储用户位置
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "model": {
 "HM_GNU_Longitude": 113,
 "HM_GNU_Latitude": 0
 },
 "whichFunc": "SAVEUSERPOSITION"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 model	是	传入实体名称
 model.HM_GNU_Longitude	是	用户经度
 model.HM_GNU_Latitude	是	用户纬度
 whichFunc	是	决定调用哪个接口

 返回说明Json：
 {
 "errmsg": 10043,
 "succeed": true,
 "MsgTime": "2015-10-10T15:36:08.8791434+08:00",
 "valuse": null
 }
 */
#pragma mark - 存储用户位置
+ (void)tellPositionWithLongitude:(NSString *)HM_GNU_Longitude latitude:(NSString *)HM_GNU_Latitude city:(NSString *)city success:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *url = POST_URL;

    NSString *key = [self token];
    key = key ? : HM_NULL;
    NSString *whichFunc = @"SAVEUSERPOSITION";

    NSString *HM_GNU_City = city ? city : kDefaultCityID;
    
    NSDictionary *model = NSDictionaryOfVariableBindings(HM_GNU_Longitude, HM_GNU_Latitude, HM_GNU_City);

    NSDictionary *param = NSDictionaryOfVariableBindings(key, model, whichFunc);

    [self postWithURL:url params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}



/*
 12.用户下单
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "model": {
 "HM_PTrainerId": "46646777",
 "HM_ServerProgram": "八卦掌",
 "HM_ServerTime": [
 "17",
 "18",
 "19"
 ],
 "HM_ServerLocation": "天河",
 "HM_UnitPrice": 100,
 "HM_OrderFrom": "APP",
 "HM_OrderType": 1,
 "HM_Remark": "测试",
 "HM_UserPhone": "13900000000",
 "hm_serverdate": "2015-12-09"
 },
 "whichFunc": "GENERATEORDER"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 model	是	传入实体名称
 model.HM_PTrainerId	是	私教Id
 model.HM_ServerProgram	是	服务项目
 model.HM_ServerTime	是	服务时段
 model.HM_ServerLocation	是	服务地址
 model.HM_UnitPrice	是	订单单价
 model.HM_OrderFrom	是	订单来源
 model.HM_OrderType	是	订单类型
 model.HM_Remark	否	备注
 whichFunc	是	决定调用哪个接口

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
 succeed	操作完成后返回状态	true，用户下单成功
 false，用户下单失败
 errmsg	操作完成后返回信息	用户下单失败 = 10040,
 用户下单成功 = 10039,
 用户下单异常 = 10041,
 您选择的服务时段已被占用或私教该时段无服务 = 10471,
 用户下单成功但锁定服务时段失败 = 10472,
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse.orderId	订单号	201510101720393305623
 */
#pragma mark - 用户下单
+ (void)userOrderWithCoachID:(NSString *)HM_PTrainerId
                     serverProgram:(NSString *)HM_ServerProgram
                     serverTime:(NSArray *)HM_ServerTime
                     serverDate:(NSString *)hm_serverdate
                     serverLocation:(NSString *)HM_ServerLocation
                     price:(NSString *)OrderPrice
                     orderType:(NSString *)type
                     tel:(NSString *)HM_UserPhone
                     remark:(NSString *)HM_Remark
                     success:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *url = POST_URL;

    NSString *key = [self token];
    key = key?:HM_NULL;
    NSString *whichFunc = @"GENERATEORDER";
    NSString *HM_OrderFrom = @"APP";
    NSNumber *HM_OrderPrice = @(OrderPrice.integerValue);
    NSDictionary *model = NSDictionaryOfVariableBindings(HM_PTrainerId,
                                                         HM_ServerProgram,
                                                         HM_ServerTime,
                                                         hm_serverdate,
                                                         HM_ServerLocation,
                                                         HM_OrderPrice,
                                                         HM_OrderFrom,
                                                         HM_UserPhone,
                                                         HM_Remark);

    NSDictionary *param = NSDictionaryOfVariableBindings(key, model, whichFunc, type);
    [self postWithURL:url params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}


/*
 14.获取订单(约私教订单)
 网址：
 订单详情：http://192.168.1.238:5000/trainer/trainerorder?key=&orderId=201510101720393305623
 用户看自己的订单列表(ps：私教看自己约私教的订单也是这个)：
 http://192.168.1.238:5000/trainer/trainerorder?key=&page=1&count=10&type=user
 私教看用户约自己的订单列表：
 http://192.168.1.238:5000/trainer/trainerorder?key=&year=2015&month=11&page=1&count=10&type=trainer
 类型：get
 数据类型：Content-Type: application/json
 数据：无
 参数说明：
 参数	是否必须	说明
 key	是	用户登录后返回的token
 orderId	否	订单号，有则查询订单详情，无则查询订单列表
 year	是(查询订单订单详情或type=user时：否)	年份，无此参数或者输入0为不按该条件搜索
 month	是(查询订单订单详情或type=user时：否)	月份，无此参数或者输入0为不按该条件搜索
 page	是(查询订单订单详情时：否)	第几页
 count	是(查询订单订单详情时：否)	每页显示数量
 type	是(查询订单订单详情时：否)	type=user，用户看自己的订单列表(ps：私教看自己约私教的订单也是这个)；type=trainer，私教看用户约自己的订单列表

 返回说明Json：
 {
 "errmsg": 10069,
 "succeed": true,
 "MsgTime": "2015-12-04T10:01:40.3184907+08:00",
 "valuse": [
 {
 "HM_OrderId": "201510101135379026590",   --订单号
 "User_Id": "25055247",   --用户id
 "HM_PTrainerId": "46646777",   --私教id
 "HM_ServerProgram": "八卦掌",   --服务项目
 "HM_OrderDate": "2015-10-10T11:35:37.902861",   --订单日期
 "HM_ServerTime": [
 "17",
 "18",
 "19"
 ],   --服务时段
 "HM_ServerLocation": "天河",   --服务地址
 "HM_UserPhone": "13900000001",   --用户手机
 "HM_OrderPrice": 300,   --订单价格
 "HM_OrderFrom": "APP",   --订单来源
 "HM_PayStatus": "未付款",   --付款状态
 "HM_OrderStatus": "未付款",   --订单状态
 "HM_Remark": "测试",   --备注
 "HM_SystemRemark": null,   --系统备注
 "HM_UnitPrice": 100,   --系统单价
 "usernick": "大虾",   --用户昵称
 "trainernick": "可以哦"   --私教昵称
 "headImageUser":    --用户头像
 "http://192.168.1.238:83/photos/69EE6F864F065B1E73FB501D78C5CA68"
 "headImageTrainer":    --私教头像
 "http://192.168.1.238:83/photos/EB2EEBB7A705652B4049BF3B46367195"
 },
 {
 "HM_OrderId": "201510092232244834312",
 "User_Id": "25055247",
 "HM_PTrainerId": "46646777",
 "HM_ServerProgram": "八卦掌",
 "HM_OrderDate": "2015-10-09T22:32:24.483595",
 "HM_ServerTime": [
 "17",
 "18",
 "19"
 ],
 "HM_ServerLocation": "天河",
 "HM_UserPhone": "13900000000",
 "HM_OrderPrice": 300,
 "HM_OrderFrom": "APP",
 "HM_PayStatus": "付款成功",
 "HM_OrderStatus": "已评价",
 "HM_Remark": "测试",
 "HM_SystemRemark": null,
 "HM_UnitPrice": 100,
 "usernick": "大虾",
 "trainernick": "可以哦"
 "headImageUser": "http://192.168.1.238:83/photos/69EE6F864F065B1E73FB501D78C5CA68"
 "headImageTrainer": "http://192.168.1.238:83/photos/EB2EEBB7A705652B4049BF3B46367195"
 }
 ]
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，订单获取成功
 false，订单获取失败
 errmsg	操作完成后返回信息	订单获取失败 = 10068,
 订单获取成功 = 10069,
 订单获取异常 = 10070
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示订单的json数组	例子在此表上
 */

+ (void)getUserOrderWithType:(NSString *)type page:(NSUInteger )page count:(NSInteger)count success:(RespondBlock)success failure:(ErrorBlock)failure{
    // 根据key拼接url
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:
                     @"%@?key=%@&page=%@&count=%ld&type=%@",
                     GETORDER, key, [NSNumber numberWithUnsignedInteger:page], (long)count, type];
    
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

//http://192.168.1.238:5000/trainer/trainerorder?key=&orderId=201510101720393305623

+ (void)orderDetailInfoWithOrderId:(NSString *)orderId success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&orderId=%@",GETORDER,key,orderId];
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];


}

/*
 165.订单取消与删除
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIyNTA1NTI0NyIsImlhdCI6MTQ1MzQ0NDY3MiwianRpIjpmYWxzZX0.2zaT9EiTyQ-kdybsS774p0JF3bV1OCUErUf0uvVgqOI",
 "model": {
 "orderbiaoshi": "privateorder",
 "operationbiaoshi": "cancel",
 "order_id": "201601191541002099044"
 },
 "whichFunc": "OPERATIONORDER"
 }
 参数说明：
 参数	是否必须	描述	数据类型
 key	是	用户登录后返回的token	string
 orderbiaoshi	是	订单标示：
 (venueorder:场馆订单)
 (pavilionorder:养生馆订单)
 (grouporder:团购订单)
 (privateorder:私教订单)	string
 operationbiaoshi	是	操作标示：
 （cancel：取消）
 （del：删除）	string
 order_id	是	订单ID	string
 whichFunc	是	决定调用哪个接口	string
 
 返回说明Json：
 {
 "errmsg": 10834,
 "succeed": true,
 "MsgTime": "2015-12-23T00:32:51.3414013+08:00",
 "valuse": true
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True：操作成功，false：操作失败
 errmsg	操作完成后返回信息	取消订单成功 = 10834,
 删除订单成功 = 10835,
 非法操作 = 10836,
 订单状态不正确 = 10837,
 请勿尝试非本人操作 = 10838,
 游客无操作权限 = 10263,
 登录失败 = 10000,
 MsgTime	操作完成后信息返回时间	国际标准时间
 
 */

+ (void)userCancelOrDeleteOrderWithOrderMarked:(NSString *)orderbiaoshi operationMarked:(NSString *)operationbiaoshi orderId:(NSString *)
order_id success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *whichFunc = @"OPERATIONORDER";
    NSDictionary *model = NSDictionaryOfVariableBindings(orderbiaoshi,operationbiaoshi,order_id);
    NSDictionary *params = NSDictionaryOfVariableBindings(key,whichFunc,model);
    [HMNetworking postWithURL:POST_URL params:params success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

/*
 15-21钱包--逻辑分析：
 1.私教第一次点击钱包，系统给他创建一个新钱包，此时密码为空；点击钱包时，系统会判断该钱包是否有密码，存在则打开钱包，显示钱包信息，否则，弹出设置密码框，设置好后，显示钱包信息；
 2.验证钱包密码跟用户登录差不多，用户传入签名（用户密码，时间戳和随机数经过排序加密得到的一长串字符），时间戳，随机数和用户id，系统验证密码是否正确；
 3.私教提出提现申请，会在提现申请表，支出记录和支出记录备份表中各插入一条记录，如果该申请通过，则该私教钱包金额减少申请提现的金额，提现状态改变，并且在提现结果表中保存该提现记录；
 4.用户评价完订单后，会修改下单状态和已接受订单的状态，在收入记录和收入记录备份表中各插入一条记录，订单上私教的钱包金额加上订单金额。

 15.点击钱包事件
 网址：http://192.168.1.238:5000/wallet/key
 类型：post
 数据类型：Content-Type: application/json
 传入Json：无
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token

 返回说明Json：
 {
 "errmsg": 10071,
 "succeed": true,
 "MsgTime": "2015-10-14T15:08:11.9709278+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，密码为空或者密码已存在，false，初始化钱包异常
 errmsg	操作完成后返回信息	密码为空 = 10071,
 密码已存在 = 10072,
 初始化钱包异常 = 10073
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	无	null
 */

#pragma - 点击钱包事件
+ (void)clickWalletWithSuccess:(RespondBlock)success
                      failure:(ErrorBlock)failure
{
    NSString *key = [self token];
    NSString *whichFunc = @"INITWALLET";

    NSDictionary *param = NSDictionaryOfVariableBindings(key, whichFunc);
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

/*
 16.获取钱包实体
 网址：http://192.168.1.238:5000/wallet/key
 类型：get
 数据类型：Content-Type: application/json
 传入Json：无
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token

 返回说明Json：
 {
 "errmsg": 10075,
 "succeed": true,
 "MsgTime": "2015-10-14T15:25:15.9967824+08:00",
 "valuse": {
 "User_Id": "25055247",
 "HM_W_Amount": "0",
 "HM_W_Point": "0",
 "HM_W_PayPwd": "123"
 }
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，获取钱包成功，false，获取钱包失败
 errmsg	操作完成后返回信息	获取钱包失败 = 10074,
 获取钱包成功 = 10075,
 获取钱包异常 = 10076
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	钱包信息	{
 "User_Id": "25055247",      "HM_W_Amount": "0",
 "HM_W_Point": "0",
 "HM_W_PayPwd": "123"
 }
 */
#pragma mark - 获取钱包实体信息
+ (void)myWalletModelWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure
{
    // 根据key拼接url
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:@"%@/%@", WALLET, key];
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

/*
 17.设置钱包密码
 网址：http://192.168.1.238:5000/wallet?key=&pwd=123（加密）
 类型：put
 数据类型：Content-Type: application/json
 传入Json：无
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 pwd	是	加密密码

 返回说明Json：
 {
 "errmsg": 10078,
 "succeed": true,
 "MsgTime": "2015-10-14T16:09:45.9486536+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，密码设置成功，false，密码设置失败
 errmsg	操作完成后返回信息	钱包密码设置失败 = 10077,
 钱包密码设置成功 = 10078,
 钱包密码设置异常 = 10079
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	无	null
 */
+ (void)setMyWalletPassWordWithID:(NSString *)str success:(RespondBlock)success failure:(ErrorBlock)failure{
    //开始POST请求
    NSString *ID = [str md5];
    NSString *key = self.token;
    NSString *whichFunc = @"SETPASSWORD";

    NSDictionary *param = NSDictionaryOfVariableBindings(key,ID, whichFunc);

    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];

}

/*
 18.验证钱包密码（目前传入的signature固定，所以只能验证密码123，如需验证其他密码，请自行加密生成signature，或者找写文档的人；如果密码是经过加密后再传入的，那么在前端生成签名signature时，也要对密码进行相同的加密）
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "model": {
 "signature": "BF5CAD62D72493F9B1447CEBEA353B880EB79924",
 "timestamp": "1443934594",
 "nonce": "123456",
 "User_Name": "25055247"
 },
 "whichFunc": "VALIDATEPWD"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 model	是	传入实体名称
 model.signature	是	签名，钱包密码+时间戳+随机数，先进行数组排序，再通过md5加密而成
 model.timestamp	是	时间戳
 model.nonce	是	随机数
 model.User_Name	是	用户id
 whichFunc	是	决定调用哪个接口

 返回说明Json：
 {
 "errmsg": 10081,
 "succeed": true,
 "MsgTime": "2015-10-14T16:09:45.9486536+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，钱包密码验证通过，false，钱包密码验证失败
 errmsg	操作完成后返回信息	钱包密码验证失败 = 10080,
 钱包密码验证通过 = 10081,
 钱包密码验证异常 = 10082,
 钱包数据完整性检查不通过 = 10083,
 钱包签名时间戳失效 = 10084
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	无	null
 */

+ (void)verifyMyWalletPasswordWithPassword:(NSString *)password userID:(NSString *)userID success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *whichFunc = @"VALIDATEPWD";

    // 1.生成随机数
    NSString *nonce = @(arc4random()).description;

    // 2.生成时间戳
    NSString *timestamp = @(@(NSDate.date.timeIntervalSinceReferenceDate * 10).integerValue).description;

    // 3.排序
    NSArray *arr = @[nonce, timestamp, [password md5]];
    NSArray *sortedArr = [arr sortedArrayUsingSelector:@selector(compare:)];
    NSString *sortedString = [sortedArr componentsJoinedByString:@""];

    // 4.计算哈希值
    NSString *signature = [sortedString sha1];

    NSMutableDictionary* model = [[NSMutableDictionary alloc]init];
    [model setValue:signature forKey:@"signature"];
    [model setValue:timestamp forKey:@"timestamp"];
    [model setValue:nonce forKey:@"nonce"];
    //用户ID未完成
    [model setValue:userID forKey:@"User_Name"];

    NSDictionary *param = NSDictionaryOfVariableBindings(key, model, whichFunc);
    NSLog(@"prama--%@--1",param);
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];

}

/*
 19.提现申请 -----20160102修改
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "model": {
 "HM_WA_Amount": 100,
 "HM_WA_Flag": "65559998941235656488",
 "hm_wa_rateamount": 2.00
 },
 "whichFunc": "WITHDRAWAPPLY"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 model	是	传入实体名称
 model.HM_WA_Amount	是	申请提现金额
 model.HM_WA_Flag	是	银行卡号
 hm_wa_rateamount	是	手续费
 whichFunc	是	决定调用哪个接口
 
 返回说明Json：
 {
 "errmsg": 10087,
 "succeed": false,
 "MsgTime": "2015-10-15T19:42:38.3893663+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，提现申请成功，false，提现申请失败
 errmsg	操作完成后返回信息	提现申请失败 = 10085,
 提现申请成功 = 10086,
 请选择正确的银行卡 = 10087,
 提现申请异常 = 10088,
 您输入的金额低于提现最低限额 = 10241,
 您输入的金额超过提现最高限额 = 10331,
 提现余额不足 = 10332,
 请绑定银行卡 = 10357，
 手续费计算错误 = 10688
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	无	null
 */

+ (void)userWithdrawBankCardFlag:(NSString *)flag amount:(NSString *)amount rateamount:(NSString *)FEE success:(RespondBlock)success failure:(ErrorBlock)failure{

    NSString *key = [self token];
    NSString *whichFunc = @"WITHDRAWAPPLY";
    NSMutableDictionary* model = [[NSMutableDictionary alloc]init];
    [model setValue:flag forKey:@"HM_WA_Flag"];
    [model setValue:amount forKey:@"HM_WA_Amount"];
    
    [model setValue:FEE forKey:@"hm_wa_rateamount"];
    
    NSDictionary *param = NSDictionaryOfVariableBindings(key, model, whichFunc);

    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}



/*
 20.提现申请通过
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "model": {
 "HM_WR_OrderId": "wa201510151955333588350",
 "HM_WR_WithdrawDate": "2015-10-15 10:15:36",
 "HM_WR_IsPass": true,
 "HM_WR_Auditor": "haha",
 "HM_WR_IsReceive": true,
 "HM_WR_SerialNumber": "liushuizhanghao123"
 },
 "whichFunc": "WITHDRAWRESULT"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 model	是	传入实体名称
 model.HM_WR_OrderId	是	订单号
 model.HM_WR_WithdrawDate	是	提现时间
 model.HM_WR_IsPass	是	是否通过
 model.HM_WR_Auditor	是	审核人
 model.HM_WR_IsReceive	是	是否到账
 model.HM_WR_SerialNumber	是	流水账号
 whichFunc	是	决定调用哪个接口

 返回说明Json：
 {
 "errmsg": 10090,
 "succeed": true,
 "MsgTime": "2015-10-15T20:49:31.8876385+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，提现申请审核通过，false，提现申请审核失败
 errmsg	操作完成后返回信息	提现审核未通过 = 10089,
 提现审核通过 = 10090,
 提现审核异常 = 10091,
 该提现已通过审核请勿重复审核 = 10091
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	无	null
 */

/*
 163.获取支付明细
 网址：http://192.168.1.238:5000/Wallet/GetBalance?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI4Njk0MjI4NiIsImlhdCI6MTQ1Mzk3MTExOCwianRpIjpmYWxzZX0.jSCpPz6L1c-bBcJR8qnWO_yW_9C087BE6u7ziPGRwc0&orderid=wa201601241356581897777&page=1&count=10&type=detail
 类型：get
 数据类型：Content-Type: application/json
 传入Json：无
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 orderid	否	type=detail时，必传
 page	否	type=list时，必传，第几页
 count	否	type=list时，必传，每页记录数
 type	是	type=detail，获取明细详情，type=list时，获取明细列表
 
 返回说明Json：
 {
 "errmsg": 10836,
 "succeed": true,
 "MsgTime": "2016-01-28T23:00:55.2731902+08:00",
 "valuse": [
 {
 "user_id": "64603864", --用户id
 "hm_orderid": "wa201601241356581897777", --订单id或提现id
 "hm_inr_amountbefore": 196, --订单前金额
 "hm_inr_amount": 102, --订单金额
 "hm_inr_amountafter": 298, --订单后金额
 "hm_inr_date": "2016-01-24T16:09:07.412305", --成功付款日期
 "hm_inr_serveenddate": "0001-01-01T00:00:00", --已服务日期
 "hm_inr_receivedate": "0001-01-01T00:00:00", --已到账日期
 "hm_inr_refunddate": "0001-01-01T00:00:00", --退款成功日期
 "hm_inr_status": 0, --收入状态，0：暂无，1：成功付款，2：已服务，3：成功到账，4：已退款；支出状态，1：提交申请，2：审核中，3：提现成功，4：提现不成功
 "hm_wa_bankcard": "012345678912345678901", --银行卡
 "hm_wa_status": "-2", --提现金额
 "hm_wa_date": "2016/1/24 13:56:58", --提现状态
 "hm_wa_rateamount": "2", --提现费率
 "inorout":1--1：收入，2：支出
 }
 ]
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true/false
 errmsg	操作完成后返回信息	获取支付明细成功 = 10836,
 获取支付明细异常 = 10837，
 游客无操作权限 = 10263,
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	列表和详情都是数组返回
 */

+ (void)getUserIncomeAndExpensesWithOrderid:(NSString *)orderid page:(NSUInteger )page count:(NSUInteger )count type:(NSString *)type success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *url = [NSString string];
    if ([type isEqualToString:@"detail"]) {
        url = [NSString stringWithFormat:@"%@?key=%@&orderid=%@&type=%@",USER_GETBALANCE,key,orderid,type];
    }else if ([type isEqualToString:@"list"]){
        url = [NSString stringWithFormat:@"%@?key=%@&page=%ld&count=%ld&type=%@",USER_GETBALANCE,key,page,count,type];
    }
    
    [HMNetworking getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
    
}



/*
 21.用户给私教评分
 网址：http://192.168.1.238:5000/Post
 类型：Post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "model": {
 "hm_orderid": "201510092232244834312",
 "hm_ptc_score": 5,
 "hm_ptc_content": "你好棒哦"
 },
 "whichFunc": "IN_PTCOMMENT"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 model	是	传入实体名称
 model.hm_orderid	是	订单号
 model.hm_ptc_score	是	评分
 model.hm_ptc_content	是	评论内容
 whichFunc	是	决定调用哪个接口

 返回说明Json：
 {
 "errmsg": 10090,
 "succeed": true,
 "MsgTime": "2015-10-15T20:49:31.8876385+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，评论成功，false，评论失败
 errmsg	操作完成后返回信息	私教评论操作异常=10092,
 私教评论成功=10093,
 私教该订单已经评论=10094
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	无	null
 */

+ (void)userEvaluateCoachScore:(NSString *)hm_ptc_score content:(NSString *)hm_ptc_content orderId:(NSString *)hm_orderid type:(NSString *)type success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *whichFunc = @"IN_PTCOMMENT";
    NSDictionary *model = NSDictionaryOfVariableBindings(hm_orderid, hm_ptc_score, hm_ptc_content);

    NSDictionary *param = NSDictionaryOfVariableBindings(key,model,whichFunc,type);
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];

}

/*
 27-28优惠券--逻辑分析
 1.用户添加优惠券时，首页检查派发优惠券的活动的活动次数是否用完，如果没有，再判断用户用户活动次数是否用完，如果没有，则给该用户添加优惠券，同时记录该用户的活动记录；
 2.用户使用过优惠券或者优惠券过期后，不能再使用；(未实现)
 3.获取优惠券分为所有优惠券，已使用优惠券和可使用优惠券；(实现所有优惠券获取)
 27.用户添加优惠券
 网址：http://192.168.1.238:5000/user/ Coupon?key=
 类型：post
 数据类型：Content-Type: application/json
 传入json：
 {
 "tbid": 1,
 "user_id": "123456",
 "hm_ucou_coupon": {
 "hm_ucou_coupon": [
 {
 "CouponName": "活动有礼",
 "Discount": 0.9,
 "MaxMoney": 100,
 "MinMoney": 10,
 "IsUsed": true,
 "StartDate": "2015-12-11 00:20",
 "EndDate": "2015-12-11 00:20",
 "CouponId": ""
 }
 ]
 },
 "hm_ujr_award": "100积分"
 }
 参数说明：
 参数	是否必须	描述
 key	是(暂时否)	用户登录后返回的token
 tbid	是	活动id
 user_id	是	参与活动用户id
 hm_ucou_coupon	是	优惠券信息
 hm_ujr_award	否	奖品说明

 返回说明Json：
 {
 "errmsg": 10187,
 "succeed": false,
 "MsgTime": "2015-10-15T20:49:31.8876385+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，优惠券添加成功，false，优惠券添加失败
 errmsg	操作完成后返回信息	活动总次数已用完 = 10186,
 用户活动次数已用完 = 10187,
 用户添加优惠券成功 = 10188,
 用户优惠劵添加失败=10204,
 用户优惠劵添加异常=10205
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	null	null
 */







/*
 28.获取优惠券
 网址：http://192.168.1.238:5000/user/ Coupon/key
 类型：get
 参数说明：
 参数	是否必须	描述
 key	是(暂时当用户id用)	用户登录后返回的token

 返回说明Json：
 {
 "errmsg": 10183,
 "succeed": true,
 "MsgTime": "2015-10-15T20:49:31.8876385+08:00",
 "valuse": 优惠券信息
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，获取用户优惠卷列表成功，false，获取用户优惠卷列表失败
 errmsg	操作完成后返回信息	获取用户优惠卷列表成功 = 10183,
 获取用户优惠卷列表失败 = 10184,
 获取用户优惠卷列表异常 = 10185
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	优惠券信息	如下
 {
 "tbid": 0,
 "user_id": "123456",
 "hm_ucou_coupon": "{\"hm_ucou_coupon\": [{\"IsUsed\": true, \"EndDate\": \"2015-12-11T00:20:00\", \"CouponId\": \"0af528674b324b248824f39aee19d550\", \"Discount\": 0.9, \"MaxMoney\": 100.0, \"MinMoney\": 10.0, \"StartDate\": \"2015-12-11T00:20:00\", \"CouponName\": \"活动有礼\"}]}",
 "hm_ujr_award": null
 }
 */

+ (void)userGetCouponWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *url = [NSString stringWithFormat:@"%@/%@", USERGETCOUPON, key];
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}


/*
 29.新增或删除银行卡
 网址：http://192.168.1.238:5000/Post
 类型：Post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "model": [
 {
 "bankcard": "6555777777777777000",
 "account": "杨小二",
 "phone": "15999999999",
 "bank": "中国银行",
 "banktype": "借记卡",
 "isValidate": true,
 "bankimage": ""
 }
 ],
 "type": "ADD",增加  "DELETE"删除
 "whichFunc": "SAVEBANKCARD"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 model	是	传入实体名称
 model.bankcard	是	银行卡号
 model.account	是	持卡人姓名
 model.phone	是	银行预留手机号
 model.bank	是	开户银行
 model.banktype	是	银行卡类型，如借记卡，储蓄卡
 model.isValidate	是	验证是否通过
 model.bankimage	是	开户银行图标
 model.adddate   20151124新增字段，当前时间
 whichFunc	是	决定调用哪个接口

 返回说明Json：
 {
 "errmsg": 10125,
 "succeed": true,
 "MsgTime": "2015-11-23T20:02:47.3595319+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，操作成功，false，操作失败
 errmsg	操作完成后返回信息	银行卡保存成功 = 10125,
 银行卡保存失败 = 10126,
 银行卡保存异常 = 10127,
 银行卡删除成功 = 10348,
 银行卡删除失败 = 10349,
 银行卡重复 = 10350
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	无	null
 */

+ (void)userAddBankCard:(NSString *)bankcard account:(NSString *)account phone:(NSString *)phone bank:(NSString *)bank banktype:(NSString *)banktype isValidate:(NSString *)isValidate bankimage:(NSString *)bankimage adddate:(NSString *)adddate type:(NSString *)type idcard:(NSString *)idcard success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *whichFunc = @"SAVEBANKCARD";
    NSMutableDictionary* data = [[NSMutableDictionary alloc]init];
    [data setValue:bankcard forKey:@"bankcard"];
    [data setValue:account forKey:@"account"];
    [data setValue:phone forKey:@"phone"];
    [data setValue:bank forKey:@"bank"];
    [data setValue:banktype forKey:@"banktype"];
//    id isValidate1 = @(YES);
    [data setValue:isValidate forKey:@"isValidate"];
    [data setValue:bankimage forKey:@"bankimage"];
    [data setValue:idcard forKey:@"idcard"];
    if ([type isEqualToString:@"DELETE"]) {
        [data setValue:adddate forKey:@"adddate"];
    }
    NSMutableArray *model = [[NSMutableArray alloc]init];
    [model addObject:data];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:model forKey:@"model"];
    [params setValue:key forKey:@"key"];
    [params setValue:whichFunc forKey:@"whichFunc"];
    [params setValue:type forKey:@"type"];

    NSDictionary *param = NSDictionaryOfVariableBindings(key, model, whichFunc, type);
    NSLog(@"prama接口打印值--%@--1",param);
//     NSDictionary *param = NSDictionaryOfVariableBindings(key, whichFunc, type);


    [self postWithURL:POST_URL params:params success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}
/*
 30.获取用户银行卡列表
 网址：http://192.168.1.238:5000/wallet/GetBankCard?Key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIxMjEyNjYyNyIsImlhdCI6MTQ0ODA3NTkxOSwianRpIjpmYWxzZX0.Ic8vBtUD_08cpxYtYUAeBS_MosT4dCNKMnNPhSJZRi4
 类型：get
 数据类型：Content-Type: application/json
 传入Json：无
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token

 返回说明Json：
 {
 "errmsg": 10364,
 "succeed": true,
 "MsgTime": "2015-11-24T10:47:22.0500344+08:00",
 "valuse": {
 "user_id": "12126627",
 "hm_bc_jsoninfo": [
 {
 "bankcard": "6555777777777777001",--银行卡号
 "account": "杨小二",--持卡人姓名
 "phone": "15999999999",--电话
 "bank": "中国银行",--银行名称
 "banktype": "借记卡",--银行卡类型
 "isValidate": true,--是否通过
 "bankimage": "",--开户银行图像
 "adddate": "2015-11-24T00:44:26.0569599+08:00"--添加时间
 },
 {
 "bankcard": "6555777777777777000",
 "account": "杨小二",
 "phone": "15999999999",
 "bank": "中国银行",
 "banktype": "借记卡",
 "isValidate": true,
 "bankimage": "",
 "adddate": "2015-11-24T00:44:13.8008949+08:00"
 }
 ]
 }
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，获取银行卡信息成功，false，获取银行卡信息失败
 errmsg	操作完成后返回信息	获取用户银行卡信息成功 = 10364,
 获取用户银行卡信息失败 = 10365,
 获取用户银行卡信息异常 = 10366
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示银行卡列表的json数组	如上面参数所示
 */
//USER_BANKCARDLIST

+ (void)userBankCardListWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure{
    // 根据key拼接url
    NSString *key = [self token];

    NSString *url = [NSString stringWithFormat:@"%@?Key=%@",USER_BANKCARDLIST, key];

    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

/*
 银行、服务相关↓
 47.获取所有银行列表
 网址：
 http://192.168.1.238:5000/Wallet/GetAllBanList?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI4NzMxMjM4MCIsImlhdCI6MTQ0Nzc2NDczMCwianRpIjpmYWxzZX0.zKjT8zMqMbVTcopDGLLhgikctXxMrUzw_PWObUibIMk
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token

 返回说明Json：
 {
 "errmsg": 10407,
 "succeed": true,
 "MsgTime": "2015-11-26T14:20:22.3470784+08:00",
 "valuse": [
 {
 "hm_bankl_id": 1,--递增id
 "hm_bankl_name": "中国银行",--银行名称
 "hm_bankl_image": null,--图片
 "hm_bankl_sort": 1--排序ID
 },
 {
 "hm_bankl_id": 2,
 "hm_bankl_name": "民生银行",
 "hm_bankl_image": null,
 "hm_bankl_sort": 2
 },
 {
 "hm_bankl_id": 3,
 "hm_bankl_name": "广发银行",
 "hm_bankl_image": null,
 "hm_bankl_sort": 3
 },
 {
 "hm_bankl_id": 4,
 "hm_bankl_name": "中国农业银行",
 "hm_bankl_image": null,
 "hm_bankl_sort": 4
 },
 {
 "hm_bankl_id": 5,
 "hm_bankl_name": "中国建设银行",
 "hm_bankl_image": null,
 "hm_bankl_sort": 5
 },
 {
 "hm_bankl_id": 6,
 "hm_bankl_name": "中国工商银行",
 "hm_bankl_image": null,
 "hm_bankl_sort": 6
 },
 {
 "hm_bankl_id": 7,
 "hm_bankl_name": "招商银行",
 "hm_bankl_image": null,
 "hm_bankl_sort": 7
 }
 ]
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取银行列表成功= 10407,
 获取资质列表失败 = 10408,
 获取资质列表异常 = 10409,
 游客无操作权限=10263，
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示银行列表的json数组	如上面参数所示
 */

+ (void)userAllBankListWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure{
    // 根据key拼接url
    NSString *key = [self token];

    NSString *url = [NSString stringWithFormat:@"%@?Key=%@",USER_ALLBANKLIST, key];

    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

// 银行卡鉴权
+ (void)userAllBankAuthenticationWithName:(NSString *)IdCardName IDCard:(NSString *)IdCard mobile:(NSString *)Mobile bankCardNum:(NSString *)BankCardNum success:(RespondBlock)success failure:(ErrorBlock)failure
{

    NSString *key = [self token];
    NSString *whichFunc = @"CHECKBANK";
    
    NSDictionary *model = NSDictionaryOfVariableBindings(IdCardName,IdCard,Mobile,BankCardNum);
    
    NSDictionary *param = NSDictionaryOfVariableBindings(key, model , whichFunc);
    
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}
/**
 *  获取学历
 *
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)userEducationListWithSuccess:(RespondBlock)success
                            failure:(ErrorBlock)failure
{
    // 根据key拼接url
    NSString *key = [self token];

    NSString *url = [NSString stringWithFormat:@"%@/%@?type=geteducationlist",USER_Education, key];

    [self getWithURL:url success:^(id respondData) {
        ! success ? : success(respondData);
    } failure:^(HMErrorModel *error) {
        ! failure ? : failure(error);
    }];
}

/*
 75.获取所有项目列表（约私教）
 网址：
 http://192.168.1.238:5000/user/Education/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIxMjEyNjYyNyIsImlhdCI6MTQ0ODA3NTkxOSwianRpIjpmYWxzZX0.Ic8vBtUD_08cpxYtYUAeBS_MosT4dCNKMnNPhSJZRi4?type=getproprogramlist
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIxMjEyNjYyNyIsImlhdCI6MTQ0ODA3NTkxOSwianRpIjpmYWxzZX0.Ic8vBtUD_08cpxYtYUAeBS_MosT4dCNKMnNPhSJZRi4	是	用户登录后返回的token

 返回说明Json：
 {
 "errmsg": 10361,
 "succeed": true,
 "MsgTime": "2015-11-24T11:24:01.0813089+08:00",
 "valuse": [
 {
 "program_id": 1,--递增ID
 "hm_pp_name": "跑步",--项目名称
 "hm_pp_sort": 1,--排序字段
 "hm_pp_parentid": 0,--父级ID
 "hm_pp_level": 0,--项目等级
 "hm_pp_image": ""--项目图片
 },
 {
 "program_id": 2,
 "hm_pp_name": "自行车",
 "hm_pp_sort": 2,
 "hm_pp_parentid": 0,
 "hm_pp_level": 0,
 "hm_pp_image": ""
 },
 {
 "program_id": 3,
 "hm_pp_name": "综合训练",
 "hm_pp_sort": 3,
 "hm_pp_parentid": 0,
 "hm_pp_level": 0,
 "hm_pp_image": ""
 },
 {
 "program_id": 4,
 "hm_pp_name": "力量训练",
 "hm_pp_sort": 4,
 "hm_pp_parentid": 0,
 "hm_pp_level": 0,
 "hm_pp_image": ""
 },
 {
 "program_id": 5,
 "hm_pp_name": "篮球",
 "hm_pp_sort": 5,
 "hm_pp_parentid": 0,
 "hm_pp_level": 0,
 "hm_pp_image": ""
 },
 {
 "program_id": 6,
 "hm_pp_name": "羽毛球",
 "hm_pp_sort": 6,
 "hm_pp_parentid": 0,
 "hm_pp_level": 0,
 "hm_pp_image": ""
 },
 {
 "program_id": 7,
 "hm_pp_name": "有氧操",
 "hm_pp_sort": 7,
 "hm_pp_parentid": 0,
 "hm_pp_level": 0,
 "hm_pp_image": ""
 }......
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取私教项目列表成功= 10361,
 获取私教项目列表失败 = 10362,
 获取私教项目列表异常 = 10363，
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示项目列表的json数组	如上面参数所示
 */
///user/Education  USER_Education
+ (void)getProgramListWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure{
    // 根据key拼接url
    NSString *key = [self token];

    NSString *url = [NSString stringWithFormat:@"%@/%@?type=getproprogramlist",USER_Education, key];

    [self getWithURL:url success:^(id respondData) {
        ! success ? : success(respondData);
    } failure:^(HMErrorModel *error) {
        ! failure ? : failure(error);
    }];
}

/**********************************************密码相关******************************************************/
/**********************************************************************************************************/

/*
 98.修改支付密码(先调用发送验证码接口)
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "id": "e10adc3949ba59abbe56e057f20f883e",
 "whichFunc": "UPDATEPAYPWD"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 id	是	用MD5加密的修改密码
 whichFunc	是	决定调用哪个接口

 返回说明Json：
 {
 "errmsg": 10498,
 "succeed": true,
 "MsgTime": "2015-12-08T01:45:27.2748213+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，支付密码修改成功，false，支付密码修改失败
 errmsg	操作完成后返回信息	支付密码修改成功 = 10498,
 支付密码修改失败 = 10499,
 支付密码修改异常 = 10500
 MsgTime	操作完成后信息返回时间	2015-12-08T01:45:27.2748213+08:00
 valuse	无	null
 */

+ (void)userModifyPayPassword:(NSString *)password success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *whichFunc = @"UPDATEPAYPWD";
    NSString *ID = [password md5];
    NSDictionary *param = NSDictionaryOfVariableBindings(key,whichFunc,ID);

    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];

}

/*
 99.修改登录密码(先调用发送验证码接口)
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "id": "e10adc3949ba59abbe56e057f20f883e",
 "whichFunc": "UPDATELOGINPWD"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 id	是	用MD5加密的修改密码
 whichFunc	是	决定调用哪个接口

 返回说明Json：
 {
 "errmsg": 10498,
 "succeed": true,
 "MsgTime": "2015-12-08T01:45:27.2748213+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，登录密码修改成功，false，登录密码修改失败
 errmsg	操作完成后返回信息	登录密码修改成功 = 10498,
 登录密码修改失败 = 10499,
 登录密码修改异常 = 10500
 MsgTime	操作完成后信息返回时间	2015-12-08T01:45:27.2748213+08:00
 valuse	无	null

 */
+ (void)userModifyLoginPassword:(NSString *)password success:(RespondBlock)success failure:(ErrorBlock)failure{
   
    NSString *key = [self token];
    NSString *whichFunc = @"UPDATELOGINPWD";
    NSString *ID = [password md5];
    NSDictionary *param = NSDictionaryOfVariableBindings(key,whichFunc,ID);
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];

}

/*
 128.修改登录密码(不带key，先调用发送验证码接口)
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "13900000000",
 "id": "e10adc3949ba59abbe56e057f20f883e",
 "type": "123456",
 "whichFunc": "LOGINPWDNOKEY"
 }
 参数说明：
 参数	是否必须	描述
 key	是	手机号码
 id	是	用MD5加密的修改密码
 type	是	验证码
 whichFunc	是	决定调用哪个接口

 返回说明Json：
 {
 "errmsg": 10674,
 "succeed": true,
 "MsgTime": "2015-12-26T18:21:40.9976126+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，登录密码修改成功，false，登录密码修改失败
 errmsg	操作完成后返回信息	验证码已过期 = 10061,
 验证码不正确 = 10062,
 验证码通过 = 10063,
 验证码验证异常 = 10064,
 验证码已使用过 = 10315,
 从未向该手机号码发送过验证码 = 10326,
 未向该手机号码发送过该验证码 = 10327,
 验证通过且修改密码成功 = 10674,
 验证通过且修改密码失败 = 10675
 MsgTime	操作完成后信息返回时间	2015-12-08T01:45:27.2748213+08:00
 valuse	无	null

 */

+ (void)userForgetPasswordWithId:(NSString *)Id phoneNum:(NSString *)key type:(NSString *)type success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *whichFunc = @"LOGINPWDNOKEY";
    NSString *ID = [Id md5];
    NSDictionary *param = NSDictionaryOfVariableBindings(ID,key,type,whichFunc);
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}


/*
 129.验证登录密码(可用于更换手机号)
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "id": "e10adc3949ba59abbe56e057f20f883e",
 "whichFunc": "VERIFYLOGINPWD"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 id	是	用MD5加密的修改密码
 whichFunc	是	决定调用哪个接口

 返回说明Json：
 {
 "errmsg": 10669,
 "succeed": true,
 "MsgTime": "2015-12-26T16:31:13.313519+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，登录密码验证通过，false，登录密码验证失败
 errmsg	操作完成后返回信息	登录密码验证通过 = 10669,
 登录密码验证失败 = 10670,
 登录密码验证异常 = 10671
 MsgTime	操作完成后信息返回时间	2015-12-26T16:31:13.313519+08:00
 valuse	无	null
 */

+ (void)verifyLoginPasswordToReplacePhoneNumWithID:(NSString *)Id success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *ID = [Id md5];
    NSString *whichFunc = @"VERIFYLOGINPWD";
    NSDictionary *param = NSDictionaryOfVariableBindings(key,ID,whichFunc);
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}


 /*
 130.验证验证码，如果成功则更换手机号
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "",
 "id": "853559",
 "model": "13912345678",
 "whichFunc": "VERIFYANDMODIFY"
 }
 参数说明：
 参数	是否必须	说明	数据类型
 key	是	用户登录后返回的Token	string
 id	是	验证码	string
 model	是	手机号	string
 whichFunc	是	决定调用哪个接口	string

 返回说明Json：
 {
 "errmsg": 10031,
 "succeed": true,
 "MsgTime": "2015-12-26T17:52:58.5905739+08:00",
 "valuse": null
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true，操作成功false，操作失败
 errmsg	操作完成后返回信息	验证码已过期 = 10061,
 验证码不正确 = 10062,
 验证码通过 = 10063,
 验证码验证异常 = 10064,
 验证码已使用过 = 10315,
 从未向该手机号码发送过验证码 = 10326,
 未向该手机号码发送过该验证码 = 10327,
 验证通过且更换手机号成功 = 10672,
 验证通过但更换手机号失败 = 10673
 MsgTime	操作完成后信息返回时间	国际标准时间
 valuse	无	null
*/

+ (void)verifyVerificationCodeWithId:(NSString *)Id model:(NSString *)model success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    NSString *whichFunc = @"VERIFYANDMODIFY";
    NSDictionary *param = NSDictionaryOfVariableBindings(key,Id,model,whichFunc);
    [self postWithURL:POST_URL params:param success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

/*
 131.获取二维码解密后的信息
 网址：
 http://192.168.1.238:5000/post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIyNTA1NTI0NyIsImlhdCI6MTQ1MjgyOTIyOCwianRpIjpmYWxzZX0.-84YjyeO5_R2dLbm0BDiTAT0Ozdt9jDgtp8PchtzB2s",
 "id": "H+QswtaEYFKQ8cUA6xKt/xGRJNAukTpvdC/cIO4Qsa6RRupTJ9knloZ/ByijT32/EAhyw7EeZ58fWyf6W98wJCqKGeysNa+WuaDJaMRenV+Kb9e3JiCaB0g0FdjXAohNd+YMmAcZmgUoEW71d+o/PCQQd5F1c7Hjr3d3ZivAOfE=",
 "whichFunc": "GETERWEIMA"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 id	是	APP端加密后的公钥字符串
 
 返回说明Json：
 {
 "errmsg": 10677,
 "succeed": true,
 "MsgTime": "2015-12-26T22:13:02.318774+08:00",
 "valuse": {
 "Key": 3,--Key(1：用户ID，3：网页链接)
 "Value": "http://t.cn/RAlRBj3"--Value（用户ID，网页链接）
 }
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取二维码信息成功=10676
 获取二维码信息异常=10677
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示二维码信息的json数组	如上面参数所示
 
 //    NSString *url = [NSString stringWithFormat:@"%@?key=%@&EncryptKey=%@",getQRCode,key,EncryptKey];
 //    [self getWithURL:url success:^(id respondData) {
 //        success(respondData);
 //    } failure:^(HMErrorModel *error) {
 //        failure(error);
 //    }];
 
 */

+ (void)userGetQRCodeInfoWithEncryptKey:(NSString *)Id success:(RespondBlock)success failure:(ErrorBlock)failure{
    NSString *key = [self token];
    
    NSDictionary* params = @{@"key":key,@"id":Id,@"whichFunc":@"GETERWEIMA"};
    
    [self postWithURL:POST_URL params:params success:^(id respondData) {
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

/*
 156.微信登录
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
 "key": "592170388",
 "id": "192157302",
 "whichFunc": "WECHATLOGIN"
 }
 参数说明：
 参数	是否必须	说明	数据类型
 key	是	微信openid	string
 id	是	微信unionID	string
 whichFunc	是	决定调用哪个接口	string
 
 返回说明Json：
 {
 "errmsg": 10004,
 "succeed": true,
 "MsgTime": "2016-01-14T11:10:42.5802511+08:00",
 "valuse": {
 "Access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIzNzQ3MzY1MiIsImlhdCI6MTQ1Mjc0MTA0MCwianRpIjpmYWxzZX0.h83ppPFaPZoLh19Ts6LF_WLoy5Torno6f7gojENucfM", --登录成功返回key
 "expires_in": 604800--过期时间
 }
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true/false
 errmsg	操作完成后返回信息	登陆失败 = 10000,
 密码错误 = 10001,
 登陆帐号错误 = 10002,
 令牌错误 = 10003,
 会员登陆成功 = 10004,
 数据完整性检查不通过 = 10005,
 签名时间戳失效 = 10006,
 该用户长时间没有登陆让用户重新陆 = 10007,
 用户信息不一致 = 10022,
 游客登陆成功 = 10253
 MsgTime	操作完成后信息返回时间	国际标准时间
 valuse.Access_token	令牌	APP接收到要存储在APP上，接下来的操作都要带上该令牌
 valuse.expires_in	过期时间	此时间存储在APP 以便判断令牌是否过期
 
 */

+ (void)userWechatLoginWithOpenid:(NSString *)key UnionID:(NSString *)ID success:(RespondBlock)success failure:(ErrorBlock)failure{
    
    NSString *whichFunc = @"WECHATLOGIN";
    NSDictionary *params = NSDictionaryOfVariableBindings(key,ID,whichFunc);
    
    [HMNetworking postWithURL:POST_URL params:params success:^(id respondData) {
        
        // 保存令牌
        NSString *token = [respondData valueForKeyPath:@"valuse.Access_token"];
        if (NotNilAndNull(token) && token.length) {
            [[[HMNetworking alloc] init] performSelectorOnMainThread:@selector(setToken:) withObject:token waitUntilDone:YES];
        }
        
        success(respondData);
    } failure:^(HMErrorModel *error) {
        failure(error);
    }];
}

/**********************************************密码相关******************************************************/
/**********************************************************************************************************/

@end
