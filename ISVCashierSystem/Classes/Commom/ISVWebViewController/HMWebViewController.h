//
//  HMWebViewController.h
//  HealthMall
//
//  Created by jkl on 15/10/30.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMWebViewController, WebViewJavascriptBridge;

// 浏览器模式(暂时不支持)
typedef enum : NSUInteger {
    HMWebViewControllerModeHide,// 一直隐藏
    HMWebViewControllerModeShow,// 一直显示
    HMWebViewControllerModeAuto,// 自动隐藏或显示
} HMWebViewControllerMode;


@protocol HMWebViewControllerDelegate <NSObject>

@optional
- (void)webViewControllerInitForWebView:(UIWebView *)webView bridge:(WebViewJavascriptBridge *)bridge;
- (void)webViewControllerDidStartLoadForWebView:(UIWebView *)webView bridge:(WebViewJavascriptBridge *)bridge;
- (void)webViewControllerDidFinishLoadForWebView:(UIWebView *)webView bridge:(WebViewJavascriptBridge *)bridge;

/**
 *  点击分享按钮
 */
- (void)didClickShareWithWebView:(UIWebView *)webView bridge:(WebViewJavascriptBridge *)bridge;

/**
 *  准备关闭浏览器
 */
- (void)willClosedWebViewController;

@end

// 自定义浏览器
@interface HMWebViewController : UIViewController

@property (nonatomic, copy) NSString *urlString;        //  字符串请求url
@property (nonatomic, copy) NSString *htmlString;       //  直接加载HTML
@property (nonatomic, copy) NSString *POSTBody;         //  请求体（有值则会使用POST请求）

@property (nonatomic, copy) NSString *fixedTitle;       //  固定标题
@property (nonatomic, assign) BOOL shouldDisplayOverflow;   // 是否要转菊花, 默认NO
@property (nonatomic, assign, getter=isShowShare) BOOL showShare;   //  是否显示分享按钮, 默认NO
@property (nonatomic, weak) id<HMWebViewControllerDelegate> delegate;
@property (nonatomic, strong, readonly) WebViewJavascriptBridge *bridge;


@property (nonatomic, assign) HMWebViewControllerMode mode;
// 是否动态显示/隐藏导航条 默认YES：隐藏
@property (nonatomic, assign, readonly) BOOL isDynamicNavBarHidden;
// 是否动态显示/隐藏底部条 默认YES：隐藏
@property (nonatomic, assign, readonly) BOOL isDynamicBottomBarHidden;
/**
 *  设置是否动态显示/隐藏导航条或底部条
 *
 *  @param navBarHidden    是否隐藏导航条
 *  @param bottomBarHidden 是否隐藏底部条
 *  @param animated        是否动画
 */
- (void)setDynamicNavBarHidden:(BOOL)navBarHidden bottomBarHidden:(BOOL)bottomBarHidden animated:(BOOL)animated;

@end
