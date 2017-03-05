//
//  HMImageViewContainerListView.m
//  HealthMall
//
//  Created by qiuwei on 15/11/26.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMImageViewContainerListView.h"
#import "HMImageViewContainerView.h"
#import "HMUserInterfaceTool.h"
#include <MobileCoreServices/UTCoreTypes.h>

#import "JTSImageViewController.h"
#import "JTSImageInfo.h"

#define kImageListDefaultMaxCount 9
#define kImageListDefaultMaxColumn 3
#define kImageListDefaultRowMargin  5.0
#define kImageListDefaultColumnMargin 4.0
#define kImageListDefaultAnimateDuration 0.35
#define kImageListOtherImageCount 1

@interface HMImageViewContainerListView ()<HMImageViewContainerViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSMutableArray<HMImageViewContainerView *> *_imageViews;
    NSMutableArray<HMImageViewContainerView *> *_checkedImageViews;
    HMImageViewContainerView *_activeImageView;
    UIActionSheet *_addSheet;
}
@property (nonatomic, weak) UIButton *addButton; // 加号按钮
@end

@implementation HMImageViewContainerListView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setUp];
}

- (void)setUp
{
    _imageViews = [NSMutableArray array];
    _checkedImageViews = [NSMutableArray array];
    
    if (!_imageListMaxCount) {
        _imageListMaxCount = kImageListDefaultMaxCount;
    }
    if (!_imageListMaxColumn) {
        _imageListMaxColumn = kImageListDefaultMaxColumn;
    }
    if (!_imageListRowMargin) {
        _imageListRowMargin = kImageListDefaultRowMargin;
    }
    if (!_imageListColumnMargin) {
        _imageListColumnMargin = kImageListDefaultColumnMargin;
    }
    // 添加加号按钮
    [self creatAddButton];
    
    self.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)creatAddButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"icon_button_addImage"] forState:UIControlStateNormal];
    [self addSubview:button];
    
    [button addTarget:self action:@selector(addButtoClick) forControlEvents:UIControlEventTouchUpInside];
    _addButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.frame = self.frame;
    // 重新布局
    [self layoutImageListViewSubViews];
}

// 往容器添加一张图片
- (void)addImage:(UIImage *)image
{
    HMImageViewContainerView *imageViewContainerView = [self makeImageViewContainerView:image];
    [_imageViews addObject:imageViewContainerView];
    [self addSubview:imageViewContainerView];
    
    // 重新布局
    [self layoutImageListViewSubViews];
    
    if([self.delegate respondsToSelector:@selector(didChangeWithContainerListView:images:action:)]){
        [self.delegate didChangeWithContainerListView:self images:@[image] action:HMContainerListViewChangeActionAdd];
    }

}

- (void)addImages:(NSArray<UIImage *> *)images
{
    for (UIImage *image in images) {
        HMImageViewContainerView *imageViewContainerView = [self makeImageViewContainerView:image];
        [_imageViews addObject:imageViewContainerView];
        [self addSubview:imageViewContainerView];
    }
    
    // 重新布局
    [self layoutImageListViewSubViews];
    
    if([self.delegate respondsToSelector:@selector(didChangeWithContainerListView:images:action:)]){
        [self.delegate didChangeWithContainerListView:self images:images action:HMContainerListViewChangeActionAdd];
    }
    
}

- (void)insetImage:(UIImage *)image atIndex:(NSUInteger)index
{
    index += kImageListOtherImageCount;
    HMImageViewContainerView *imageViewContainerView = [self makeImageViewContainerView:image];
    [_imageViews insertObject:imageViewContainerView atIndex:0];
    
    [self insertSubview:imageViewContainerView atIndex:index];
    
    // 重新布局
    [self layoutImageListViewSubViews];
    
    if([self.delegate respondsToSelector:@selector(didChangeWithContainerListView:images:action:)]){
        [self.delegate didChangeWithContainerListView:self images:@[image] action:HMContainerListViewChangeActionAdd];
    }
    
}

- (void)insetImages:(nonnull NSArray<UIImage *> *)images atIndex:(NSUInteger)index
{
    index += kImageListOtherImageCount;
    
    for (UIImage *image in images) {
        HMImageViewContainerView *imageViewContainerView = [self makeImageViewContainerView:image];
        [_imageViews insertObject:imageViewContainerView atIndex:0];
        [self insertSubview:imageViewContainerView atIndex:index];
    }
   
    // 重新布局
    [self layoutImageListViewSubViews];
    
    if([self.delegate respondsToSelector:@selector(didChangeWithContainerListView:images:action:)]){
        [self.delegate didChangeWithContainerListView:self images:images action:HMContainerListViewChangeActionAdd];
    }
}

