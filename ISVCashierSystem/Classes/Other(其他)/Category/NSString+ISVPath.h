//
//  NSString+ISVPath.h
//  ISV
//
//  Created by aaaa on 15/11/25.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <Foundation/Foundation.h>

// 拼接路径 [@"xxx.plist" cachePath]; -> @"~/cache/xxx.plist"
@interface NSString (ISVPath)

/**
 *  返回缓存路径的完整路径名
 */
- (NSString *)cachePath;

/**
 *  返回文档路径的完整路径名
 */
- (NSString *)documentPath;

/**
 *  返回临时路径的完整路径名
 */
- (NSString *)tmpPath;

/**
 *  判断文件是否存在
 */
- (BOOL)FileIsExists;

@end

/*
 - Documents
 - 需要保存由"应用程序本身"产生的文件或者数据，例如：游戏进度、涂鸦软件的绘图
 - 目录中的文件会被自动保存在 iCloud
 - 注意：不要保存从网络上下载的文件，否则会无法上架！
 
 - Caches
 - 保存临时文件，"后续需要使用"，例如：缓存图片，离线数据(地图数据)
 - 系统不会清理 cache 目录中的文件
 - 就要求程序开发时，"必须提供 cache 目录的清理解决方案"
 - Preferences
 - 用户偏好，使用 NSUserDefault 直接读写！
 - 如果要想数据及时写入磁盘，还需要调用一个同步方法
 
 - tmp
 - 保存临时文件，"后续不需要使用"
 - tmp 目录中的文件，系统会自动清理
 - 重新启动手机，tmp 目录会被清空
 - 系统磁盘空间不足时，系统也会自动清理
 */
