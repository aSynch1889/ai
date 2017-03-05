//
//  HMQRCodeTool.m
//  HealthMall
//
//  Created by qiuwei on 15/12/18.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMQRCodeTool.h"
#import <CoreImage/CoreImage.h>
#import "HMScan/HMScanViewController.h"
#import "ISVNavigationController.h"
#import "HMSystemTool.h"
#import "ZXingObjC.h"   // 图片识别二维码（为了兼容iOS7）
#import "HMNetworkingConst.h"
#import "SCRSA.h"
#import "Base64.h"
#import "HMNetworking+UserCenter.h"
#import "HMHUD.h"
#import "HMRuleTool.h"

static NSString * const publicKeyStr = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDAIinxzq7wEx9fEKjQ1xez0U/5\n8l7ebLntaVHOdkNhhwFjOTZBozmomKLf8G5oTL+BjM+DiHVjxbxKs1uES2SSKNTx\n59qw5UGsowbRPcI6XzcHMsbLD3CvFdStQ+ilj4zALK+Nwgs1510bRvQE9PYX2+pa\nmAmgMhuNZ2C8oMabaQIDAQAB\n-----END PUBLIC KEY-----\n";

@implementation HMQRCodeTool

/*
 二维码生成（暂时客户端生成）：
 1.	加密：
 1.拼接字符串：1:10086  （key:value格式  key暂定有1代表用户、2代表群聊、3代表链接  value为对应的值用户ID、群聊ID、链接地址）
 2.对拼接字符串使用rsa算法进行publicKey加密
 3.对加密后的字节数组进行base编码为base64字符串
 
 2.生成：
 http://xxx.com/common/qrcode?code=
 的后面拼接base64字符串组成二维码信息生成二维码
 
 
 二维码扫描：
 扫描出来的二维码信息为http://xxx.com/common/qrcode?code=base64
 1.客户端取得链接参数code的值即base64
 2.调用解密接口解密得到1:10086
 3.进行对应处理
 
 respondData-----{
 "MsgTime" : "2016-01-19T11:12:17.6769044+08:00",
 "succeed" : 1,
 "errmsg" : 10676,
 "valuse" : {
 "Key" : 1,
 "Value" : "9798"
 
 }
 }
 */

/**
*  弹出二维码控制器(指定规则)
*  @param rule   规则类型
*/
+ (void)showScanControllWithViewController:(UIViewController *)viewController forRule:(HMQRCodeToolRule)toRule
{
    // 暂时不对指定的路由处理
    
    __weak typeof(viewController) weakVC = viewController;
    [self showScanControllWithViewController:viewController completeBlock:^(HMQRCodeToolRule foromRule, NSString *value) {
        
        if (foromRule == HMQRCodeToolRuleAddFriend) {// 添加好友
            [HMRuleTool ruleForAddFriendWithViewController:weakVC userID:value];
        }else if(foromRule == HMQRCodeToolRuleJoinTribe){// 加入群
            [HMRuleTool ruleForJoinTribeWithViewController:weakVC userID:value];
        }else if(foromRule == HMQRCodeToolRuleWeb){// 浏览器(加密)
            [HMRuleTool ruleForWebWithViewController:weakVC urlString:value];
        }else if(foromRule == HMQRCodeToolRuleOther){// 浏览器(未加密)
            [HMRuleTool ruleForOtherWithViewController:weakVC urlString:value];
        }
    }];
}


// 弹出二维码控制器(回调)
+ (void)showScanControllWithViewController:(UIViewController *)viewController completeBlock:(void(^)(HMQRCodeToolRule rule, NSString *value))completeBlock;
{
    [HMSystemTool captureDeviceAuthStatusWithSuccessCallback:^{
        
        HMScanViewController *scanViewController = [[HMScanViewController alloc] init];
        [scanViewController setCompleteBlock:^(NSString *str) {
            NSLog(@"HMQRCodeTool扫描到：%@", str);
            
            if (!str || [str isKindOfClass:[NSNull class]]) {
                [HMHUD showErrorWithStatus:@"不能识别的二维码"];
                return ;
            }
            //str  做截取
            NSRange range;
            NSString *sepStr = [NSString stringWithFormat:@"%@%@", URL_CreateQRcode, createQRCode];
            range = [str rangeOfString:sepStr];
            if (range.location != NSNotFound) { // 加密过的
                NSLog(@"found at location = %lu, length = %lu",(unsigned long)range.location,(unsigned long)range.length);
                
                [str substringFromIndex:range.length];
                NSLog(@"  ----错误信息 %@ ----",[str substringFromIndex:range.length]);
                
                [HMNetworking userGetQRCodeInfoWithEncryptKey:[str substringFromIndex:range.length] success:^(id respondData) {
                    
                    if (HasValuse) {
                        NSDictionary *dict = Response_Valuse;
                        HMQRCodeToolRule Key = [[dict objectForKey:@"Key"] integerValue];
                        NSString *Value = [dict objectForKey:@"Value"];
                        
                        ! completeBlock ? : completeBlock(Key, Value);
                    }
                    
                } failure:^(HMErrorModel *error) {
                    [HMHUD showErrorWithStatus:error.errMsg];
                }];
                
            }else{ // 未加密过的
                ! completeBlock ? : completeBlock(HMQRCodeToolRuleOther, str);
            }
            
        }];
#warning 未修复完成
//        HMNavigationController *navVC = [[HMNavigationController alloc] initWithRootViewController:scanViewController];
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:scanViewController];
        [viewController presentViewController:navVC animated:YES completion:nil];
        
    } failedCallback:^() {
        [HMHUD showErrorWithStatus:@"扫描出错"];
    }];
}

