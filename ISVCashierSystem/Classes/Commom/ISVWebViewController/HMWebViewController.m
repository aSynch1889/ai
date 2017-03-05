//
//  HMWebViewController.m
//  HealthMall
//
//  Created by jkl on 15/10/30.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

#import "UIBarButtonItem+HMExtension.h"
#import "WebViewJavascriptBridge.h"

#import "HMNetworking.h"
#import "HMUserCenter.h"
#import "HMHUD.h"

#import "HMShareTool.h"

#define kWebBottomBarHeight 44.0    // 底部条高度
#define kScrollDistance 10.0    // 滚动跨度参考值

@interface HMWebViewController () <UIWebViewDelegate, UIScrollViewDelegate, NJKWebViewProgressDelegate, UIAlertViewDelegate>
{
    CGFloat _lastPosition;  // 最后的位置
}
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) UILabel *tipLabel;  // 用于提示`网页由xxx提供`
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;

@end

@implementation HMWebViewController

- (void)dealloc
{
    [HMHUD dismiss];
    
    // 清理缓存
    [self.webView loadHTMLString:@"" baseURL:nil];
    [self.webView stopLoading];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    [self.webView removeFromSuperview];
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.webView.delegate = nil;
    self.webView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.webView stopLoading];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    // 固定标题
    if (_fixedTitle) {
        self.title = _fixedTitle;
    }
    
    // 添加进度条
    [self progressProxy];
    
    // 去除scrollView上方的空白
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.webView.scrollView.delegate = self;
    self.webView.scrollView.bounces = NO;
    
    // 开始请求网页
    [self loadRequest];

    
    // 启动WebViewJavascriptBridge
    [WebViewJavascriptBridge enableLogging];
    
    __weak typeof(self) weakSelf = self;
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSLog(@"ObjC received message from JS: %@", data);
        
        if ([data isEqualToString:kH5Weige]) {
            
            NSString *token = [HMNetworking token];
            responseCallback(token);
        }
        
        // 连接
        if ([data isEqualToString:kNotify_Ring_Login]) {// 动力圈
            [HMHUD showPageWithPageType:HMHUDPageTypeLoading InView:weakSelf.view];
            [weakSelf webConnectLoginWithAddress:URL_DLQHOSTNAME];
            responseCallback(data);
        }else if([data isEqualToString:kNotify_Health_Login]){// 商城
            [HMHUD showPageWithPageType:HMHUDPageTypeLoading InView:weakSelf.view];
            [weakSelf webConnectLoginWithAddress:URL_SHOPHOSTNAME];
            responseCallback(data);
        }
        
    }];

    // 绑定句柄,调用oc本地代码(用于触发登陆)
    [_bridge registerHandler:kH5NeedLogin handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [HMDefaultUserCenter showLoginWithSuccessCallback:^{
            
            responseCallback(@(YES));
            
        } failedCallback:^(HMErrorModel * _Nonnull error) {
            
        }];
    }];

    // 初始化BridgeDelegate
    if ([self.delegate respondsToSelector:@selector(webViewControllerInitForWebView:bridge:)]) {
        [self.delegate webViewControllerInitForWebView:self.webView bridge:_bridge];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    
    // 默认隐藏导航条和底部条(这行代码不能删除 Kman)
    [self setMode:_mode];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [HMHUD dismiss];
    
    // 状态栏菊花停止转圈
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.webView stopLoading];
    [_progressView removeFromSuperview];
}

