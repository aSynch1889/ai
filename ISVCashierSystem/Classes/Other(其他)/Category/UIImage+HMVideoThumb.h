//
//  UIImage+HMVideoThumb.h
//  HealthMall
//
//  Created by qiuwei on 16/1/7.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HMVideoThumb)

/**
 *  获取本地视频的缩略图
 *
 *  @param videoURL 视频URL
 */
- (UIImage *)thumbNailImageWithVideo:(NSURL *)videoURL;
@end
