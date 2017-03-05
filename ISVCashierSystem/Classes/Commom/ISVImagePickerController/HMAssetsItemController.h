//
//  HMAssetsItemController.h
//  imgPicker
//
//  Created by qiuwei on 16/1/5.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsGroup;

@interface HMAssetsItemController : UICollectionViewController
@property (nonatomic,strong) ALAssetsGroup *group;
@property (nonatomic,assign) NSInteger maxCount;
@end