- (void)deleteImageFromIndex:(NSUInteger)index
{
    HMImageViewContainerView *imageView = [_imageViews objectAtIndex:index];
    [imageView removeFromSuperview];
    [_imageViews removeObject:imageView];
    
    // 重新布局
    [self layoutImageListViewSubViews];
    
    if([self.delegate respondsToSelector:@selector(didChangeWithContainerListView:images:action:)]){
        [self.delegate didChangeWithContainerListView:self images:@[imageView.image] action:HMContainerListViewChangeActionDelete];
    }
}

- (void)deleteCheckedImages
{
    [_checkedImageViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_imageViews removeObjectsInArray:_checkedImageViews];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (HMImageViewContainerView *imgView in _imageViews) {
        [arr addObject:imgView.image];
    }
    
    // 重新布局
    [self layoutImageListViewSubViews];
    
    if([self.delegate respondsToSelector:@selector(didChangeWithContainerListView:images:action:)]){
        [self.delegate didChangeWithContainerListView:self images:arr action:HMContainerListViewChangeActionDelete];
    }

}
#pragma mark - <HMImageViewContainerViewDelegate>
// 点击图片
- (void)clickImageViewContainerView:(HMImageViewContainerView *)imageViewContainerView
{
    if (_mode == HMContainerListViewModeCheck) {
        
        imageViewContainerView.type = imageViewContainerView.type == HMImageViewContainerViewTypeChecked ? HMImageViewContainerViewTypeNormal : HMImageViewContainerViewTypeChecked;
        
        if (imageViewContainerView.type == HMImageViewContainerViewTypeNormal) {
            [_checkedImageViews removeObject:imageViewContainerView];
        }else{
            if (![_checkedImageViews containsObject:imageViewContainerView]) {
                [_checkedImageViews addObject:imageViewContainerView];
            }
        }
        
    }else {
        if ([self.delegate respondsToSelector:@selector(shouldShowPreviewWithContainerListView:image:index:)]) {
            if (![self.delegate shouldShowPreviewWithContainerListView:self image:imageViewContainerView.image index:[_imageViews indexOfObject:imageViewContainerView]]) {
                return;
            }
        }
        
        // 打开图片
        [self showPreviewWithimageViewContainerView:imageViewContainerView];
    }
}

// 长按
- (void)longPressImageViewContainerView:(HMImageViewContainerView *)imageViewContainerView
{
    _activeImageView = imageViewContainerView;
    
    UIActionSheet *deleteSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除照片" otherButtonTitles:nil, nil];
    [deleteSheet showInView:[UIApplication sharedApplication].keyWindow];
}

// 点击删除按钮
- (void)deleteImageViewContainerView:(HMImageViewContainerView *)imageViewContainerView
{
    [_imageViews removeObject:imageViewContainerView];
    
    // 重新布局
    [self layoutImageListViewSubViews];
    
    if([self.delegate respondsToSelector:@selector(didChangeWithContainerListView:images:action:)]){
        [self.delegate didChangeWithContainerListView:self images:@[imageViewContainerView.image] action:HMContainerListViewChangeActionDelete];
    }
}

#pragma mark - <UIActionSheetDelegate>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3)
{
    if(_addSheet == actionSheet){
        UIImagePickerController *pickerImageVC = [[UIImagePickerController alloc] init];
        pickerImageVC.view.backgroundColor = [UIColor whiteColor];
        pickerImageVC.delegate = self;
        pickerImageVC.allowsEditing = NO;//设置可编辑
        
        if (buttonIndex == 0) {
            
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                pickerImageVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//                pickerImageVC.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImageVC.sourceType];
                // 只允许选择图片
                pickerImageVC.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
            }
            [pickerImageVC setTitle:@"相册"];
            [[HMUserInterfaceTool topViewController] presentViewController:pickerImageVC animated:YES completion:nil];
            
        }else if(buttonIndex == 1){
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            pickerImageVC.sourceType = sourceType;
            [[HMUserInterfaceTool topViewController] presentViewController:pickerImageVC animated:YES completion:nil];
        }

    }else{
        if (buttonIndex == 0) {
            
            [_activeImageView removeFromSuperview];
            [_imageViews removeObject:_activeImageView];
            
            // 重新布局
            [self layoutImageListViewSubViews];
        }
    }
    
}

#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //当选择的类型是图片
    if (!image){
        [[HMUserInterfaceTool topViewController] dismissViewControllerAnimated:YES completion:nil];
        return;
    }

    __weak typeof(self) weakSelf = self;
    [[HMUserInterfaceTool topViewController] dismissViewControllerAnimated:YES completion:^{
        if ([weakSelf.delegate respondsToSelector:@selector(containerListView:didFinishPickingImages:)]) {
            [weakSelf.delegate containerListView:weakSelf didFinishPickingImages:@[image]];
        }
    }];
    
}
#pragma mark - Event
- (void)addButtoClick
{
    if([self.delegate respondsToSelector:@selector(didClickAddButtonWithContainerListView:)]){
        [self.delegate didClickAddButtonWithContainerListView:self];
        return;
    }
    
    UIActionSheet *addSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从照片中选择",@"拍照", nil];
    [addSheet showInView:[UIApplication sharedApplication].keyWindow];
    _addSheet = addSheet;
}

