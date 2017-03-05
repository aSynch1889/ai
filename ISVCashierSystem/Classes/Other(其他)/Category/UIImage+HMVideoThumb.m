//
//  UIImage+HMVideoThumb.m
//  HealthMall
//
//  Created by qiuwei on 16/1/7.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "UIImage+HMVideoThumb.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (HMVideoThumb)

// 获取本地视频的缩略图
- (UIImage *)thumbNailImageWithVideo:(NSURL *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *currentImg = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return currentImg;
}

@end
