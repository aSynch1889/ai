//
//  HMBannerView.m
//  HealthMall
//
//  Created by jkl on 15/11/4.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMBannerView.h"
#import "HMBannerViewCell.h"
#import "NSData+HMDataCache.h"

NSString *const ID = @"HMBannerViewCell";

@interface HMBannerView () <UICollectionViewDataSource, UICollectionViewDelegate>

/// 显示图片的collectionView
@property (nonatomic, weak) UICollectionView *mainView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray<NSString*> *imgurlArr;
@end


@implementation HMBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initialization];
        [self setupMainView];
    }
    return self;
}

- (void)initialization
{
    _autoScrollTimeInterval = 5.0;
}

- (void)dealloc
{
    _mainView.delegate = nil;
    _mainView.dataSource = nil;
    [_timer invalidate];
    _timer = nil;
}

// 设置显示图片的collectionView
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.frame.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[HMBannerViewCell class] forCellWithReuseIdentifier:ID];
    mainView.dataSource = self;
    mainView.delegate = self;
    [self addSubview:mainView];
    _mainView = mainView;
}

+ (instancetype)bannerViewWithFrame:(CGRect)frame imagesGroup:(NSArray<NSString *> *)imagesGroup
{
    HMBannerView *bannerView = [[self alloc] initWithFrame:frame];
    bannerView.imagesGroup = [NSMutableArray arrayWithArray:imagesGroup];
    return bannerView;
}

+ (instancetype)bannerViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray<NSString *> *)imageURLStringsGroup
{
    HMBannerView *bannerView = [[self alloc] initWithFrame:frame];
    bannerView.imageURLStringsGroup = [NSMutableArray arrayWithArray:imageURLStringsGroup];
    return bannerView;
}

#pragma mark - setter和getter
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _flowLayout.itemSize = self.frame.size;
}


- (void)setAutoScroll:(BOOL)autoScroll
{
    [_timer invalidate];
    _timer = nil;
    
    if (autoScroll)
    {
        [self setupTimer];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
}

- (void)setImagesGroup:(NSMutableArray *)imagesGroup
{
    _imagesGroup = imagesGroup;
    _totalItemsCount = self.imagesGroup.count * 100;
    self.mainView.scrollEnabled = imagesGroup.count > 1 ? YES : NO;
    [self setupPageControl];
    [self.mainView reloadData];
}

- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup
{
    self.imgurlArr = [imageURLStringsGroup mutableCopy];
    _imageURLStringsGroup = self.imgurlArr;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:imageURLStringsGroup.count];
    for (int i = 0; i < imageURLStringsGroup.count; ++i)
    {
        UIImage *image = [[UIImage alloc] init];
        [images addObject:image];
    }
    self.imagesGroup = images;
    
    [self loadImageWithImageURLsGroup:imageURLStringsGroup];
    
    if (imageURLStringsGroup.count > 1)
    {
        [self setAutoScroll:YES];
    }
}


#pragma mark - 加载图片

- (void)loadImageWithImageURLsGroup:(NSArray *)imageURLsGroup
{
    for (int i = 0; i < imageURLsGroup.count; i++)
    {
        [self loadImageAtIndex:i];
    }
}

- (void)loadImageAtIndex:(NSInteger)index
{
    NSString *urlStr = self.imageURLStringsGroup[index];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 如果有缓存，直接加载缓存
    NSData *data = [NSData getDataCacheWithIdentifier:urlStr];
    if (data)
    {
        [_imagesGroup setObject:[UIImage imageWithData:data] atIndexedSubscript:index];
    } else
    {
        // 网络加载图片并缓存图片
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                           queue:[[NSOperationQueue alloc] init]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                                   if (!connectionError)
                                   {
                                       UIImage *image = [UIImage imageWithData:data];
                                       if (!image) return;  // 防止错误数据导致崩溃
                                       [_imagesGroup setObject:image atIndexedSubscript:index];
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           if (index == 0)
                                           {
                                               [self.mainView reloadData];
                                           }
                                       });
                                       [data saveDataCacheWithIdentifier:url.absoluteString];
                                   } else
                                   {
                                       // 加载数据失败
                                       static int repeat = 0;
                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                           if (repeat > 10)
                                           {
                                               [self.imgurlArr removeObject:urlStr];
                                               self.imageURLStringsGroup = self.imgurlArr;
                                           }
                                           else
                                           {
                                               [self loadImageAtIndex:index];
                                               repeat++;
                                           }
                                           
                                       });
                                   }
                               }];
    }
    
}


- (void)setupPageControl
{
    if (_pageControl) [_pageControl removeFromSuperview];  // 重新加载数据时调整
    
    // 图片大于1张才显示分页条
    if (self.imagesGroup.count > 1)
    {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = self.imagesGroup.count;
        pageControl.pageIndicatorTintColor = HMRGBACOLOR(255, 255, 255, 0.5);
        pageControl.currentPageIndicatorTintColor = HMMainlColor;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
}


- (void)automaticScroll
{
    if (0 == _totalItemsCount) return;
    int currentIndex = _mainView.contentOffset.x / _flowLayout.itemSize.width;
    int targetIndex = currentIndex + 1;
    
    if (targetIndex == _totalItemsCount)
    {
        targetIndex = _totalItemsCount * 0.5;
        
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    else if (targetIndex > _totalItemsCount)
    {
        return;
    }
    
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark - life circles

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    
    _mainView.frame = self.bounds;
    if (_mainView.contentOffset.x == 0 &&  _totalItemsCount)
    {
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_totalItemsCount * 0.5 inSection:0]
                          atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize size = CGSizeMake(self.imagesGroup.count * 10 * 1.2, 10);
    CGFloat x = (self.frame.size.width - size.width) * 0.5;
    CGFloat y = self.mainView.frame.size.height - size.height - 10;
    _pageControl.frame = CGRectMake(x, y, size.width, size.height);
    _pageControl.hidden = self.imageURLStringsGroup.count > 1 ? NO : YES;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - 清除缓存
- (void)clearCache
{
    [NSData clearCache];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    long itemIndex = indexPath.item % self.imagesGroup.count;
    UIImage *image = self.imagesGroup[itemIndex];
    if (image.size.width == 0 && self.placeholderImage)
    {
        image = self.placeholderImage;
    }
    cell.imageView.image = image;
        
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(bannerView:didTapAtIndex:)])
    {
        NSInteger index = indexPath.item % self.imagesGroup.count;
        [self.delegate bannerView:self didTapAtIndex:index];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.imagesGroup.count < 2) return;
    
    int itemIndex = (scrollView.contentOffset.x + self.mainView.frame.size.width * 0.5) / self.mainView.frame.size.width;
    int indexOnPageControl = itemIndex % self.imagesGroup.count;
    _pageControl.currentPage = indexOnPageControl;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.imageURLStringsGroup.count > 1)
    {
        [self setupTimer];
    }
}

@end
