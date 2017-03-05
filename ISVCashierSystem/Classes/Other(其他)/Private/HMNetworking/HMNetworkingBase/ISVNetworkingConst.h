//
//  ISVNetworkingConst.h
//  ISV
//
//  Created by aaaa on 15/10/31.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark - 域名配置
extern NSString *const SERVER_ADRESS;
/// 图片上传域名
extern NSString *const SERVER_IMAGES_UPLOAD;

#pragma mark -
#pragma mark - post请求接口
/// post请求
extern NSString *const POST_URL;

#pragma mark - 公共接口:
#pragma mark >项目类型(约动友)
extern NSString *const COMMON_PROJECTLIST_AskFriend;
#pragma mark >项目类型(约便)
extern NSString *const COMMON_PROJECTLIST_AskCoach;
#pragma mark >项目类型(掌柜)
extern NSString *const COMMON_PROJECTLIST_Place;
#pragma mark >项目类型(钱xx)
extern NSString *const COMMON_PROJECTLIST_Regimen;
#pragma mark >获取所有城市列表
extern NSString *const COMMON_CITY_LIST;
#pragma mark >获取支付方式列表
extern NSString *const COMMON_PaymentList;
#pragma mark >获取支付配置信息
extern NSString *const COMMON_PayConfig;
#pragma mark >获取最新版本信息
extern NSString *const COMMON_LatestVersion;
#pragma mark >获取广告列表
extern NSString *const COMMON_AD_LIST;
#pragma mark >获取公共key
extern NSString *const CommonKey;

#pragma mark >微视频
extern NSString *const SPACE_AUTHEN;

#pragma mark -
#pragma mark - 用户接口
/// 用户操作
extern NSString *const USER_OPERATE;
/// 用户登录
extern NSString *const USER_LOGIN;
///用户退出登录
extern NSString *const USER_LOGOUT;
/// 用户注册
extern NSString *const USER_REGISTER;
/// 用户信息修改
extern NSString *const USER_MODIFY;
/// 获取学历
extern NSString *const USER_Education;
/// 获取新令牌
extern NSString *const  USER_GET_NEW_TOKEN;

/// 请求验证码
extern NSString *const REQUEST_SMS_CODE;
/// 验证验证码
extern NSString *const VERIFY_SMS_CODE;
///获取订单
extern NSString *const GETORDER;
///点击钱包事件
extern NSString *const INITWALLET;
///获取钱包实体
extern NSString *const WALLET;
///设置钱包密码
extern NSString *const SETMYWALLETPASSWORD;
///获取优惠券
extern NSString *const USERGETCOUPON;
///获取用户银行卡列表
extern NSString *const USER_BANKCARDLIST;
///获取所有银行列表
extern NSString *const USER_ALLBANKLIST;

///获取收支明细
extern NSString *const USER_GETBALANCE;

/// 存储用户位置
extern NSString *const POSITION;

#pragma mark -
#pragma mark - 便

/// 便注册
extern NSString *const COACH_APPLY;
/// 便信息修改
extern NSString *const COACH_MODIFY;
/// 便资质
extern NSString *const COACH_QUALIFICATION;
#pragma mark >根据邀请码获取便名字
extern NSString *const COACH_NameByInviteCode;
#pragma mark >获取便信息
extern NSString *const COACH_INFO;
/// 便开启接单模式
extern NSString *const START_ORDER_MODE;
/// 便订单（便端）
extern NSString *const COACH_ORDER;
/// 便操作订单（便端）
extern NSString *const COACH_OPERATEORDER_PT;
/// 便图片或视频管理
extern NSString *const COACH_PTWOODMANAGE;
/// 获取便图片或视频
extern NSString *const COACH_MOREWOODINFO;
/// 便上传封面图片
extern NSString *const COACH_PTWOODTOPIMG;
/// 获取便团购课程列表+排序+筛选+分页
extern NSString *const HOME_COURSE_LIST;
/// 获取便团队
extern NSString *const COASH_TEAM;
/// 获取课程订单详情
extern NSString *const COACH_CourseOrderDetail;

#pragma mark -
#pragma mark - 首页
/// 首页标签
extern NSString *const HOME_TAG;
extern NSString *const COURSE_DETAIL_INFO;
#pragma mark >获取便发布的课程列表
extern NSString *const HOME_COURSE_ALL;
#pragma mark >获取用户咨询列表
extern NSString *const HOME_CONSULT;
#pragma mark >获取已付款成功的团购用户头像列表
extern NSString *const HOME_COURSE_SIGN_PERSON;
#pragma mark >获取团购点赞用户列表
extern NSString *const HOME_COURSE_PRAISE_LIST;
#pragma mark >每周之星或者便推荐列表
extern NSString *const HOME_WEEKSTARS_COACH_PUT;

#pragma mark - 约动友
/// 约动友邀约详情
extern NSString *const ASK_FRIEND_Minute;
/// 约动友综合排序
extern NSString *const COMPOSITE_ORDERBY;
/// 约动友邀请详情评论
extern NSString *const COMMENT_LIST;
/// - 约动友 - 我的邀约列表
extern NSString *const MY_INVIT;
/// - 约动友 - 我的报名列表
extern NSString *const MY_SIGNUP;
/// - 约动友 - 发布邀约
extern NSString *const RELEASE_INVIT;
/// - 约动友 - 撤销邀约
extern NSString *const CANCEL_INVIT;
/// - 约动友 - 报名人员列表
extern NSString *const SIGNUP_LIST;
/// - 约动友 - 获取活动报名人员列表(报名管理)
extern NSString *const ACTION_SIGNUP_LIST;
/// - 约动友 - 报名邀约(邀约详情点击报名)
extern NSString *const SIGNUP_INVITE;
/// - 约动友 - 接受/不接受邀约
extern NSString *const ACCESS_INVITE;
/// - 约动友 - 获取请客类型列表
extern NSString *const TREAT_TYPE;
/// - 约动友 - 获取邀约对象列表
extern NSString *const INVIT_OBJECT;
/// - 约动友 - 获取性别列表
extern NSString *const SEX_LIST;