#pragma mark - 导航栏前进、后退、分享工具条
- (void)setupNavigationBar
{
    // 1.返回按钮
    UIBarButtonItem *backItem = [UIBarButtonItem backBarButtonItemWithTitle:nil target:self action:@selector(backItemPressed)];
    
    // 1.关闭按钮
    UIBarButtonItem *closeItem = [UIBarButtonItem itemWithImageName:nil highImageName:nil title:@"关闭" target:self action:@selector(closeItemPressed)];
    UIView *view = closeItem.customView;
    view.hidden = YES;
    
    self.navigationItem.leftBarButtonItems = @[backItem, closeItem];
    
    // 4.分享按钮
    UIBarButtonItem *shareItem = [UIBarButtonItem itemWithImageName:nil highImageName:nil title:@"分享" target:self action:@selector(shareItemPressed)];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [shareItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItems = @[shareItem];
    
    [self setShowShare:_showShare];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    if (_shouldDisplayOverflow) {
        // 弹出菊花
        [HMHUD setBackgroundColor:[UIColor clearColor]];
        [HMHUD show];
    }

    // 状态栏菊花开始转圈
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // 开始网页加载，通知BridgeDelegate
    if ([self.delegate respondsToSelector:@selector(webViewControllerDidStartLoadForWebView:bridge:)]) {
        [self.delegate webViewControllerDidStartLoadForWebView:self.webView bridge:_bridge];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"当前加载的网页url:%@\n%@",webView.request.URL,[webView.request.URL query]);
    NSString *query = [webView.request.URL query];
    
    // t3情况下，分享到当前页面
    if(query != nil && [query rangeOfString:kShareTypeT3].location != NSNotFound){
        self.showShare = YES;
    }else{
        if (self.showShare) {
            self.showShare = YES;
        }else{
            self.showShare = NO;
        }
    }
    
    
    if (_shouldDisplayOverflow) {
        [HMHUD dismiss];
        [HMHUD reset];
    }
    
    // 网页加载完毕 设置导航栏标题
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = _fixedTitle ? _fixedTitle : title;

    // 状态栏菊花停止转圈
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    // 完成网页加载，通知BridgeDelegate
    if ([self.delegate respondsToSelector:@selector(webViewControllerDidFinishLoadForWebView:bridge:)]) {
        [self.delegate webViewControllerDidFinishLoadForWebView:self.webView bridge:_bridge];
    }
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    //  解决js导致内存泄漏问题
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    
    // 显示关闭按钮
    [self checkCloseItem];
}

// 错误处理
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error.code == NSURLErrorCancelled) return;
    
    // 状态栏菊花停止转圈
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [HMHUD showErrorWithStatus:@"无法打开该网页"];
    NSLog(@"webView error = %@", error);
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    // 修改提示标签
    NSURL *url = request.URL;
    NSString *absurl = [url.host stringByReplacingOccurrencesOfString:@"www." withString:@""];
    
    if (absurl.length == 0)
    {
        NSURL *url = [NSURL URLWithString:self.urlString];
        absurl = [url.host stringByReplacingOccurrencesOfString:@"www." withString:@""];
    }
    self.tipLabel.text = [NSString stringWithFormat:@"网页由 %@ 提供", absurl];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_mode != HMWebViewControllerModeAuto) return;
    
    CGFloat currentPostion = scrollView.contentOffset.y;
    if (currentPostion == 0.0) return;
//    NSLog(@"current：%f---last:%f",currentPostion, _lastPosition);
    
    // 每次滚动的距离
    CGFloat distance = currentPostion - _lastPosition;
    _lastPosition = currentPostion;
    
    if (distance > 0 ) {// 内容上滚:隐藏
        
        if (currentPostion <= 1.0 ) {  // 滚到顶部：显示
            [self setDynamicNavBarHidden:NO bottomBarHidden:NO animated:YES];
            return;
        }
        
//        NSLog(@"ScrollUp now; ");
        [self setDynamicNavBarHidden:YES bottomBarHidden:YES animated:YES];
        
    }else if ((currentPostion <= scrollView.contentSize.height - scrollView.bounds.size.height) ) {// 内容下滚：显示
        
//        NSLog(@"ScrollDown now; 滚了%f",ABS(distance));
        
        if (ABS(distance) < kScrollDistance) return;
        [self setDynamicNavBarHidden:NO bottomBarHidden:NO animated:YES];
    }
    
}

#pragma mark - <NJKWebViewProgressDelegate>
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

