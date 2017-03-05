//
//  ISVBannerView.h
//  ISV
//
//  Created by aaaa on 17/03/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISVBannerView;

@protocol ISVBannerViewDelegate <NSObject>

@optional
- (void)bannerView:(ISVBannerView *)bannerView didTapAtIndex:(NSInteger)index;

@end


/******** 循环轮播图 **********/
@interface ISVBannerView : UIView

/// 图片组(设置本地图片)
//@property (nonatomic, strong) NSArray<UIImage*> *localizationImagesGroup;
@property (nonatomic, strong) NSMutableArray<UIImage*> *imagesGroup;

/// 网络图片 url string 数组
@property (nonatomic, strong) NSArray<NSString*> *imageURLStringsGroup;

/// 自动滚动间隔时间,默认2s
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

@property (nonatomic, weak) id<ISVBannerViewDelegate> delegate;

/// 占位图，用于网络未加载到图片时
@property (nonatomic, strong) UIImage *placeholderImage;


+ (instancetype)bannerViewWithFrame:(CGRect)frame imagesGroup:(NSArray<UIImage*> *)imagesGroup;

+ (instancetype)bannerViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray<NSString*> *)imageURLStringsGroup;

- (void)setAutoScroll:(BOOL)autoScroll;

/// 清除缓存接口
- (void)clearCache;

@end
