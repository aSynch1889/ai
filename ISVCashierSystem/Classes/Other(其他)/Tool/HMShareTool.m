//
//  HMShareTool.m
//  HealthMall
//
//  Created by healthmall005 on 15/12/28.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMShareTool.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "HMHUD.h"
#import "HMAlertView+HMCustom.h"
#import "HMNetworking.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDKUI/SSUIEditorViewStyle.h>
#import "WXApi.h"

@implementation HMShareTool
{
    NSString *_shareUrl;
    shareCompleteBlcok _completeBlcok;
}

HMSingletonM(Share)


- (id)init{
    self = [super init];
    if (self) {
//        [self requestGetShareHost];
    }
    return self;
}
//- (void)requestGetShareHost
//{
//    
//    //TODO:  判断分享链接是否能成功打开
//    [HMNetworking getWithURL:@"/Handlers/CommonHandler.ashx?act=wechaturlapi" success:^(id respondData) {
//        if (HasValuse) {
//            _shareUrl = [NSString stringWithFormat:@"http://%@",Response_Valuse];
//            _isHasUrl = YES;
//        }
//    } failure:^(HMErrorModel *error) {
//        NSLog(@"error  ----错误信息 %@ ----",error);
//        [HMHUD showErrorWithStatus:error.errMsg];
//        
//#warning aihua 暂时添加为YES  后期配置了分享链接后取消
//        _shareUrl = @"";
//        _isHasUrl = YES;
//        
//    }];
//
//}

- (void)setShareCompleteBlcok:(shareCompleteBlcok)completeBlcok;
{
    _completeBlcok = [completeBlcok copy];
}

#pragma mark - 第三方分享平台配置
- (void)initShareSDK
{
    [ShareSDK registerApp:kShareAppKey activePlatforms:@[@(SSDKPlatformTypeQQ),
                                                         @(SSDKPlatformTypeWechat),
                                                         @(SSDKPlatformTypeSinaWeibo),
                                                         @(SSDKPlatformTypeMail),
                                                         @(SSDKPlatformTypeSMS),] onImport:^(SSDKPlatformType platformType) {
                                                             switch (platformType)
                                                             {
                                                                 case SSDKPlatformTypeWechat:
                                                                     [ShareSDKConnector connectWeChat:[WXApi class]];
                                                                     break;
                                                                 case SSDKPlatformTypeQQ:
                                                                     [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                                     break;
                                                                 default:
                                                                     break;
                                                             }

                                                         } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                                             switch (platformType)
                                                             {
                                                                 case SSDKPlatformTypeSinaWeibo:
                                                                     //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                                                     [appInfo SSDKSetupSinaWeiboByAppKey:kSinaAppKey
                                                                                               appSecret:kSinaAppSecret
                                                                                             redirectUri:kSinaRedirectUri authType:SSDKAuthTypeBoth];
                                                                     break;
                                                                 case SSDKPlatformTypeWechat:
                                                                     [appInfo SSDKSetupWeChatByAppId:kWeiXinAppId
                                                                                           appSecret:kWeiXinAppSecret];
                                                                     break;
                                                                 case SSDKPlatformTypeQQ:
                                                                     [appInfo SSDKSetupQQByAppId:kQQAppKey
                                                                                          appKey:kQQAppSecret
                                                                                        authType:SSDKAuthTypeBoth];
                                                                     break;
                                                                 default:
                                                                     break;
                                                             }

                                                         }];
}


- (void)shareInfoWithSharetitle:(NSString *)aShareTitle
                   andStareText:(NSString *)aShareText
                    andShareUrl:(NSString *)shareUrlStr
                shareImageArray:(NSArray  *)aShareImageArray
                      shareView:(UIView   *)aShareView
                shareTextAndUrl:(NSString *)aShareTextAndUrl