#pragma mark - Private Method
- (void)loadRequest
{
    if (_urlString) {
        if(_POSTBody == nil){
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
            [self.webView loadRequest:request];
        }else{
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
            [request setHTTPMethod: @"POST"];
            [request setHTTPBody: [_POSTBody dataUsingEncoding: NSUTF8StringEncoding]];
            [self.webView loadRequest:request];
        }
        
    }else if (_htmlString) {
        [self.webView loadHTMLString:_htmlString baseURL:nil];
        
    }else{
        NSLog(@"Error: `%@` need a request", NSStringFromClass([self class]));
    }
}

#pragma mark 关联H5连接登录
- (void)webConnectLoginWithAddress:(NSString *)address
{
    NSString *token = [HMNetworking token];
    __weak typeof(self) weakSelf = self;
    
    [HMNetworking postWithURL:URL_WebConnect_Login serverAddress:address params:@{@"key":token,@"isVisitor":@NO} success:^(id respondData) {
        
        NSLog(@"respondData%@",respondData);
        
        [weakSelf.webView reload];
        
        if ([URL_DLQHOSTNAME isEqualToString:address]) {// 动力圈
            
        }
        
        [HMHUD dismiss];
        
    } failure:^(HMErrorModel *error) {
        
        NSLog(@"errCode%@",error.errCode);
        [HMHUD dismiss]; 
        
        static int isCalling_ = 0;
        
        // 尝试5次登录都不成功就不再登录
        if (isCalling_ > 5) {
            NSLog(@"尝试5次登录都不成功就不再登录");
            return;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            isCalling_++;
            [weakSelf webConnectLoginWithAddress:address];
        });
    }];
}

// 显示关闭按钮
- (void)checkCloseItem
{
    // 拿到分享按钮
    UIBarButtonItem *closeItem = [self.navigationItem.leftBarButtonItems lastObject];
    UIView *view = closeItem.customView;

    view.hidden = !self.webView.canGoBack;
}

#pragma mark - Event

// 点击后退
- (void)backItemPressed
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self closeItemPressed];
    }
}

