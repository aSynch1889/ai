//
//  ISVNetworking+Common.m
//  ISV
//
//  Created by aaaa on 15/11/24.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVNetworking+Common.h"
#import "NSString+ISVHash.h"

@implementation ISVNetworking (Common)

#pragma - 上传图片(非头像)
+ (void)uploadImagesWithPaths:(NSArray<NSString *> *)imagePaths success:(RespondBlock)success failure:(ErrorBlock)failure
{
    [self uploadImageWithPaths:imagePaths userID:ISV_NULL success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];

}

#pragma - 上传头像
+ (void)uploadAvatorWithPath:(NSString *)imagePath userID:(NSString *)userID success:(RespondBlock)success failure:(ErrorBlock)failure
{
    [self uploadImageWithPaths:@[imagePath] userID:userID success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

#pragma - 获取多种项目类型
+ (void)projectListWithProjectType:(ISVProjectType)type success:(RespondBlock)success
                           failure:(ErrorBlock)failure
{
    // 根据key拼接url
    NSString *url = nil;
    switch (type) {
        case ISVProjectTypeAskFriend:
            url = [NSString stringWithFormat:@"%@?type=getprogramlist&key=%@&id=&page=1&count=1000",COMMON_PROJECTLIST_AskFriend, [self token]];
            break;
        case ISVProjectTypeAskCoach:  // 75号接口
            url = [NSString stringWithFormat:@"%@/%@?type=getproprogramlist",COMMON_PROJECTLIST_AskCoach, [self token]];
            break;
        case ISVProjectTypePlace:
            url = [NSString stringWithFormat:@"%@?type=getproprogramlist&key=%@&page=1&count=1000",COMMON_PROJECTLIST_Place, [self token]];
            break;
        case ISVProjectTypeRegimen:
            url = [NSString stringWithFormat:@"%@?key=%@&type=getproprogramlist&page=1&count=1000",COMMON_PROJECTLIST_Regimen, [self token]];
            break;
        default:
            url = [NSString stringWithFormat:@"%@?type=getprogramlist&key=%@&id=&page=1&count=1000",COMMON_PROJECTLIST_Place, [self token]];
            break;
    }

    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];

}


#pragma mark - Private
/*
 网址：http://192.168.1.238:85/Post
 类型：POST
 数据类型：Content-Type: application/json
 传入JSON:
 {
 "signature": "0FFD9EC21614DED223ABABEB1160E7595949CCE1",
 "timestamp": "1447065963",
 "nonce": "123456",
 "ImgS": ["base64String","base64String","base64String"],
 "type":"UpPhoto",
 "User_Id":"123456"
 }
 参数说明：
 参数	是否必须	描述
 Signature	是	输入的时间戳+随机字符串+自定义的code（fse9aZbwzjysbmHKN1zULHQ），进行字典排序后，再进行SHA1加密
 timestamp	是	时间戳
 nonce	是	随机生成字符串
 ImgS[]	是	图片BASE64 编码，以数组字符串形式回传
 type	否	当TYPE=UpPhoto  时候说明是上传头像，此时User_id 必须填写
 User_Id	否	用户ID，如果TYPE=UpPhoto的时候此项是必填
 注意：密码字段换成固定密码：fse9aZbwzjysbmHKN1zULHQ
 使用例子：
 signature的加密：
 C# 下操作演示
 string[] ArrTmp = { model.ISV_U_Pwd, models.timestamp, models.nonce };
 Array.Sort(ArrTmp);
 string tmpStr = string.Join("", ArrTmp);
 tmpStr = FormsAuthentication.HashPasswordForStoringInConfigFile(tmpStr, "SHA1");
 返回参数说明：
 {
 "errmsg": 104402,
 "succeed": true,
 "MsgTime": "2015-10-04T16:44:57.9541705+08:00",
 "valuse": [
 "E9C1AD87AD1170B1B39452A4DE6403FAD2EC6D7C",
 "E9C1AD87AD1170B1B39452A4DE6403FAD2EC6D7C",
 "E9C1AD87AD1170B1B39452A4DE6403FAD2EC6D7C"
 ]
 }
 参数	说明	值
 succeed	操作完成后返回状态	true：上传成功，false：上传失败，具体看错误
 MsgTime	返回时间	操作时间
 errmsg	操作完成后返回信息	上传成功 = 10403,
 密钥验证信息失败 = 10404,
 上传图片异常(请检查BASE64码) = 10405,
 没有收到任何图片信息 = 10403
 valuse	图片SHA1数组，批量上传会有多个	[“a”,”b”,”c”]

 图片访问地址：
 http://192.168.1.238:83/photos/C4E3D2A51162CFCABB9CD576EEA3637E/
 http://192.168.1.238:83/photos/C4E3D2A51162CFCABB9CD576EEA3637E/1
 http://192.168.1.238:83/photos/C4E3D2A51162CFCABB9CD576EEA3637E/2

 C4E3D2A51162CFCABB9CD576EEA3637E 服务器返回的sha1编码

 头像：

 /1 代表 320*320
 /2 代表 160*160


 其它图片：
 /1 代表 1024   或高 640
 /2 代表 480   或高 320

 */
#pragma - 上传图片
+ (void)uploadImageWithPaths:(NSArray *)imagePaths userID:(NSString *)User_Id success:(RespondBlock)success failure:(ErrorBlock)failure
{

    // 1.生成随机数
    NSString *nonce = @(arc4random()).description;

    // 2.生成时间戳
    NSString *timestamp = @(@(NSDate.date.timeIntervalSinceReferenceDate * 10).integerValue).description;

    // 3.排序
    NSArray *arr = @[nonce, timestamp, @"fse9aZbwzjysbmHKN1zULHQ"];
    NSArray *sortedArr = [arr sortedArrayUsingSelector:@selector(compare:)];
    NSString *sortedString = [sortedArr componentsJoinedByString:@""];

    // 4.计算哈希值
    NSString *signature = [sortedString sha1];

    // 5.判断是否头像
    NSString *type = [User_Id isEqualToString:ISV_NULL] ? ISV_NULL : @"UpPhoto";

    // 6.图片base64编码
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        NSMutableArray *ImgS = [NSMutableArray array];
        NSError *err = nil;
        for (NSString *path in imagePaths)
        {
            
            NSData *data = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:&err];
            NSString *encode = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

            if (err)
            {
                ISVErrorModel *errModel = [[ISVErrorModel alloc] init];
                errModel.error = err;

                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(errModel);
                });

                return;
            }
            else
            {
                [ImgS addObject:encode];
            }
        }

        // 7.拼接参数
        NSString *url = POST_URL;
        NSDictionary *param = NSDictionaryOfVariableBindings(signature, timestamp, nonce, User_Id, type, ImgS);

        // 8.开始POST请求
        [self postWithURL:url serverAddress:SERVER_IMAGES_UPLOAD params:param success:^(id respondData) {
            success(respondData);
        } failure:^(ISVErrorModel *error) {
            failure(error);
        }];

    });
}


