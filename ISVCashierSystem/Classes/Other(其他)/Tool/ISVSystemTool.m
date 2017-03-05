//
//  ISVSystemTool.m
//  ISV
//
//  Created by aaaa on 15/10/29.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVSystemTool.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ISVHUD.h"
#import "ISVNetworking+Common.h"
#import "ISVPleaseUpdateViewController.h"
#import "ISVUserInterfaceTool.h"

#define kCheckUpAPPTag 999
#define kcaptureTag 998
static NSString *downloadURL_ = @""; // 下载URL
//static BOOL isConstraint_ = NO;


@implementation ISVSystemTool

// 是否是版本更新后首次打开
+ (BOOL)isVersionUpdated
{
    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
    return NO;
}

/**
 *  检查更新APP
 */
+ (void)checkUpAPP
{
    [ISVNetworking getLatestVersionWithSuccess:^(id respondData) {
        
//        NSDictionary *releaseInfo = @{
//            @"ISV_id": @1,
//            @"ISV_systemtype": @0,
//            @"ISV_versionnumber": @1,
//            @"ISV_forcedupdate": @(YES),
//            @"ISV_qrcode": @"qrcode",
//            @"ISV_versionname": @"versionname",
//            @"ISV_checkstatus": @1,
//            @"ISV_md5": @"md5",
//            @"ISV_versionremark": @"1.更新说明\t\t\t\t\t\t\t\t\t\t   \n2.更新说明\t\t\t\t\t\t\t\t\n3.更新说明\n4.更新说明更新说明",
//            @"ISV_addtime": @"2016-01-09T16:58:20",
//            @"ISV_addmanagerid": @1,
//            @"ISV_addmanagername": @"addmanagername",
//            @"ISV_aduitremark": @"通过",
//            @"ISV_aduittime": @"2016-01-09T16:58:45",
//            @"ISV_aduitmanagerid": @1,
//            @"ISV_aduitmanagername": @"auditmanagername",
//            @"ISV_url":@"http://z.cn"
//        };
//        
        NSDictionary *releaseInfo = Response_Valuse;
        if (HasValuse && [releaseInfo isKindOfClass:[NSDictionary class]]) {
            
            NSUInteger appStoreVersion = [[releaseInfo objectForKey:@"ISV_versionnumber"] integerValue];
            NSUInteger currentVersion = [APP_VERSION integerValue];
            
            if (appStoreVersion != currentVersion)
            {
                downloadURL_ = [releaseInfo objectForKey:@"ISV_url"];
                
                BOOL isConstraint = [[releaseInfo objectForKey:@"ISV_forcedupdate"] boolValue];
                
                if (isConstraint) {
                    
                    [[ISVUserInterfaceTool topViewController] dismissViewControllerAnimated:NO completion:nil];
                    ISVPleaseUpdateViewController *v = [[ISVPleaseUpdateViewController alloc] init];
                    v.updateUrl = downloadURL_;
                    v.view.frame = kSCREEN_BOUNDS;
                    UIWindow *window = [ISVUserInterfaceTool tabBarController].view.window;
                    window.rootViewController = v;
                    [window makeKeyAndVisible];
                    
                }else{
                    
                    NSString *cancelTitle = @"稍后更新";
                    NSString *msg = [releaseInfo objectForKey:@"ISV_versionremark"];
                    
                    UIAlertView *alertview =[[UIAlertView alloc] initWithTitle:@"有新版本啦！" message:[NSString stringWithFormat:@"%@%@%@", @"",msg, @""] delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"立即更新", nil];
                    alertview.tag = kCheckUpAPPTag;
                    [alertview show];
                }
                
            }
            
        }
        
    } failure:^(ISVErrorModel *error) {
    }];
}


/**
 *  检查相机的认证状态
 */
+ (void)captureDeviceAuthStatusWithSuccessCallback:(void(^)())successCallback failedCallback:(void(^)())failedCallback
{
    // 系统大于等于iOS7.0
    if (!SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        
        NSString *mediaType = AVMediaTypeVideo;
        
        AVAuthorizationStatus authStatus =[AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){ // 受限的 或 不允许； （用户关闭了权限）
            
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"请检查是否允许访问相机" message:@"请到“设置->隐私->相机”中开启【便掌柜】相机访问，以便于便掌柜为你提供更好的使用体验。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alertview show];
            alertview.tag = kcaptureTag;
            
            ! failedCallback ? : failedCallback();

        }else if(authStatus == AVAuthorizationStatusAuthorized){ // 已授权
            ! successCallback ? : successCallback();

        }else if(authStatus == AVAuthorizationStatusNotDetermined){ // 暂未确定授权；（第一次使用，则会弹出是否打开权限）
            
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                
                if(granted){ // 授权成功
                    ! successCallback ? : successCallback();
                    
                }else { // 授权失败
                    
                    [ISVHUD showErrorWithStatus:@"授权失败"];
                    ! failedCallback ? : failedCallback();
                }
            }];
        }
        
    }else {
        ! successCallback ? : successCallback();
    }
}

/**
 *  检查相册权限
 */
+ (void)libraryAuthStatusWithSuccessCallback:(void(^)())successCallback failedCallback:(void(^)())failedCallback
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
        //无权限
        NSString *tips = @"请到“设置-隐私-照片”选项中开启【便掌柜】照片访问，以便于便掌柜为你提供更好的使用体验";

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请检查是否允许访问照片" message:tips delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alertView show];
        alertView.tag = kcaptureTag;
        
        ! failedCallback ? : failedCallback();

    }else {
        ! successCallback ? : successCallback();
    }
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 检查更新APP
    if (alertView.tag == kCheckUpAPPTag) {
        
        if (buttonIndex==1)
        {
            UIApplication *application = [UIApplication sharedApplication];
            [application openURL:[NSURL URLWithString:downloadURL_]];
        }
    }
    
    // 检查相机的认证状态
    else if(alertView.tag == kcaptureTag){
        // 系统大于等于iOS8.0
        if (!SYSTEM_VERSION_LESS_THAN(@"8.0")) {
            
            if (buttonIndex == 0){
                
            }else if (buttonIndex == 1){
                
                // ios8 及以上点击跳转到设置
                if (UIApplicationOpenSettingsURLString != NULL) {
                    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    [[UIApplication sharedApplication] openURL:appSettings];
                }
            }
        }
    }
    
}
@end