// 点击关闭
- (void)closeItemPressed
{
    if ([self.delegate respondsToSelector:@selector(willClosedWebViewController)]) {
        [self.delegate willClosedWebViewController];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 点击分享
- (void)shareItemPressed
{
    NSLog(@"%s", __func__);
    
    if ([self.delegate respondsToSelector:@selector(didClickShareWithWebView:bridge:)]) {
        [self.delegate didClickShareWithWebView:self.webView bridge:self.bridge];
    }else{
        __weak typeof(self) weakSelf = self;
        
        __weak typeof(UIWebView *) weakWebView = _webView;
        
        __weak typeof(WebViewJavascriptBridge *) weakBridge = _bridge;
        
        [_bridge callHandler:kShareHandler_t3 data:nil responseCallback:^(id responseData) {
            
            NSString *ID = nil;
            NSString *title = [weakWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
            NSString *content = title;
            NSString *linkUrl = [NSString stringWithFormat:@"%@",weakWebView.request.URL];
            NSString *imgUrl = URL_LOGO_URLSTRING;
            
            
            // 如果网页有分享内容则使用网页的
            if (responseData && [responseData isKindOfClass:[NSDictionary class]]) {
                
                ID = [responseData objectForKeyWithoutNull:@"ID"];
                title = [responseData objectForKeyWithoutNull:@"title"];
                content = [responseData objectForKeyWithoutNull:@"content"];
                linkUrl = [responseData objectForKeyWithoutNull:@"http_url"];
                
                NSString *data_imgUrl = [responseData objectForKeyWithoutNull:@"img_url"];
                if (data_imgUrl) {
                    imgUrl = data_imgUrl;
                }
                
             
                // 分享后的回调
                [[HMShareTool sharedShare] setShareCompleteBlcok:^(BOOL succeed, NSDictionary *ret) {
                    if (succeed) {
                        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                        if (NotNilAndNull(ID)) {
                            [dict setValue:ID forKey:@"ID"];
                        }
                        [dict setValue:@(YES) forKey:@"IsSuccess"];
                        
                        [weakBridge callHandler:kShareHandler_Success data:dict];
                    }
                }];
                
                
                NSString *imgSrc = [weakWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('reimg').src"];
                if ([imgSrc isKindOfClass:[NSString class]] && imgSrc.length > 0) {
                    imgUrl = imgSrc;
                }
               
            }
            
            
            [[HMShareTool sharedShare] shareInfoWithSharetitle:title andStareText:content andShareUrl:linkUrl shareImageArray:@[imgUrl] shareView:weakSelf.view.window shareTextAndUrl:content];
        }];

    }
    
}

#pragma mark - getter/setter
- (void)setShowShare:(BOOL)showShare
{
    _showShare = showShare;
    
    // 拿到分享按钮
    UIBarButtonItem *shareItem = [self.navigationItem.rightBarButtonItems firstObject];
    UIView *view = shareItem.customView;
    view.hidden = !showShare;
}

- (UIWebView *)webView
{
    if (_webView == nil) {
        // 初始化
        UIWebView *webView = [[UIWebView alloc] init];
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        webView.scrollView.showsVerticalScrollIndicator = NO;
        webView.backgroundColor = HMRGB(39, 44, 44);
        webView.allowsInlineMediaPlayback = YES;
        webView.mediaPlaybackRequiresUserAction = NO;
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}


- (UILabel *)tipLabel
{
    if (_tipLabel == nil) {
        // 添加"网页由xxx提供"的提示标签
        UILabel *tipLabel = [[ UILabel alloc] initWithFrame:CGRectMake(0, 16, self.view.width, 44)];
        tipLabel.font = [UIFont systemFontOfSize:12];
        tipLabel.textColor = HMRGB(92, 97, 99);
        tipLabel.textAlignment = NSTextAlignmentCenter;
        [self.webView insertSubview:tipLabel atIndex:0];
        _tipLabel = tipLabel;
    }
    return _tipLabel;
}

- (NJKWebViewProgress *)progressProxy
{
    if (_progressProxy == nil) {
        // 添加进度条
        _progressProxy = [[NJKWebViewProgress alloc] init];
        self.webView.delegate = _progressProxy;
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
        CGFloat progressBarHeight = 2.f;
        CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_progressView setProgress:0.0];
    }
    return _progressProxy;
}

- (void)setDynamicNavBarHidden:(BOOL)navBarHidden bottomBarHidden:(BOOL)bottomBarHidden animated:(BOOL)animated
{
    // 避免重复设置
    if(_isDynamicNavBarHidden == navBarHidden && _isDynamicBottomBarHidden == bottomBarHidden) return;
    
    _isDynamicNavBarHidden = navBarHidden;
    _isDynamicBottomBarHidden = bottomBarHidden;
    
    CGFloat navHeight = navBarHidden ? 0 : kNavBarHeight;
    CGFloat BarHeight = bottomBarHidden ? 0 : kWebBottomBarHeight;
    
    CGFloat webViewHeight = kSCREEN_HEIGHT - navHeight - BarHeight;
    //    NSLog(@"navHeight%f--BarHeight%f--webViewHeight%f",navHeight, BarHeight, webViewHeight);
    
    CGFloat duration = 0;
    // 需要动画
    if (animated ) {
        duration = UINavigationControllerHideShowBarDuration;
    }
    
    [self.navigationController setNavigationBarHidden:navBarHidden animated:animated];
    
    [UIView animateWithDuration:duration animations:^{
        self.webView.frame = CGRectMake(0, navHeight, self.view.width, webViewHeight);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)setMode:(HMWebViewControllerMode)mode
{
    _mode = mode;
    CGFloat NavBarHeight = kNavBarHeight;
    if (self.navigationController.isNavigationBarHidden || ![self.navigationController.viewControllers containsObject:self]) {
        NavBarHeight = 0.0;
    }
    
    if (mode == HMWebViewControllerModeHide) {
        self.webView.frame = CGRectMake(0, NavBarHeight, self.view.width, self.view.height - NavBarHeight);
    }else{
        self.webView.frame = CGRectMake(0, NavBarHeight, self.view.width, self.view.height - NavBarHeight - kWebBottomBarHeight);
    }
}


@end