/*
 127.获取腾讯视频鉴权信息
 网址：
 /user/OperateUser/Gettxspaccredit?key=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI0NjY0Njc3NyIsImlhdCI6MTQ1MDE1MTI0NSwianRpIjpmYWxzZX0.ArcRTd58djPbqaxRpzdd0WU6Yex9xUytf3yIVyXoh30&bucketName=哈哈
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 bucketName	是	bucket名称
 （即视频空间名称）
 
 返回说明Json：
 {
 "errmsg": 10667,
 "succeed": false,
 "MsgTime": "2015-12-25T21:47:08.791697+08:00",
 "valuse": "MIy8WsGQubC/wf1msjzZ5OcyHSJhPTEwMDAwOTQwJms9QUtJRG9LdlZMbFNSM0pKSVR4UU1KYU1lVDVBdzhONDZwY2hGJmU9MTQ1MTA1MTI3MSZ0PTE0NTEwNTEyMTQmcj0xMDIyMDMxNzgyJmY9JmI95ZOI5ZOI"--鉴权信息字符串
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取腾讯视频鉴权成功=10667,
 获取腾讯视频鉴权异常=10668,
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示鉴权信息的json数组	如上面参数所示
  */
#pragma mark  127.获取腾讯视频鉴权信息
+ (void)authenWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&bucketName=%@", SPACE_AUTHEN, self.token, @"coach"];
    
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

/*
 139.获取城市列表
 网址：
 http://192.168.1.238:5000/Venue/GetAllCityList?
 key=
 &code=
 
 类型：get
 数据类型：Content-Type: application/json
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 code	否	code>0，查询该code对应的城市信息；code<0或者不传，查询所有城市信息
 
 返回说明Json：
 {
 "errmsg": 10522,
 "succeed": true,
 "MsgTime": "2016-01-04T20:51:21.232893+08:00",
 "valuse": [
 {
 "tbid": 936,
 "code": 1302,--城市代码
 "parentid": 13, --父id
 "tb_name": "唐山市",--城市名称
 "tb_level": 2,--城市等级，2表示市级
 "coordinate": {--坐标
 "lat": 113.263319,
 "lng": 23.155246
 }
 }
 ]
 }
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	True / false
 errmsg	操作完成后返回信息	获取城市列表成功 = 10522,
 获取城市列表异常 = 10523,
 登录失败=10000
 MsgTime	操作完成后信息返回时间	2015-10-07T11:25:38.185579+08:00
 valuse	表示城市列表的json数组	如上面参数所示
 
 */
#pragma mark  139.获取城市列表
+ (void)cityListWithCityCode:(NSString *)code isHot:(BOOL)isHot success:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *hot = isHot?@"&type=hot":@"";
    
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&code=%@%@", COMMON_CITY_LIST, self.token, code, hot];
    
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

#pragma mark - 支付
/**
 * `获取支付方式列表`
 */
