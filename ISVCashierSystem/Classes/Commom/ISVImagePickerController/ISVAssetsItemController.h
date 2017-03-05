//
//  ISVAssetsItemController.h
//  imgPicker
//
//  Created by aaaa on 16/1/5.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsGroup;

@interface ISVAssetsItemController : UICollectionViewController
@property (nonatomic,strong) ALAssetsGroup *group;
@property (nonatomic,assign) NSInteger maxCount;
@end
