//
//  HMRuleTool.m
//  HealthMall
//
//  Created by qiuwei on 16/1/21.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "HMRuleTool.h"
//#import "HMApplyFriendViewController.h"
#import "HMUserDetailViewController.h"
#import "HMUserCenter.h"
#import "HMHUD.h"
#import "HMNetworking+IM.h"
#import "HMIMFriend.h"
#import "HMOpenIMManager.h"
#import "HMWebViewController.h"

@implementation HMRuleTool

/**
 *  添加好友
 */
+ (void)ruleForAddFriendWithViewController:(UIViewController *)viewController userID:(NSString *)userID
{
    NSLog(@"添加好友userID:%@", userID);
    
    if (userID == nil || [userID isKindOfClass:[NSNull class]]) {
        [HMHUD showErrorWithStatus:@"用户信息不全"];
        return;
    }
    
    if([HMDefaultUserCenter.userModel.UserID isEqualToString:userID]){
        [HMHUD showErrorWithStatus:@"不能添加自己哦"];
        return;
    }
    
    __weak typeof(viewController) weakVC = viewController;
    [HMUserDetailViewController showUserDetailWithUserID:userID fromNavigationController:weakVC.navigationController];
    
//    [HMHUD show];
//    [HMNetworking imUsersWithUserIDs:@[userID] type:@"ID" success:^(id respondData) {
//        
//        NSArray *arr = Response_Valuse;
//        if (HasValuse && [arr isKindOfClass:[NSArray class]]) {
//            
//            NSDictionary *dict = [arr firstObject];
//            if ([dict isKindOfClass:[NSDictionary class]]) {
//                HMIMFriend *friend = [[HMIMFriend alloc] init];
//                friend.UserID = [dict objectForKeyWithoutNull:@"User_Id"];
//                friend.UserNickName = [dict objectForKeyWithoutNull:@"HM_U_NickName"];
//                friend.HeadPortrait = [dict objectForKeyWithoutNull:@"headImageUser"];
//#warning 备注没字段
//                friend.Remark = [dict objectForKeyWithoutNull:@"hm_u_remark"];
//                friend.friendType = [[dict objectForKeyWithoutNull:@"isfriend"] integerValue];
//                
//                if (friend.friendType == HMMyContactTypeIsAdd) {
//                    [HMHUD showErrorWithStatus:@"Ta已经是您的好友哦"];
//                    return;
//                }
//                
//                HMApplyFriendViewController *applyFriendVC = [[HMApplyFriendViewController alloc] init];
//                applyFriendVC.imFriend = friend;
//                
//                [applyFriendVC setCompleteBlock:^() {
//                    
//                    [weakVC.navigationController popViewControllerAnimated:YES];
//                    
//                }];
//                [weakVC.navigationController pushViewController:applyFriendVC animated:YES];
//            }
//            
//            [HMHUD dismiss];
//            
//        }else{
//            [HMHUD showErrorWithStatus:@"没有找到该用户信息"];
//        }
//        
//        
//    } failure:^(HMErrorModel *error) {
//        [HMHUD showErrorWithStatus:error.errMsg];
//    }];
    
}

/**
 *  加入群
 */
+ (void)ruleForJoinTribeWithViewController:(UIViewController *)viewController userID:(NSString *)userID
{
    NSLog(@"加入群userID:%@", userID);
    [HMHUD show];
    __weak typeof(viewController) weakVC = viewController;
    [[[HMOpenIMManager sharedInstance].ywIMKit.IMCore getTribeService] joinTribe:userID completion:^(NSString *tribeId, NSError *error) {
        if( error == nil ) {
            
            [HMHUD showSuccessWithStatus:@"加入群成功"];
            [weakVC dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            NSLog(@"%@",error);
            if(error.code == 6){
                [HMHUD showSuccessWithStatus:@"已加入该群"];
            }else{
                
                NSString *errorMsg = error.userInfo[NSLocalizedFailureReasonErrorKey];
                if(errorMsg == nil || [errorMsg isKindOfClass:[NSNull class]]){errorMsg = @"加群出错";}
                [HMHUD showErrorWithStatus:errorMsg];
            }
        }
    }];
}

/**
 *  跳转浏览器
 */
+ (void)ruleForWebWithViewController:(UIViewController *)viewController urlString:(NSString *)urlString
{
    NSLog(@"跳转浏览器urlString:%@", urlString);
    
    if (urlString.length == 0) {
        [HMHUD showErrorWithStatus:@"访问路径不能为空"];
        return;
    }
    
    if ([urlString hasPrefix:@"http://"] || [urlString hasPrefix:@"https://"]) {
        HMWebViewController *webVC = [[HMWebViewController alloc] init];
        webVC.urlString = urlString;
        [viewController.navigationController pushViewController:webVC animated:YES];
    }else{
        [HMHUD showErrorWithStatus:@"访问地址错误"];
    }
}

/**
 *  其他规则处理
 */
+ (void)ruleForOtherWithViewController:(UIViewController *)viewController urlString:(NSString *)urlString
{
    if ([urlString isKindOfClass:[NSString class]]) {
        if (urlString.length == 0) {
            [HMHUD showErrorWithStatus:@"访问路径不能为空"];
            return;
        }
        
        NSUInteger l1 = [urlString rangeOfString:@"hmtribe_"].location;
        NSUInteger l2 = [urlString rangeOfString:@"hm_"].location;
        
        if (l1 != NSNotFound || l2 != NSNotFound ) {
            
            UIAlertView *alertview =[[UIAlertView alloc] initWithTitle:nil message:@"此二维码已过期，请使用最新版本生成二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertview show];
            
        }else{
            [HMHUD showErrorWithStatus:@"无法识别该二维码"];
        }
    }
}
@end
