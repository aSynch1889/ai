//
//  ISVAssetsItemController.m
//  imgPicker
//
//  Created by aaaa on 16/1/5.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "ISVAssetsItemController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ISVAssetModel.h"
#import "ISVImagePickerController.h"

#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "ISVHUD.h"

#define kAssetItemSelectBtnWH 25
#define MARGIN 10
#define COL 4
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ISVAssetItemCell : UICollectionViewCell
@property (nonatomic,weak) UIButton *selectedButton;
@end

@implementation ISVAssetItemCell

@end



@interface ISVAssetsItemController ()
{
    BOOL _isFirstLoad;
}
@property (nonatomic, strong) NSMutableArray *assetModels;
@property (nonatomic, strong) NSMutableArray *selectedModels;//选中的模型

@end

@implementation ISVAssetsItemController

static NSString * const reuseIdentifier = @"ISVAssetItemCell";

- (void)dealloc
{
    self.assetModels = nil;
    self.selectedModels = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.assetModels = nil;
    self.selectedModels = nil;
}

//设置类型
- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = MARGIN;
    flowLayout.minimumInteritemSpacing = MARGIN;
    CGFloat cellHeight = (kScreenWidth - (COL + 1) * MARGIN) / COL;
    flowLayout.itemSize = CGSizeMake(cellHeight, cellHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [super initWithCollectionViewLayout:flowLayout];
}
- (void)setGroup:(ALAssetsGroup *)group{
    _group = group;
    
    __weak typeof(self) weakSelf = self;
    [group enumerateAssetsWithOptions:NSEnumerationConcurrent usingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        
//    [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset == nil) return ;
        if (![[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {//不是图片
            return;
        }
        ISVAssetModel *model = [[ISVAssetModel alloc] init];
        model.thumbnail = [UIImage imageWithCGImage:asset.thumbnail];
        model.imageURL = asset.defaultRepresentation.url;
        [weakSelf.assetModels addObject:model];
        model = nil;
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[ISVAssetItemCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //右侧完成按钮
    UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelecting)];
    self.navigationItem.rightBarButtonItem = finish;
    
    _isFirstLoad = YES;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    NSLog(@"%@",NSStringFromCGSize(self.collectionView.contentSize));
    // 滚到底部
    CGFloat h = self.collectionView.contentSize.height;
    if (h > 0) {
        if (_isFirstLoad) {
            if (self.collectionView.contentSize.height > self.collectionView.height) {
                [self.collectionView setContentOffset:CGPointMake(0, h - self.collectionView.height)];
            }
            _isFirstLoad = NO;
        }
    }
    
}

// 出口,选择完成图片
- (void)finishSelecting{
    
    if ([self.navigationController isKindOfClass:[ISVImagePickerController class]]) {
        
        ISVImagePickerController *picker = (ISVImagePickerController *)self.navigationController;
        if (picker.didFinishSelectImages) {
            
//            picker.didFinishSelectAssetModels(self.selectedModels);
            __weak typeof(picker) weakPicker = picker;
            NSMutableArray *arr = [NSMutableArray array];
            
            //获取原始图片可能是异步的,因此需要判断最后一个,然后传出
            for (int i = 0; i < self.selectedModels.count; i++) {
                
                __weak typeof(self) weakSelf = self;
                ISVAssetModel *model = self.selectedModels[i];
                [model originalImage:^(UIImage *image) {
                    [arr addObject:image];
                    image = nil;
                    if ( i == weakSelf.selectedModels.count - 1) {//最后一个
                        weakPicker.didFinishSelectImages([weakSelf.selectedModels valueForKeyPath:@"thumbnail"], arr);
                    }
                }];
                
            }
        }
    }
    
    //移除
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.assetModels.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ISVAssetItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ISVAssetModel *model = self.assetModels[indexPath.item];
    
    if (cell.backgroundView == nil) {//防止多次创建
        UIImageView *imageView = [[UIImageView alloc] init];
        cell.backgroundView = imageView;
    }
    UIImageView *backView = (UIImageView *)cell.backgroundView;
    backView.image = model.thumbnail;
    if (cell.selectedButton == nil) {//防止多次创建
        UIButton *selectButton = [[UIButton alloc] init];
        [selectButton setImage:[UIImage imageNamed:@"ISV_icon_ImageMark_normal"] forState:UIControlStateNormal];
        [selectButton setImage:[UIImage imageNamed:@"ISV_icon_ImageMark_seleted"] forState:UIControlStateSelected];
        CGFloat width = cell.bounds.size.width;
        selectButton.frame = CGRectMake(width - kAssetItemSelectBtnWH, 0, kAssetItemSelectBtnWH, kAssetItemSelectBtnWH);
        selectButton.contentMode = UIViewContentModeTopRight;
        [cell.contentView addSubview:selectButton];
        cell.selectedButton = selectButton;
        [selectButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.selectedButton.tag = indexPath.item;//重新绑定
    cell.selectedButton.selected = model.isSelected;//恢复设定状态
    return cell;
}
- (void)buttonClicked:(UIButton *)button
{
    button.selected = !button.selected;
    ISVAssetModel *model = self.assetModels[button.tag];
    
    if (button.selected) {
        
        if (self.selectedModels.count > self.maxCount) {
            [self.selectedModels removeObject:model];
            button.selected = NO;
            [ISVHUD showErrorWithStatus:[NSString stringWithFormat:@"不能超过%zd张", self.maxCount]];
        }else{
            [self.selectedModels addObject:model];
        }
    }else{
        [self.selectedModels removeObject:model];
    }
    
    model.isSelected = button.selected;
    
}
#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    ISVAssetModel *model = self.assetModels[indexPath.row];
    
    [model originalImage:^(UIImage *image) {
        
        JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
        
        imageInfo.image = image;
        imageInfo.referenceRect = cell.frame;
        imageInfo.referenceView = collectionView;
//        imageInfo.referenceContentMode = imageViewContainerView.contentMode;
        imageInfo.referenceCornerRadius = cell.layer.cornerRadius;
        
        // Setup view controller
        JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                               initWithImageInfo:imageInfo
                                               mode:JTSImageViewControllerMode_Image
                                               backgroundStyle:JTSImageViewControllerBackgroundOption_Blurred];
        // Present the view controller.
        [imageViewer showFromViewController:weakSelf transition:JTSImageViewControllerTransition_FromOriginalPosition];
    }];
    //    ISVImagePickerController *picker = (ISVImagePickerController *)self.navigationController;
    //    __weak typeof(picker) weakPicker = picker;
    //    ! weakPicker.didClickImage ? : weakPicker.didClickImage(image);
    
}

#pragma mark - setter/getter

- (NSMutableArray *)assetModels{
    if (_assetModels == nil) {
        _assetModels = [NSMutableArray array];
    }
    return _assetModels;
}

- (NSMutableArray *)selectedModels{
    if (_selectedModels == nil) {
        _selectedModels = [NSMutableArray array];
    }
    return _selectedModels;
}

@end
