//
//  ISVAssetModel.h
//  imgPicker
//
//  Created by aaaa on 16/1/5.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISVAssetModel : NSObject
@property (nonatomic,strong) UIImage *thumbnail;//缩略图
@property (nonatomic,copy) NSURL *imageURL;//原图url
@property (nonatomic,assign) BOOL isSelected;//是否被选中
- (void)originalImage:(void (^)(UIImage *image))returnImage;//获取原图
@end
