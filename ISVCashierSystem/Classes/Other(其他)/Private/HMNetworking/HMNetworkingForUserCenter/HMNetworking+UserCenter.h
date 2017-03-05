//
//  HMNetworking+UserCenter.h
//  HealthMall
//
//  Created by jkl on 15/10/30.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMNetworking.h"

@interface HMNetworking (UserCenter)

/**
 *  用户注册
 *
 *  @param telephone 电话
 *  @param pwd       密码
 *  @param nickName  昵称
 *  @param sex       性别
 *  key： 微信openid，微信注册时传入； id： 微信unionID，微信注册时传入；type 微信注册时传入（WECHAT）
 */
+ (void)userRegisterWithTelephone:(NSString *)telephone
                         password:(NSString *)pwd
                         nickname:(NSString *)nickName
                              sex:(NSString *)sex
                             type:(NSString *)type
                              key:(NSString *)key
                               ID:(NSString *)ID
                          success:(RespondBlock)success
                          failure:(ErrorBlock)failure;

#pragma mark - 用户登录(会员登录)
/**
 * `用户登录`
 * userName:用户名
 * password:密码
 */
+ (void)userLoginWithUserName:(NSString *)userName
                     password:(NSString *)pwd
                     success:(RespondBlock)success
                     failure:(ErrorBlock)failure;

#pragma mark - 用户登录(游客登录)
/**
 * `游客登录`
 */
+ (void)userLoginForVisitorWithSuccess:(RespondBlock)success
                               failure:(ErrorBlock)failure;
#pragma mark - 获取新Token
+ (void)userGetNewTokenWithSuccess:(RespondBlock)success
                           failure:(ErrorBlock)failure;

/**
 *  用户退出登录
 *
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)userLogoutWithSuccess:(RespondBlock)success
                      failure:(ErrorBlock)failure;

/**
 * `用户信息修改`
 * sex:性别
 * age:年龄
 * province:所在省份
 * city:所在城市
 * job:职业
 * caseHistory:过往病史
 * height:身高
 * weight:体重
 * signature:个性签名
 * teaching:私教可授课项目
 * courseCost:私教课程费用
 */
+ (void)userModifyWithAge:(NSUInteger )age
                     city:(NSString *)city
                      job:(NSString *)job
              caseHistory:(NSString *)caseHistory
                   height:(NSUInteger )height
                   weight:(NSUInteger )weight
                signature:(NSString *)signature
                  success:(RespondBlock)success
                  failure:(ErrorBlock)failure;
/**
 * `修改昵称`
 * nickname:昵称
 */
+ (void)userModifyWithNickname:(NSString *)nickname
                 headImageCode:(NSString *)hm_u_headImage
                       success:(RespondBlock)success
                       failure:(ErrorBlock)failure;


/*****************************验证码相关********************************/
/**
 * `请求验证码`
 * tel:手机号码
 */
//+ (void)requestSMSCodeWithTel:(NSString *)tel
//                     codeType:(NSString *)codeType
//                          key:(NSString *)keyType
//                      success:(RespondBlock)success
//                      failure:(ErrorBlock)failure;
+ (void)requestSMSCodeWithTel:(NSString *)User_Name codeType:(NSString *)codeType key:(NSString *)keyType exte:(NSString *)exte success:(RespondBlock)success failure:(ErrorBlock)failure;
/**
 *  验证验证码
 *
 *  @param telephone 手机号码
 *  @param code      验证码
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)verifySMSCodeWithTel:(NSString *)telephone
                        code:(NSString *)code
                     success:(RespondBlock)success
                     failure:(ErrorBlock)failure;
/*****************************验证码相关********************************/


/**
 *  获取订单列表
 *
 *  @param type    type=user，用户看自己的订单列表(ps：私教看自己约私教的订单也是这个)；type=trainer，私教看用户约自己的订单列表
 *  @param page    第几页
 *  @param count   每页显示数量
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)getUserOrderWithType:(NSString *)type
                        page:(NSUInteger )page
                       count:(NSInteger)count
                     success:(RespondBlock)success
                     failure:(ErrorBlock)failure;
/**
 *  获取订单详情（根据订单ID）
 *
 *  @param orderId 订单ID
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)orderDetailInfoWithOrderId:(NSString *)orderId
                           success:(RespondBlock)success
                           failure:(ErrorBlock)failure;
/**
 *  165.订单取消与删除
 *
 *  @param orderbiaoshi     订单标示：
 *  @param operationbiaoshi 操作标示：
 *  @param order_id         订单ID
 *  @param success          成功
 *  @param failure          失败
 */
