//
//  HMAssetModel.h
//  imgPicker
//
//  Created by qiuwei on 16/1/5.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMAssetModel : NSObject
@property (nonatomic,strong) UIImage *thumbnail;//缩略图
@property (nonatomic,copy) NSURL *imageURL;//原图url
@property (nonatomic,assign) BOOL isSelected;//是否被选中
- (void)originalImage:(void (^)(UIImage *image))returnImage;//获取原图
@end
