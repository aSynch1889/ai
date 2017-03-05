//
//  HMNetworkingConst.c
//  HealthMall
//
//  Created by jkl on 15/10/31.
//  Copyright © 2015年 HealthMall. All rights reserved.
//  http://api.healthmall.me

#import "HMNetworkingConst.h"

#pragma mark - 域名配置
NSString *const SERVER_ADRESS = URL_MAIN;
//NSString *const SERVER_ADRESS = @"http://api.healthmall.me";
NSString *const SERVER_IMAGES_UPLOAD = URL_MAIN_tv;

#pragma mark - post请求接口
NSString *const POST_URL = @"/Post";

#pragma mark - 公共接口:
#pragma mark >项目类型(约动友)
NSString *const COMMON_PROJECTLIST_AskFriend = @"/healthmall/DatingFriend/GetList";
#pragma mark >项目类型(约私教)
NSString *const COMMON_PROJECTLIST_AskCoach = @"/user/Education";
#pragma mark >项目类型(场馆)
NSString *const COMMON_PROJECTLIST_Place =@"/Venue/GetItemList";
#pragma mark >项目类型(养生馆)
NSString *const COMMON_PROJECTLIST_Regimen =@"/HM_pavilion/GetProgramList";
#pragma mark >获取所有城市列表
NSString *const COMMON_CITY_LIST = @"/Venue/GetAllCityList";
#pragma mark >获取支付方式列表
NSString *const COMMON_PaymentList = @"/HM_GroupBuycourse/GetAllPayment";
#pragma mark >获取支付配置信息
NSString *const COMMON_PayConfig = @"/AppPay";
#pragma mark >获取最新版本信息
NSString *const COMMON_LatestVersion = @"/Home/CommonTag/GetLatestVersion";
#pragma mark >获取广告列表
NSString *const COMMON_AD_LIST = @"/Home/CommonTag/GetADList";
#pragma mark >获取公共key
NSString *const CommonKey = @"/user/OperateUser/GetCommonKey";


#pragma mark - 用户接口:
#pragma mark >用户操作
NSString *const USER_OPERATE = @"/user/OperateUser";
#pragma mark >用户登录
NSString *const USER_LOGIN = @"/Login";
#pragma mark >用户退出登录
NSString *const USER_LOGOUT = @"/Post";
#pragma mark >用户注册
NSString *const USER_REGISTER = @"/user/OperateUser";
#pragma mark >用户信息修改
NSString *const USER_MODIFY = @"/user/OperateUser";  // 先这样写, 后期统一处理重复的内容
#pragma mark - 微视频
NSString *const SPACE_AUTHEN = @"/user/OperateUser/Gettxspaccredit";

#pragma mark >获取学历
NSString *const USER_Education = @"/user/Education";
NSString *const USER_GET_NEW_TOKEN = @"/user/OperateUser/GetNewToken";

#pragma mark - 私教:
#pragma mark >私教注册
NSString *const COACH_APPLY = @"PTADDORUPDATE";
#pragma mark >私教信息修改
NSString *const COACH_MODIFY = @"PTADDORUPDATE";
#pragma mark >私教资质
NSString *const COACH_QUALIFICATION = @"/user/OperateUser/Qualification";
#pragma mark >根据邀请码获取私教名字
NSString *const COACH_NameByInviteCode = @"/trainer/OperatePersonalTrainer/PTNameByCode";
#pragma mark >获取私教信息
NSString *const COACH_INFO = @"/user/OperateUser/GetPTrainerModelEx";

#pragma mark >私教订单（私教端）
NSString *const COACH_ORDER = @"/trainer/trainerorder";
#pragma mark >私教操作订单（私教端）
NSString *const COACH_OPERATEORDER_PT = @"OPERATEORDER_PT";
#pragma mark >私教图片或视频管理
NSString *const COACH_PTWOODMANAGE = @"PTWOODMANAGE";
#pragma mark >获取私教图片或视频
NSString *const COACH_MOREWOODINFO = @"/user/OperateUser/MoreWoodInfo";
#pragma mark >私教上传封面图片
NSString *const COACH_PTWOODTOPIMG = @"PTWOODTOPIMG";
#pragma mark >健康小屋
NSString *const CABIN_INFO = @"/trainer/StartOrderMode/GetHomeModel?";
#pragma mark >私教开启接单模式
NSString *const START_ORDER_MODE = @"/trainer/StartOrderMode";
#pragma mark >获取私教团队
NSString *const COASH_TEAM = @"/trainer/OperatePersonalTrainer/GetPTTeamList";
#pragma mark >获取课程订单详情
NSString *const COACH_CourseOrderDetail = @"/HM_GroupBuycourse/Getorderdetail";

