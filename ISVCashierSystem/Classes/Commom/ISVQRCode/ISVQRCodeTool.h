//
//  ISVQRCodeTool.h
//  ISV
//
//  Created by aaaa on 15/12/18.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    QRCodeImageCircular,  // 圆形图片
    QRCodeImageSquare,    // 方形图片
}QRCodeImageType;


/**
 *  二维码
 */
@interface ISVQRCodeTool : NSObject

/**
 *  弹出二维码控制器,并指定规则(⭐️项目中推荐使用⭐️)
 *  @param rule   规则类型
 */
+ (void)showScanControllWithViewController:(UIViewController *)viewController forRule:(ISVQRCodeToolRule)rule;

// 弹出二维码控制器
+ (void)showScanControllWithViewController:(UIViewController *)viewController completeBlock:(void(^)(ISVQRCodeToolRule rule, NSString *value))completeBlock;

/**
 *  根据字符串生成二维码
 *  @return 二维码图片
 */
+ (UIImage *)QRCodeFromString:(NSString *)str size:(CGFloat)size;

/**
 *  根据字符串生成二维码（⭐️适应于本项目⭐️）
 *
 *  @param key  key暂定有1代表用户、2代表群聊、3代表链接
 *  @param type value为对应的值用户ID、群聊ID、链接地址
 *  @param size 尺寸
 *
 *  @return 二维码图片
 */
+ (UIImage *)QRCodeFromKey:(NSUInteger )key
                         type:(NSString *)type
                         size:(CGFloat)size;

/**
 *  生成自定义的二维码 （中间带图片,背景为二维嘛）
 *
 *  @param size      二维码的大小
 *  @param type      自定义二维码图片的种类（中间图片为方形，中间图片为圆形）
 *  @param image     中间图片
 *  @param imageSize 中间图片的大小
 *  @param data 数据
 *  @return 自定义二维码图片
 */
+ (UIImage *)QRCodeFromString:(NSString *)str size:(CGFloat)size QRCodeImageType:(QRCodeImageType) type iconImage:(UIImage *)iconImage iconImageSize:(CGFloat)iconImageSize;

/**
 *  从图片中识别二维码
 *  @param qRCodeImage 二维码图片
 *  @return 内容
 */
+ (NSString *)stringFromQRCodeImage:(CGImageRef)qRCodeImage error:(NSError *)error;

@end
