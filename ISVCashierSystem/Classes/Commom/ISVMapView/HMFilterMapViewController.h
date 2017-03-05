//
//  HMFilterMapViewController.h
//  HealthMall
//
//  Created by qiuwei on 15/12/27.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMPointAnnotation.h"

/**
 *  选址完成的回调
 *
 *  @param annotations 选中的多个地址
 *  @param Annotation  我的位置（定位到的地址，可能为空）
 */
typedef void(^filterMapCompleteBlock)(NSArray<HMPointAnnotation *> *annotations, HMPointAnnotation *myAnnotation);


@interface HMFilterMapViewController : UIViewController

@property (nonatomic, strong) NSMutableArray<HMPointAnnotation *> *annotations;
@property (nonatomic, copy) filterMapCompleteBlock completeBlock;

@property (nonatomic, assign) NSUInteger maxCount;   // 最多选择地址个数(默认1)
@property (nonatomic, assign) NSUInteger minCount;   // 最少选择地址个数(默认100)

@property (nonatomic, assign, getter=isSingleChoice) BOOL singleChoice; // 是否单选模式
@property (nonatomic, assign) BOOL justSelectFromAnnotations; // 是否只从大头针数组中选择
@property (nonatomic, assign) BOOL isShowMyAnnotation; // 是否显示我的位置的大头针

/**
 *  弹出PaopaoView的按钮标题
 */
- (void)setPaopaoViewButtonTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle;

@end


/*
 HMPointAnnotation *p1 = [[HMPointAnnotation alloc] init];
 p1.coordinate = CLLocationCoordinate2DMake(23.178, 113.4037);
 p1.title = @"智慧谷1";
 p1.subtitle = @"此Annotation可拖拽!";
 HMPointAnnotation *p2 = [[HMPointAnnotation alloc] init];
 p2.coordinate = CLLocationCoordinate2DMake(23.18249565, 113.4337);
 p2.title = @"智慧谷2";
 p2.subtitle = @"此Annotation可拖拽!";
 HMPointAnnotation *p3 = [[HMPointAnnotation alloc] init];
 p3.coordinate = CLLocationCoordinate2DMake(23.18549565, 113.4237);
 p3.title = @"智慧谷3";
 HMPointAnnotation *p4 = [[HMPointAnnotation alloc] init];
 p4.coordinate = CLLocationCoordinate2DMake(23.18549565, 113.4237);
 p4.title = @"智慧谷4";
 
 HMFilterMapViewController *filterVC = [[HMFilterMapViewController alloc] init];
 filterVC.annotations = [NSMutableArray arrayWithArray:@[p1, p2, p3, p4]];
 [self.navigationController pushViewController:filterVC animated:YES];
 */