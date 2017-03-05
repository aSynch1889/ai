//
//  HMAssetModel.m
//  imgPicker
//
//  Created by qiuwei on 16/1/5.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "HMAssetModel.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation HMAssetModel
- (void)originalImage:(void (^)(UIImage *))returnImage{
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    [lib assetForURL:self.imageURL resultBlock:^(ALAsset *asset) {
        ALAssetRepresentation *rep = asset.defaultRepresentation;
        CGImageRef imageRef = rep.fullResolutionImage;
        UIImage *image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:(UIImageOrientation)rep.orientation];
        if (image) {
            returnImage(image);
        }
    } failureBlock:^(NSError *error) {
        
    }];
}
@end