#pragma mark >请求验证码
NSString *const REQUEST_SMS_CODE = @"/user/OperateUser/sendvcode";
#pragma mark >13.验证验证码
NSString *const VERIFY_SMS_CODE= @"/Post";
#pragma mark >14.获取订单
NSString *const  GETORDER= @"/trainer/trainerorder";
#pragma mark >15.点击钱包事件
NSString *const INITWALLET = @"/Post";
#pragma mark >16.获取钱包实体
NSString *const WALLET = @"/wallet";
#pragma mark >17.设置钱包密码
NSString *const SETMYWALLETPASSWORD = @"/Post";
#pragma mark >28.获取优惠券
NSString *const USERGETCOUPON = @"/user/Coupon";
#pragma mark >30 获取用户银行卡列表
NSString *const USER_BANKCARDLIST = @"/wallet/GetBankCard";
#pragma mark >31 获取所有银行列表
NSString *const USER_ALLBANKLIST = @"/Wallet/GetAllBanList";
#pragma mark >163 获取收支明细
NSString *const USER_GETBALANCE = @"/Wallet/GetBalance";

#pragma mark >存储用户位置
NSString *const POSITION = @"/user/OperateUser/position?key=";

#pragma mark - 首页接口:
#pragma mark >首页标签
NSString *const HOME_TAG = @"/Home/CommonTag";
NSString *const COURSE_DETAIL_INFO = @"/HM_GroupBuycourse/GetCoursedetailmodel?";
NSString *const HOME_WEEKSTARS_COACH_PUT = @"/Home/CommonTag/GetTrainerList";

#pragma mark >获取私教团购课程列表+排序+筛选+分页
NSString *const HOME_COURSE_LIST = @"/HM_GroupBuycourse/GetCourseListofSJ";
#pragma mark >获取私教发布的课程列表
NSString *const HOME_COURSE_ALL = @"/HM_GroupBuycourse/GetCourseListforSJ";

#pragma mark >获取用户咨询列表
NSString *const HOME_CONSULT = @"/HM_GroupBuycourse/GetConsultList";
#pragma mark >获取团购点赞用户列表
NSString *const HOME_COURSE_PRAISE_LIST = @"/HM_GroupBuycourse/GetPraiseList";
#pragma mark >获取已付款成功的团购用户头像列表
NSString *const HOME_COURSE_SIGN_PERSON = @"/HM_GroupBuycourse/GetGroupbuyuser";

#pragma mark - 约动友-邀请详情
NSString *const ASK_FRIEND_Minute = @"/healthmall/DatingFriend/GetModel";

#pragma mark - 约动友-综合排序
NSString *const COMPOSITE_ORDERBY = @"/healthmall/DatingFriend/Filtrate";

#pragma mark - 约动友- 邀请详情评论
NSString *const COMMENT_LIST = @"/healthmall/DatingFriend/GetList";

#pragma mark - 约动友 - 我的邀约列表
NSString *const MY_INVIT = @"/healthmall/DatingFriend/GetList";

#pragma mark - 约动友 - 我的报名
NSString *const MY_SIGNUP = @"/healthmall/DatingFriend/GetList";

#pragma mark - 发布邀约
NSString *const RELEASE_INVIT = @"POSTADDACTIVITY";

#pragma mark - 撤销邀约
NSString *const CANCEL_INVIT = @"CANCELINVITE";

#pragma mark - 报名人员列表
NSString *const SIGNUP_LIST = @"/healthmall/DatingFriend/GetList";

#pragma mark - 获取活动报名人员列表(报名管理)
NSString *const ACTION_SIGNUP_LIST = @"/HEALTHMALL/DATINGFRIEND/GETLIST";

#pragma mark - 报名邀约
NSString *const SIGNUP_INVITE = @"/Post";

#pragma mark - 接受/不接受邀约
NSString *const ACCESS_INVITE = @"/Post";

#pragma mark - 获取请客类型列表treattype
NSString *const TREAT_TYPE = @"/healthmall/DatingFriend/GetTreatType";

#pragma mark - 获取邀约对象列表
NSString *const INVIT_OBJECT = @"/healthmall/DatingFriend/Inviteobject";

#pragma mark - 获取性别列表
NSString *const SEX_LIST = @"/user/OperateUser/SexList";

#pragma mark - 获取邀约评论
NSString *const INVIT_COMMENT = @"/Post";

#pragma mark - 获取项目列表
NSString *const PROJEST_LIST = @"/healthmall/DatingFriend/GetList";

#pragma mark -----------养生馆接口
//筛选养生馆
NSString *const CARE_OCCASION = @"/HM_pavilion/GetListforscreen";
//店铺详情
NSString *const STORE_DETAILS = @"/HM_pavilion/GetModel";

#pragma mark----------------约场馆接口
//约场馆筛选
NSString *const INVIT_LIST = @"/Venue/GetListforscreen";


//我的粉丝
NSString *const MY_FANS = @"/user/OperateUser/UserFans";


//获取粉丝关注的用户列表
NSString *const getUserConcerned = @"/user/OperateUser/UserConcerned";


//************************养生馆相关************************//
#pragma mark - 养生馆接口:
#pragma mark - 筛选养生馆
NSString *const getRegimenListForFilter = @"/HM_pavilion/GetListforscreen";

#pragma mark - 搜索养生馆
NSString *const getRegimenListForSearch = @"/HM_pavilion/GetListforsearch";

#pragma mark - 获取养生馆详情信息
NSString *const getRegimenDetailInfo = @"/HM_pavilion/GetModel";

