//
//  UIImage+ISVVideoThumb.h
//  ISV
//
//  Created by aaaa on 16/1/7.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ISVVideoThumb)

/**
 *  获取本地视频的缩略图
 *
 *  @param videoURL 视频URL
 */
- (UIImage *)thumbNailImageWithVideo:(NSURL *)videoURL;
@end
