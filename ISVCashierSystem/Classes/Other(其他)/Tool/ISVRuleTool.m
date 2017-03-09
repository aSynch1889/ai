//
//  ISVRuleTool.h
//  ISV
//
//  Created by aaaa on 17/3/02.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVRuleTool.h"


@implementation ISVRuleTool


/**
 *  跳转浏览器
 */
+ (void)ruleForWebWithViewController:(UIViewController *)viewController urlString:(NSString *)urlString
{
    NSLog(@"跳转浏览器urlString:%@", urlString);
    
    if (urlString.length == 0) {
        [ISVHUD showErrorWithStatus:@"访问路径不能为空"];
        return;
    }
    
    if ([urlString hasPrefix:@"http://"] || [urlString hasPrefix:@"https://"]) {
#warning 未完成
//        HMWebViewController *webVC = [[HMWebViewController alloc] init];
//        webVC.urlString = urlString;
//        [viewController.navigationController pushViewController:webVC animated:YES];
    }else{
        [ISVHUD showErrorWithStatus:@"访问地址错误"];
    }
}

/**
 *  其他规则处理
 */
+ (void)ruleForOtherWithViewController:(UIViewController *)viewController urlString:(NSString *)urlString
{
    if ([urlString isKindOfClass:[NSString class]]) {
        if (urlString.length == 0) {
            [ISVHUD showErrorWithStatus:@"访问路径不能为空"];
            return;
        }
        
        NSUInteger l1 = [urlString rangeOfString:@"hmtribe_"].location;
        NSUInteger l2 = [urlString rangeOfString:@"hm_"].location;
        
        if (l1 != NSNotFound || l2 != NSNotFound ) {
            
            UIAlertView *alertview =[[UIAlertView alloc] initWithTitle:nil message:@"此二维码已过期，请使用最新版本生成二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertview show];
            
        }else{
            [ISVHUD showErrorWithStatus:@"无法识别该二维码"];
        }
    }
}
@end