#pragma mark - Private
- (HMImageViewContainerView *)makeImageViewContainerView:(UIImage *)image
{
    // 创建图片显示控件
    HMImageViewContainerView *imageViewContainerView = [HMImageViewContainerView viewFromXib];
    imageViewContainerView.delegate = self;
    imageViewContainerView.contentMode = self.contentMode;
    
    //[image thumbnailWithImageWithSize:CGSizeMake(480, 480)];
    imageViewContainerView.image = image;
    [imageViewContainerView setCoverAlpha:_coversAlpha];
    if(_mode == HMContainerListViewModeDelete){
        imageViewContainerView.type = HMImageViewContainerViewTypeDelete;
    }
    return imageViewContainerView;
}

// 重新布局
- (void)layoutImageListViewSubViews
{
    // 隐藏添加按钮
    if (self.subviews.count >= _imageListMaxCount + kImageListOtherImageCount) {
        [self insertSubview:_addButton atIndex:_imageListMaxCount];
        _addButton.hidden = YES;
    }
    
    // 重新显示添加按钮
    else if (self.subviews.count <= _imageListMaxCount) {
        [self insertSubview:_addButton atIndex:0];
        _addButton.hidden = NO;
    }
    
    // 减去0.5的误差
    CGFloat W = (self.width - _imageListColumnMargin * (_imageListMaxColumn - 1)) / _imageListMaxColumn - 0.5;
    [UIView animateWithDuration:kImageListDefaultAnimateDuration animations:^{
        
        UIView *view = nil;
        for (int i = 0; i< self.subviews.count; i++) {
            view = self.subviews[i];
            
            view.frame = CGRectMake(0, 0, W, W);
            
            // 设置位置
            if (i == 0) { // 最前面的
                view.x = 0;
                view.y = 0;
            } else { // 其他的
                UIView *lastImageView = self.subviews[i - 1];
                // 计算当前行左边的宽度
                CGFloat leftWidth = CGRectGetMaxX(lastImageView.frame) + _imageListColumnMargin;
                // 计算当前行右边的宽度
                CGFloat rightWidth = self.width - leftWidth;
                if (rightWidth >= W ) { // 按钮显示在当前行
                    view.y = lastImageView.y;
                    view.x = leftWidth;
                } else { // 按钮显示在下一行
                    view.x = 0;
                    view.y = CGRectGetMaxY(lastImageView.frame) + _imageListRowMargin;
                }
            }
        }
        
    }];
    
}

// 展示在图片浏览器
- (void)showPreviewWithimageViewContainerView:(HMImageViewContainerView *)imageViewContainerView
{
    if (imageViewContainerView.image) { // 展示图片
        
        JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
        
        imageInfo.image = imageViewContainerView.image;
        imageInfo.referenceRect = imageViewContainerView.frame;
        imageInfo.referenceView = imageViewContainerView.superview;
        imageInfo.referenceContentMode = imageViewContainerView.contentMode;
        
        imageInfo.referenceCornerRadius = imageViewContainerView.layer.cornerRadius;
        
        // Setup view controller
        JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                               initWithImageInfo:imageInfo
                                               mode:JTSImageViewControllerMode_Image
                                               backgroundStyle:JTSImageViewControllerBackgroundOption_Blurred];
        // Present the view controller.
        [imageViewer showFromViewController:[HMUserInterfaceTool topViewController] transition:JTSImageViewControllerTransition_FromOriginalPosition];
        
    }
}

#pragma mark - setter/getter
- (NSArray<UIImage *> *)images
{
    NSMutableArray *images = [NSMutableArray array];
    for (HMImageViewContainerView *imageView in _imageViews) {
        [images addObject:imageView.image];
    }
    return images;
}
- (NSMutableArray<UIImage *> *)checkedImages
{
    NSMutableArray *images = [NSMutableArray array];
    for (HMImageViewContainerView *imageView in _checkedImageViews) {
        [images addObject:imageView.image];
    }
    return images;
}

- (CGSize)imageSize
{
    return self.addButton.size;
}

- (void)setMode:(HMContainerListViewMode)mode
{
    _mode = mode;
    for (HMImageViewContainerView *imageView in _imageViews) {
        if (mode == HMContainerListViewModeDelete) {
            imageView.type = HMImageViewContainerViewTypeDelete;
        }else {
            imageView.type = HMImageViewContainerViewTypeNormal;
        }
    }
}
- (void)setCoversAlpha:(CGFloat)coversAlpha
{
    _coversAlpha = coversAlpha;
    for (HMImageViewContainerView *imageView in _imageViews) {
        imageView.coverAlpha = coversAlpha;
    }
}

@end