+ (UIImage *)QRCodeFromKey:(NSUInteger )key
                      type:(NSString *)type
                      size:(CGFloat)size{
    
    NSString *dataStr = [NSString stringWithFormat:@"%@:%@",[NSNumber numberWithUnsignedInteger:key],type];
    //先对key value 进行RSA加密
    SCRSA *enRSA = [[SCRSA alloc] initWithKeyContent:publicKeyStr keyType:KeyTypePublic];
    
    [enRSA encryptByRsa:dataStr];
    
    NSLog(@"encrypt text is %@",dataStr);
    
    NSLog(@"encrypted is %@",[enRSA encryptByRsa:dataStr]);
    
//    [HMNetworking userGetQRCodeInfoWithEncryptKey:[enRSA encryptByRsa:dataStr] success:^(id respondData) {
//        NSLog(@"respondData-----%@ -----",respondData);
//        
//        
//    } failure:^(HMErrorModel *error) {
//        NSLog(@"error  ----错误信息 %@ ----",error);
//        [HMHUD showErrorWithStatus:error.errMsg];
//    }];
    //后拼接URL
    NSString *url = [NSString stringWithFormat:@"%@%@%@", URL_CreateQRcode, createQRCode, [enRSA encryptByRsa:dataStr]];
    NSLog(@"encrypted url is %@",url);
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认
    [filter setDefaults];
    
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5.返回二维码图片
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
}

+ (UIImage *)QRCodeFromString:(NSString *)str size:(CGFloat)size{
    
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认
    [filter setDefaults];
    
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5.返回二维码
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
}

/**
 *  生成自定义的二维码 （中间带图片,背景为二维嘛）
 *  @return 自定义二维码图片
 */
+ (UIImage *)QRCodeFromString:(NSString *)str size:(CGFloat)size QRCodeImageType:(QRCodeImageType) type iconImage:(UIImage *)iconImage iconImageSize:(CGFloat)iconImageSize
{
    // 背景为普通二维码
    UIImage *bgImage = [self QRCodeFromString:str size:size];
    // 如果为圆形,对图片进行切割
    if (type == QRCodeImageCircular) {
        iconImage = [self createCircularImage:iconImage];
    }
    UIImage *newImage = [self createNewImageWithBg:bgImage iconImage:iconImage iconImageSize:iconImageSize];
    return newImage;
    
}

/**
 *  从图片中识别二维码
 */
+ (NSString *)stringFromQRCodeImage:(CGImageRef)qRCodeImage error:(NSError *)error
{
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:qRCodeImage];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString *contents = result.text;
        NSLog(@"识别到:%@", contents);
        return contents;
        // The barcode format, such as a QR code or UPC-A
        //        ZXBarcodeFormat format = result.barcodeFormat;
    }
    return nil;
}

#pragma mark - Private
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
// 剪裁圆形图片
+ (UIImage *)createCircularImage:(UIImage *)iconImage
{
    // 1. 创建一个bitmap类型图形上下文（空白的UiImage）
    // NO 将来创建的透明的UiImage
    // YES 不透明
    UIGraphicsBeginImageContextWithOptions(iconImage.size, NO, 0);
    
    // 2. 指定可用范围
    // 2.1 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.2 画圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, iconImage.size.width, iconImage.size.height));
    // 2.3 裁剪，指定将来可以画图的可用范围
    CGContextClip(ctx);
    
    // 3. 绘制图片
    [iconImage drawInRect:CGRectMake(0, 0, iconImage.size.width, iconImage.size.height)];
    
    // 4. 取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.1 关闭图形上下文
    UIGraphicsEndImageContext();
    return newImage;
}
// 绘制图片
+ (UIImage *)createNewImageWithBg:(UIImage *)bgImage iconImage:(UIImage *)iconImage iconImageSize:(CGFloat)iconImageSize
{
    // 1.开启图片上下文
    UIGraphicsBeginImageContext(bgImage.size);
    // 2.绘制背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 3.绘制图标
    CGFloat imageW = iconImageSize;
    CGFloat imageH = iconImageSize;
    CGFloat imageX = (bgImage.size.width - imageW) * 0.5;
    CGFloat imageY = (bgImage.size.height - imageH) * 0.5;
    [iconImage drawInRect:CGRectMake(imageX, imageY, imageW, imageH)];
    
    // 4.取出绘制好的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    // 6.返回生成好得图片
    return newImage;
}

@end
