//
//  HMFileTool.h
//  HealthMall
//
//  Created by qiuwei on 16/2/16.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMFileTool : NSObject
/**
 *  遍历文件夹获得文件夹大小，返回多少M
 */
+ (float)folderSizeAtPath:(NSString*)folderPath;

/**
 *  单个文件的大小
 */
+ (float)fileSizeAtPath:(NSString*)filePath;
@end