+ (void)userCancelOrDeleteOrderWithOrderMarked:(NSString *)orderbiaoshi
                               operationMarked:(NSString *)operationbiaoshi
                                       orderId:(NSString *)order_id
                                       success:(RespondBlock)success
                                       failure:(ErrorBlock)failure;

#pragma mark -
#pragma mark - wallet钱包相关
/*******************************钱包*****************************************/
/***************************************************************************/
/**
 *  点击钱包事件
 *
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)clickWalletWithSuccess:(RespondBlock)success
                      failure:(ErrorBlock)failure;

/**
 *  获取钱包实体信息
 *
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)myWalletModelWithSuccess:(RespondBlock)success
                         failure:(ErrorBlock)failure;
/**
 *  设置钱包密码
 *
 *  @param ID      密码
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)setMyWalletPassWordWithID:(NSString *)ID
                          success:(RespondBlock)success
                          failure:(ErrorBlock)failure;
/**
 *  验证钱包密码
 *
 *  @param password 输入的密码
 *  @param userID   用户ID
 *  @param success  成功
 *  @param failure  失败
 */
+ (void)verifyMyWalletPasswordWithPassword:(NSString *)password
                                    userID:(NSString *)userID
                                   success:(RespondBlock)success
                                   failure:(ErrorBlock)failure;

/**
 *  提现申请
 *
 *  @param flag    银行卡标志
 *  @param amount  金额
 *  @param FEE     手续费
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)userWithdrawBankCardFlag:(NSString *)flag
                          amount:(NSString *)amount
                      rateamount:(NSString *)FEE
                         success:(RespondBlock)success
                         failure:(ErrorBlock)failure;

/**
 *  163.获取支付明细
 *
 *  @param orderid type=detail时，必传
 *  @param page    type=list时，必传，第几页
 *  @param count   type=list时，必传，每页记录数
 *  @param type    type=detail，获取明细详情，type=list时，获取明细列表
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)getUserIncomeAndExpensesWithOrderid:(NSString *)orderid
                                       page:(NSUInteger )page
                                      count:(NSUInteger )count
                                       type:(NSString *)type
                                    success:(RespondBlock)success
                                    failure:(ErrorBlock)failure;

/**
 *  用户获取优惠券
 *
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)userGetCouponWithSuccess:(RespondBlock)success
                         failure:(ErrorBlock)failure;

/**
 *  新增或删除银行卡
 *
 *  @param bankcard   银行卡号
 *  @param account    持卡人姓名
 *  @param phone      持卡人手机号码
 *  @param bank       开户银行
 *  @param banktype   卡片类型 借记卡或信用卡
 *  @param isValidate 是否实名验证
 *  @param bankimage  银行卡图标
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)userAddBankCard:(NSString *)bankcard
                account:(NSString *)account
                  phone:(NSString *)phone
                   bank:(NSString *)bank
               banktype:(NSString *)banktype
             isValidate:(NSString *)isValidate
              bankimage:(NSString *)bankimage
                adddate:(NSString *)adddate
                   type:(NSString *)type
                 idcard:(NSString *)idcard
                success:(RespondBlock)success
                failure:(ErrorBlock)failure;
/**
 *  获取用户银行卡列表
 */
+ (void)userBankCardListWithSuccess:(RespondBlock)success
                            failure:(ErrorBlock)failure;

/**
 *  获取所有银行列表
 */
+ (void)userAllBankListWithSuccess:(RespondBlock)success
                           failure:(ErrorBlock)failure;

/**
 *  银行卡鉴权
 */
+ (void)userAllBankAuthenticationWithName:(NSString *)name IDCard:(NSString *)IDCard mobile:(NSString *)mobile bankCardNum:(NSString *)bankCardNum success:(RespondBlock)success failure:(ErrorBlock)failure;
/*******************************钱包*****************************************/
/***************************************************************************/
#pragma mark -

/**
 * `获取用户实体信息`
 *  userID:用户ID, 如果获取当前登录用户的信息, userID传nil即可;
 */
+ (void)userModelWithUserID:(NSString *)userID
                  success:(RespondBlock)success
                  failure:(ErrorBlock)failure;


/**
 * `拉取附近用户`
 * page:第几页
 * genderOption:男,女,所有
 * sortOption:升序, 降序
 */
+ (void)getListOfNearUserWithPage:(NSUInteger )page
                            count:(NSUInteger )count
                     genderOption:(HMSexType)sex
                       sortOption:(HMSortOption)sortOption
                          success:(RespondBlock)success
                          failure:(ErrorBlock)failure;


