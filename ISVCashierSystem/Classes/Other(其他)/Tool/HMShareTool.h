//
//  HMShareTool.h
//  HealthMall
//
//  Created by healthmall005 on 15/12/28.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^shareCompleteBlcok)(BOOL succeed, NSDictionary *ret);

@interface HMShareTool : NSObject

@property(nonatomic, assign) BOOL isHasUrl;

HMSingletonH(Share)

/**
 *  初始化分享控件
 */
- (void)initShareSDK;

/**
 *  启动分享，并传入分享参数
 *  @param title    标题
 *  @param text     文本
 *  @param url      网页路径/应用路径
 *  @param shareImageArray   数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。如: @"http://www.mob.com/images/logo_black.png" 或 @[@"http://www.mob.com/images/logo_black.png"]
 *  @param aShareView     所在的视图（最好使用window）
 *  @param aShareTextAndUrl     文本路径
 */
- (void)shareInfoWithSharetitle:(NSString *)aShareTitle
                   andStareText:(NSString *)aShareText
                    andShareUrl:(NSString *)shareUrlStr
                shareImageArray:(NSArray  *)aShareImageArray
                      shareView:(UIView   *)aShareView
                shareTextAndUrl:(NSString *)aShareTextAndUrl;

- (void)setShareCompleteBlcok:(shareCompleteBlcok)completeBlcok;
@end