/// - 约动友 - 获取性别列表 - 获取邀约评论
extern NSString *const INVIT_COMMENT;

/// - 约动友 - 获取项目列表
extern NSString *const PROJEST_LIST;

/// 健康小屋
extern NSString *const CABIN_INFO;

#pragma mark - 获取便团队
extern NSString *const COASH_TEAM;



#pragma mark -----------钱xx接口
//筛选钱xx
extern NSString *const CARE_OCCASION;
//店铺详情
extern NSString *const STORE_DETAILS;

#pragma mark----------------约掌柜接口
///约掌柜筛选
extern NSString *const INVIT_LIST;

//我的粉丝
extern NSString *const MY_FANS;

//获取粉丝关注的用户列表
extern NSString *const getUserConcerned;


/*
 ///   12.便操作订单
 extern NSString *const
 ///   13.验证验证码
 extern NSString *const
 ///   14.获取订单
 extern NSString *const
 ///   15.点击钱包事件
 extern NSString *const
 ///   16.获取钱包实体
 extern NSString *const
 ///   17.设置钱包密码
 extern NSString *const
 ///   18.验证钱包密码（因为传入的signature固定，所以只能验证密码123）
 extern NSString *const
 ///   19.提现申请
 extern NSString *const
 ///   20.提现申请通过
 extern NSString *const
 ///   21.用户给便评分
 extern NSString *const POST_URL;
 ///   22.发送好友申请
 extern NSString *const
 ///   23.添加好友（接受申请）
 extern NSString *const
 ///   24.拉取是否好友
 extern NSString *const
 ///   25.拉取好友申请列表
 extern NSString *const
 ///   26.置顶好友
 extern NSString *const
 */

//************************钱xx相关************************//
///筛选钱xx
extern NSString *const getRegimenListForFilter;
///搜索钱xx
extern NSString *const getRegimenListForSearch;
///获取钱xx详情信息
extern NSString *const getRegimenDetailInfo;

///获取钱xx订单详情
extern NSString *const getRegimenOrderDetailInfo;

///根据年月日钱xxID、获取用户订单
extern NSString *const getPavilionorderList;

#pragma mark - 138.获取钱xx评价列表
extern NSString *const ScoreDetailsForClub;
#pragma mark - 获取用户对便的评论列表
extern NSString *const ScoreDetailsForCoach;
#pragma mark - 获取掌柜评价列表
extern NSString *const ScoreDetailsForPlace;

// 141.获取我的钱xx列表
extern NSString *const userGetOwnRegimenList;

// 152.获取钱xx详情（只能获取属于自己的钱xx用于钱xx修改)
extern NSString *const userGetOwnRegimenDetailInfo;
//  获取钱xx团队
extern NSString *const Regimen_Team;
//************************钱xx相关************************//

//************************掌柜相关************************//

#pragma mark - 搜索接口:
#pragma mark >根据名字搜索便列表
extern NSString *const SearchForCoach;
#pragma mark >根据名字搜索团购课程列表
extern NSString *const SearchForCourse;
#pragma mark >搜索掌柜
extern NSString *const SearchForPlace;



#pragma mark - 103.获取掌柜详情
extern NSString *const getPlaceModelInfo;

#pragma mark - 104.获取掌柜项目列表
extern NSString *const getPlaceItemList;

#pragma mark - 105.根据项目ID查询掌柜列表
extern NSString *const getPlaceListforitem;

#pragma mark - 获取掌柜订单详情
extern NSString *const getPlaceOrderDetailInfo;

#pragma mark -  根据年月日掌柜ID、获取用户订单
extern NSString *const getPlaceOrderList;

#pragma mark -  137.获取掌柜评价列表
extern NSString *const getVenueCommentList;

#pragma mark -   140.获取我的掌柜列表
extern NSString *const userGetOwnPlaceList;

#pragma mark -   151.获取掌柜详情（只能获取属于自己的掌柜用于掌柜修改)
extern NSString *const userGetOwnPlaceDetailInfo;

#pragma mark - 获取钱xx团队
extern NSString *const Place_Team;
//************************掌柜相关************************//


//************************团购相关************************//
#pragma mark -  92.获取用户订单列表(便团购课程订单)
extern NSString *const getCourseOrderList;

#pragma mark -  142.获取订单详情
extern NSString *const getCourseOrderDetailInfo;
//************************团购相关************************//

//************************用户信息相关************************//

#pragma mark -  二维码
extern NSString *const getQRCode;

#pragma mark -  生成二维码
extern NSString *const createQRCode;
//************************用户信息相关************************//

//************************ IM ************************//
#pragma mark - IM:
/// 申请添加好友
extern NSString *const IM_FRIENDAPPLY;
///  是否是好友
extern NSString *const IM_ISFRIEND;
/// 获取多个用户
extern NSString *const IM_GetUserInfo;
/// 获取好友列表
extern NSString *const IM_GetFrienList;
/// 搜索好友
extern NSString *const IM_SearchUser;
/// 获取好友申请列表
extern NSString *const IM_FriendsByApply;
/// 添加或删除好友
extern NSString *const IM_MakeFriend;
/// 申请添加好友
extern NSString *const IM_UPDATEREMARK;
///  同步用户信息至IM
extern NSString *const IM_SYNCUSERIM;
//************************ IM ************************//

//************************ 发现 ************************//
#pragma mark >146.获取活动列表+分页
extern NSString *const getActivityList;

//************************ 发现 ************************//
