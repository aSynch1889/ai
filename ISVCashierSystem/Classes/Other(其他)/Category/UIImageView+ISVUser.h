//
//  UIImageView+ISVUser.h
//  ISV
//
//  Created by aaaa on 15/12/1.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ISVUser)

/**
 *  设置圆形头像专用
 *
 *  @param url 头像链接
 */
- (void)setHeaderPic:(NSString *)url;

/**
 *  设置圆形头像专用 (可为头像加添加事件)
 */
- (void)setHeaderPic:(NSString *)url target:(id)target selector:(SEL)selector;


// ============================== 不缓存裁剪后的图片 ======================
/**
 *  设置圆形头像专用(不缓存裁剪后的图片)
 *
 *  @param url 头像链接
 */
- (void)setHeaderPicDontClip:(NSString *)url;

/**
 *  设置圆形头像专用(不缓存裁剪后的图片) (可为头像加添加事件)
 */
- (void)setHeaderPicDontClip:(NSString *)url target:(id)target selector:(SEL)selector;

@end
