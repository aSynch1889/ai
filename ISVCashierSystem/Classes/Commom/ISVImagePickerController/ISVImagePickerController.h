//
//  ISVImagePickerController.h
//  imgPicker
//
//  Created by aaaa on 16/1/5.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISVAssetModel.h"

@interface ISVImagePickerController : UINavigationController

//最大选择图片数
@property (nonatomic,assign) NSInteger maxCount;

// 返回用户选择的照片的缩略图/原图
@property (nonatomic,copy) void(^didFinishSelectImages)(NSArray *thumbImages, NSArray *images);

@end