/**
 *  存储用户位置
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param latitude  城市编码
 *  @param success   成功
 *  @param failure   失败
 */
+ (void)tellPositionWithLongitude:(NSString *)HM_GNU_Longitude latitude:(NSString *)HM_GNU_Latitude city:(NSString *)city success:(RespondBlock)success failure:(ErrorBlock)failure;

#pragma mark 用户下单
/**
 * `用户下单`
 * coachID:私教Id
 * serverProgram:服务项目
 * serverTime:服务时段(例如:"9:00-10:00,20:00-21:00" -> @[@"9", @"20"];)
 * serverDate:服务日期
 * serverLocation:服务地址
 * price:订单单价
 * orderType:订单类型
 * tel:手机号码
 * remark(可为空):备注
 */
+ (void)userOrderWithCoachID:(NSString *)HM_PTrainerId
               serverProgram:(NSString *)HM_ServerProgram
                  serverTime:(NSArray *)HM_ServerTime
                  serverDate:(NSString *)hm_serverdate
              serverLocation:(NSString *)HM_ServerLocation
                       price:(NSString *)HM_UnitPrice
                   orderType:(NSString *)HM_OrderType
                         tel:(NSString *)HM_UserPhone
                      remark:(NSString *)HM_Remark
                     success:(RespondBlock)success
                     failure:(ErrorBlock)failure;



/**
 *  用户给私教评分
 *
 *  @param score   分数值
 *  @param content 评价内容
 *  @param orderid 订单ID
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)userEvaluateCoachScore:(NSString *)score
                       content:(NSString *)content
                       orderId:(NSString *)orderid
                          type:(NSString *)type
                       success:(RespondBlock)success
                       failure:(ErrorBlock)failure;


/**
 *  获取学历
 *
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)userEducationListWithSuccess:(RespondBlock)success
                            failure:(ErrorBlock)failure;

#warning 获取性别接口未有
// 获取性别


/**
 *  75.获取所有项目列表
 *
 *  @param success 成功
 *  @param failure =失败
 */
+ (void)getProgramListWithSuccess:(RespondBlock)success
                          failure:(ErrorBlock)failure;


#pragma mark - 修改密码相关
/******************************SETUP**********************************/
/**
 *  修改支付密码
 *
 *  @param password 新密码
 *  @param success  成功
 *  @param failure  失败
 */
+ (void)userModifyPayPassword:(NSString *)password
                      success:(RespondBlock)success
                      failure:(ErrorBlock)failure;
/**
 *  99、修改登录密码（带key的修改密码，已登录状态）
 *
 *  @param password 新密码
 *  @param success  成功
 *  @param failure  失败
 */
+ (void)userModifyLoginPassword:(NSString *)password
                        success:(RespondBlock)success
                        failure:(ErrorBlock)failure;
/**
 *  128.修改登录密码(不带key，先调用发送验证码接口，忘记密码，未登录状态)
 *
 *  @param Id      用MD5加密的修改密码
 *  @param key     手机号码
 *  @param type    验证码
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)userForgetPasswordWithId:(NSString *)Id
                        phoneNum:(NSString *)key
                            type:(NSString *)type
                         success:(RespondBlock)success
                         failure:(ErrorBlock)failure;

/**
 *  129.验证登录密码(可用于更换手机号)
 *
 *  @param Id      用MD5加密的修改密码
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)verifyLoginPasswordToReplacePhoneNumWithID:(NSString *)Id
                                           success:(RespondBlock)success
                                           failure:(ErrorBlock)failure;

/**
 *   130.验证验证码，如果成功则更换手机号
 *
 *  @param Id      验证码
 *  @param model   手机号
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)verifyVerificationCodeWithId:(NSString *)Id model:(NSString *)model
                             success:(RespondBlock)success
                             failure:(ErrorBlock)failure;
/**
 *   131.获取二维码解密后的信息
 *
 *  @param EncryptKey APP端加密后的公钥字符串
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)userGetQRCodeInfoWithEncryptKey:(NSString *)EncryptKey
                                success:(RespondBlock)success
                                failure:(ErrorBlock)failure;

/**
 *  156.微信登录
 *
 *  @param key     微信openid
 *  @param ID      微信unionID
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)userWechatLoginWithOpenid:(NSString *)key
                          UnionID:(NSString *)ID
                          success:(RespondBlock)success
                          failure:(ErrorBlock)failure;

/******************************SETUP**********************************/
#pragma mark -
@end