#pragma mark - 获取养生馆订单详情
NSString *const getRegimenOrderDetailInfo = @"/HM_pavilion/GetPavilionOrderdetail";

#pragma mark - 根据年月日养生馆ID、获取用户订单
NSString *const getPavilionorderList = @"/HM_pavilion/GetPavilionorderList";

#pragma mark - 138.获取养生馆评价列表
NSString *const ScoreDetailsForClub = @"/HM_pavilion/GetPavilionCommentList";
#pragma mark - 获取用户对私教的评论列表
NSString *const ScoreDetailsForCoach = @"/trainer/OperatePersonalTrainer/GetListforpt";
#pragma mark - 获取场馆评价列表
NSString *const ScoreDetailsForPlace = @"/Venue/GetVenueCommentList";


#pragma mark - 141.获取我的养生馆列表
NSString *const userGetOwnRegimenList = @"/HM_pavilion/GetpavilionList";

#pragma mark - 获取养生馆详情（只能获取属于自己的养生馆用于养生馆修改)
NSString *const userGetOwnRegimenDetailInfo = @"/HM_pavilion/GetModelex";

#pragma mark - 获取养生馆团队
NSString *const Regimen_Team = @"/HM_pavilion/GetPavilionTeam";
//************************养生馆相关************************//

//************************场馆相关************************//

#pragma mark - 搜索接口:
#pragma mark >根据名字搜索私教列表
NSString *const SearchForCoach = @"/trainer/StartOrderMode/GetPTrainerSearch";
#pragma mark >根据名字搜索团购课程列表
NSString *const SearchForCourse = @"/HM_GroupBuycourse/GetGroupbuySearch";
#pragma mark >搜索场馆
NSString *const SearchForPlace = @"/Venue/GetListforsearch";

#pragma mark - 场馆接口:
#pragma mark - 103.获取场馆详情
NSString *const getPlaceModelInfo = @"/Venue/GetModelInfo";

#pragma mark - 104.获取场馆项目列表
NSString *const getPlaceItemList = @"/Venue/GetItemList";


#pragma mark - 105.根据项目ID查询场馆列表
NSString *const getPlaceListforitem = @"/Venue/GetListforitem";

#pragma mark - 获取场馆订单详情
NSString *const getPlaceOrderDetailInfo = @"/Venue/GetVenueOrderdetail";

#pragma mark -  根据年月日场馆ID、获取用户订单
NSString *const getPlaceOrderList = @"/Venue/GetVenueorderList";

#pragma mark -  137.获取场馆评价列表
NSString *const getVenueCommentList = @"/Venue/GetVenueCommentList";

#pragma mark -   140.获取我的场馆列表
NSString *const userGetOwnPlaceList = @"/Venue/GetVenueList";

#pragma mark -   151.获取场馆详情（只能获取属于自己的场馆用于场馆修改)
NSString *const userGetOwnPlaceDetailInfo = @"/Venue/GetModelInfoex";

#pragma mark - 获取养生馆团队
NSString *const Place_Team = @"/Venue/GetVenueTeam";
//************************场馆相关************************//

//************************团购相关************************//

#pragma mark -  92.获取用户订单列表(私教团购课程订单)
NSString *const getCourseOrderList = @"/HM_GroupBuycourse/Getorderlist";

#pragma mark -  142.获取订单详情
NSString *const getCourseOrderDetailInfo = @"/HM_GroupBuycourse/Getorderdetail";


//************************团购相关************************//
//************************用户信息相关************************//

#pragma mark -  92.获取用户订单列表(私教团购课程订单)
NSString *const getQRCode = @"/user/OperateUser/TwoDimensionCode";


#pragma mark -  生成二维码
NSString *const createQRCode = @"?code=";

//************************用户信息相关************************//

//************************ IM ************************//
#pragma mark - IM:
#pragma mark > 申请添加好友
NSString *const IM_FRIENDAPPLY = @"FRIENDAPPLY";
#pragma mark > 是否是好友
NSString *const IM_ISFRIEND = @"ISFRIEND";
#pragma mark >获取多个用户
//NSString *const IM_GetUserInfo = @"/user/OperateUser/GetUserInfo";
NSString *const IM_GetUserInfo = @"GETMOREUSER";
#pragma mark >获取好友列表
NSString *const IM_GetFrienList = @"/user/OperateUser/GetFrienList";
#pragma mark >搜索好友
NSString *const IM_SearchUser = @"/user/OperateUser/SearchUser";
#pragma mark >获取好友申请列表
NSString *const IM_FriendsByApply = @"/user/Friend";
#pragma mark >添加或删除好友
NSString *const IM_MakeFriend = @"ADDFRIEND";
#pragma mark > 申请添加好友
NSString *const IM_UPDATEREMARK = @"UPDATEREMARK";
#pragma mark > 同步用户信息至IM
NSString *const IM_SYNCUSERIM = @"SYNCUSERIM";
//************************ IM ************************//

//************************ 发现 ************************//
#pragma mark >146.获取活动列表+分页
NSString *const getActivityList = @"/hm_activity_list";
//************************ 发现 ************************//