+ (void)getPaymentListWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *url = [NSString stringWithFormat:@"%@?key=%@", COMMON_PaymentList, self.token];
    
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

/**
 * `获取支付配置信息`
 */
+ (void)getPayConfigWithPayWay:(ISVPayWay)payWay orderType:(ISVOrderType)OrderType orderId:(NSString *)OrderId success:(RespondBlock)success failure:(ErrorBlock)failure
{
    NSString *orderTypeStr = ISVOrderTypeDesc[@(OrderType)];
    
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&PayType=%zd&OrderId=%@&OrderType=%@", COMMON_PayConfig, self.token, payWay, OrderId, orderTypeStr];
    
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}

/**
 *  `获取最新版本信息`
 */
+ (void)getLatestVersionWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure
{
    // systemtype 0=Android；1=IOS；2=WindowsPhone；
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&systemtype=1", COMMON_LatestVersion, self.token];
    
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}


/*
 160.获取广告列表
 网址：http://192.168.1.238:5000
 /Home/CommonTag/GetADList?
 key=
 &page=1
 &count=10
 
 类型：get
 数据类型：Content-Type: application/json
 传入Json：无
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 page	是	第几页
 count	是	每页广告数
 返回说明Json：
 {
 "errmsg": 10826,
 "succeed": true,
 "MsgTime": "2016-01-25T17:26:36.1214665+08:00",
 "valuse": [
 {
 "ISV_ad_id": 2, --广告id
 "ISV_ad_title": "ad2", --广告标题，供后台区分，app不需要
 "ISV_ad_picurl": "picurl2", --广告图片地址
 "ISV_ad_interval": 10, --显示时间
 "ISV_ad_canclick": true, --是否可点击
 "ISV_ad_clickurl": "clickurl2", --点击后链接的url
 "ISV_ad_status": 1, --状态，0-->不显示，1-->显示
 "ISV_ad_createtime": "2016-01-25T16:51:03.338264"--创建时间
 }
 ]}
 参数说明：
 参数	说明	值
 succeed	操作完成后返回状态	true/false
 errmsg	操作完成后返回信息	获取广告列表成功 = 10826,
 获取广告列表异常 = 10827
 MsgTime	操作完成后信息返回时间	2016-01-25T17:26:36.1214665+08:00
 valuse	广告列表
 */
#pragma mark - 获取广告列表
+ (void)launchAdWithPage:(NSInteger)page
                   count:(NSInteger)count
              deviceType:(NSInteger)deviceType
                   width:(NSInteger)width
                  height:(NSInteger)height
                 success:(RespondBlock)success
                 failure:(ErrorBlock)failure
{
    NSString *url = [NSString stringWithFormat:@"%@?key=%@&page=%zd&count=%zd&type=ios&size=%zd&width=%zd&height=%zd",
                     COMMON_AD_LIST,
                     [self token],
                     page,
                     count,
                     deviceType,
                     width,
                     height
                     ];
    [self getWithURL:url success:^(id respondData) {
        success(respondData);
    } failure:^(ISVErrorModel *error) {
        failure(error);
    }];
}



/*
 161.点击广告记录
 网址：http://192.168.1.238:5000/Post
 类型：post
 数据类型：Content-Type: application/json
 传入Json：
 {
     "key": "",
     "id": 1,
     "whichFunc": "ADCLICK"
 }
 参数说明：
 参数	是否必须	描述
 key	是	用户登录后返回的token
 id	是	广告id
 whichFunc	是	决定调哪一个接口
 */
#pragma mark - 点击广告记录
+ (void)upLogForAdClickWithAdID:(NSString *)adID
                        success:(RespondBlock)success
                        failure:(ErrorBlock)failure
{
    NSString *key = [self token];
    
    if (adID==nil || key==nil)
    {
        ISVErrorModel *err = [[ISVErrorModel alloc] init];
        
#if DEBUG
        err.errMsg = @"广告ID或者令牌为空";
#endif
        failure(err);
    }
    else
    {
        NSDictionary *param = @{@"key":key ,
                                @"id":adID,
                                @"whichFunc":@"ADCLICK"};
        [self postWithURL:POST_URL params:param success:^(id respondData) {
            success(respondData);
        } failure:^(ISVErrorModel *error) {
            failure(error);
        }];
    }
}


#pragma mark - 148.获取公共key
+ (void)commonKeyWithSuccess:(RespondBlock)success failure:(ErrorBlock)failure
{
    [self getWithURL:CommonKey success:^(id respondData) {
        
        // 保存令牌
        NSString *token = Response_Valuse;
        if (!token) {
            token = kDefaultKey;
        }

        [[[ISVNetworking alloc] init] performSelectorInBackground:@selector(setToken:) withObject:token];
        
        success(respondData);
        
    } failure:^(ISVErrorModel *error) {
        
        [[[ISVNetworking alloc] init] performSelectorInBackground:@selector(setToken:) withObject:kDefaultKey];
        
        failure(error);
        
    }];
}

@end
