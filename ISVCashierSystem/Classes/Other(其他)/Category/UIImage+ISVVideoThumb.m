//
//  UIImage+ISVVideoThumb.m
//  ISV
//
//  Created by aaaa on 16/1/7.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "UIImage+ISVVideoThumb.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (ISVVideoThumb)

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
