//
//  HMImagePickerController.m
//  imgPicker
//
//  Created by qiuwei on 16/1/5.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "HMImagePickerController.h"
#import "HMAssetsGroupController.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define kImagePickerMaxCount 10

@interface HMImagePickerController ()
@property (nonatomic, strong) HMAssetsGroupController *assetsGroupVC;
@end

@implementation HMImagePickerController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init{
    
    if (self = [super initWithRootViewController:self.assetsGroupVC]) {

        self.maxCount = kImagePickerMaxCount;
        UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
        navBar.barTintColor = [UIColor colorWithRed:(51)/255.0 green:(199)/255.0 blue:(116)/255.0 alpha:(1)];
        navBar.tintColor = [UIColor whiteColor];
    }
    return self;
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    return  [self init];
}
- (HMAssetsGroupController *)assetsGroupVC
{
    if (_assetsGroupVC == nil) {
        HMAssetsGroupController *assetsGroupVC = [[HMAssetsGroupController alloc] init];
        assetsGroupVC.navigationItem.title = @"相册";

        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
        assetsGroupVC.navigationItem.leftBarButtonItem = cancelItem;
        _assetsGroupVC = assetsGroupVC;
    }
    return _assetsGroupVC;
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setMaxCount:(NSInteger)maxCount{
    _maxCount = maxCount;
    if (maxCount > 0) {
        self.assetsGroupVC.maxCount = maxCount;
    }
}

@end