{
    //1、创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];

    if (aShareImageArray.count) {

        id obj = [aShareImageArray objectAtIndex:0];
        
        if ([obj isKindOfClass:[NSString class]]) {
            NSURL *imageURL = [NSURL URLWithString:obj];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *imgData = [NSData dataWithContentsOfURL:imageURL];
                if (imgData == nil) {// 分享文本
                    [shareParams SSDKSetupShareParamsByText:aShareTextAndUrl
                                                     images:aShareImageArray
                                                        url:[self urlFromType:SSDKPlatformTypeSinaWeibo urlstr:shareUrlStr]
                                                      title:aShareTitle
                                                       type:SSDKContentTypeText];
                    
                }else
                {// 分享图片
                    [shareParams SSDKSetupShareParamsByText:aShareTextAndUrl
                                                     images:aShareImageArray
                                                        url:[self urlFromType:SSDKPlatformTypeSinaWeibo urlstr:shareUrlStr]
                                                      title:aShareTitle
                                                       type:SSDKContentTypeImage];
                }
            });
        }else{// 分享任何东西（自动识别）
            [shareParams SSDKSetupShareParamsByText:aShareTextAndUrl
                                             images:aShareImageArray
                                                url:[self urlFromType:SSDKPlatformTypeSinaWeibo urlstr:shareUrlStr]
                                              title:aShareTitle
                                               type:SSDKContentTypeAuto];
        }


        //QQ空间
        [shareParams SSDKSetupQQParamsByText:aShareText
                                       title:aShareTitle
                                         url:[self urlFromType:SSDKPlatformSubTypeQZone urlstr:shareUrlStr]
                                  thumbImage:nil
                                       image:aShareImageArray
                                        type:SSDKContentTypeWebPage
                          forPlatformSubType:SSDKPlatformSubTypeQZone];
        
        NSString *appdownloadurl = [NSString stringWithFormat:@"%@ %@", aShareText, URL_Download_APP_ForiOS_Tencent];
        //短信
        [shareParams SSDKSetupSMSParamsByText:appdownloadurl title:appdownloadurl images:nil attachments:nil recipients:nil type:SSDKContentTypeText];
        
        //邮箱
        [shareParams SSDKSetupMailParamsByText:appdownloadurl title:appdownloadurl images:nil attachments:nil recipients:nil ccRecipients:nil bccRecipients:nil type:SSDKContentTypeText];
        
        //微信好友
        [shareParams SSDKSetupWeChatParamsByText:aShareText
                                           title:aShareTitle
                                             url:[self urlFromType:SSDKPlatformSubTypeWechatSession urlstr:shareUrlStr]
                                      thumbImage:aShareImageArray
                                           image:aShareImageArray
                                    musicFileURL:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil
                                            type:SSDKContentTypeWebPage
                              forPlatformSubType:SSDKPlatformSubTypeWechatSession];
        //微信朋友圈
        [shareParams SSDKSetupWeChatParamsByText:aShareText
                                           title:aShareText
                                             url:[self urlFromType:SSDKPlatformSubTypeWechatTimeline urlstr:shareUrlStr]
                                      thumbImage:aShareImageArray
                                           image:aShareImageArray
                                    musicFileURL:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil
                                            type:SSDKContentTypeWebPage
                              forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
        //微信收藏
        [shareParams SSDKSetupWeChatParamsByText:aShareText
                                           title:aShareTitle
                                             url:[self urlFromType:SSDKPlatformSubTypeWechatFav urlstr:shareUrlStr]
                                      thumbImage:aShareImageArray
                                           image:aShareImageArray
                                    musicFileURL:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil
                                            type:SSDKContentTypeWebPage
                              forPlatformSubType:SSDKPlatformSubTypeWechatFav];
        /**
         *  设置QQ分享参数
         */
        [shareParams SSDKSetupQQParamsByText:aShareText
                                       title:aShareTitle
                                         url:[self urlFromType:SSDKPlatformSubTypeQQFriend urlstr:shareUrlStr]
                                  thumbImage:aShareImageArray
                                       image:aShareImageArray
                                        type:SSDKContentTypeWebPage
                          forPlatformSubType:SSDKPlatformSubTypeQQFriend];

        /**
         *  设置新浪微博分享参数
         */
        [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@ %@",aShareText,[self urlFromType:SSDKPlatformTypeSinaWeibo urlstr:shareUrlStr]]
                                                   title:aShareTitle
                                                   image:aShareImageArray
                                                     url:[self urlFromType:SSDKPlatformTypeSinaWeibo urlstr:shareUrlStr]
                                                latitude:0
                                               longitude:0
                                                objectID:nil
                                                    type:SSDKContentTypeAuto];
        
        /**
         *  设置邮件分享参数
         */
        [shareParams SSDKSetupMailParamsByText:aShareTextAndUrl
                                         title:aShareTitle
                                        images:aShareImageArray
                                   attachments:nil
                                    recipients:nil
                                  ccRecipients:nil
                                 bccRecipients:nil
                                          type:SSDKContentTypeText];

        //2、分享
        [ShareSDK showShareActionSheet:aShareView
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {

                       switch (state)
                       {
                           case SSDKResponseStateBegin:
                           {
                               [HMHUD show];
                               
                               break;
                           }
                           case SSDKResponseStateSuccess:
                           {
                               
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [HMHUD showInfoWithStatus:@"分享成功"];
                               });
                               
                               ! _completeBlcok ? : _completeBlcok(YES, contentEntity.rawData);
                               _completeBlcok = nil;
                               
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                                   [alert show];
                                   
                                   ! _completeBlcok ? : _completeBlcok(NO, contentEntity.rawData);
                                   _completeBlcok = nil;
                                   
                                   break;
                               }
                               else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:@"失败原因可能是:\n1.邮件未设置账号\n2.设备不支持邮件"
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                                   [alert show];
                                   
                                   ! _completeBlcok ? : _completeBlcok(NO, contentEntity.rawData);
                                   _completeBlcok = nil;
                                   
                                   break;
                               }
                               else
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:[NSString stringWithFormat:@"%@",error]
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                                   [alert show];
                                   
                                   ! _completeBlcok ? : _completeBlcok(NO, contentEntity.rawData);
                                   _completeBlcok = nil;
                                   
                                   break;
                               }
                               break;
                           }
                           case SSDKResponseStateCancel:
                           {
                               _completeBlcok = nil;
                               break;
                           }
                           default:
                               break;
                       }

                       if (state != SSDKResponseStateBegin && state != SSDKResponseStateSuccess)
                       {
                           [HMHUD dismiss];
                       }

                   }];
    }

}

#pragma mark - Private
- (NSURL *)urlFromType:(SSDKPlatformType)Type urlstr:(NSString *)urlstr
{
    NSString *typeStr = nil;
    switch (Type) {
        case SSDKPlatformSubTypeWechatTimeline:
            typeStr = @"wechatMoments";
            break;
        case SSDKPlatformSubTypeWechatSession :
            typeStr = @"weChat";
            break;
        case SSDKPlatformSubTypeWechatFav :
            typeStr = @"WechatFav";
            break;
        case SSDKPlatformSubTypeQQFriend :
            typeStr = @"QQ";
            break;
        case SSDKPlatformSubTypeQZone :
            typeStr = @"Qzone";
            break;
        case SSDKPlatformTypeSinaWeibo :
            typeStr = @"sina";
            break;
        case SSDKPlatformTypeMail :
            typeStr = @"eMail";
            break;
        case SSDKPlatformTypeSMS :
            typeStr = @"SMS";
            break;
        default:
            typeStr = @"wechatMoments";
            break;
    }

    return [NSURL URLWithString:[NSString stringWithFormat:@"%@&market=%@", urlstr, typeStr]];
}
@end
