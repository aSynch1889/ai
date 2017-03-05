//
//  HMImagePickerController.h
//  imgPicker
//
//  Created by qiuwei on 16/1/5.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMAssetModel.h"

@interface HMImagePickerController : UINavigationController

//最大选择图片数
@property (nonatomic,assign) NSInteger maxCount;

// 返回用户选择的照片的缩略图/原图
@property (nonatomic,copy) void(^didFinishSelectImages)(NSArray *thumbImages, NSArray *images);

@end
