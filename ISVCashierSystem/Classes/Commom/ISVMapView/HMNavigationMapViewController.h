//
//  HMNavigationMapViewController.h
//  HealthMall
//
//  Created by qiuwei on 15/12/27.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKTypes.h>

@interface HMNavigationMapViewController : UIViewController

@property (nonatomic, strong) BMKPlanNode *startNode;      // 来源位置（可不传，默认为当前位置）
@property (nonatomic, strong) BMKPlanNode *targetNode;     // 目标位置

@end


/* 使用的示例
 BMKPlanNode *start = [[BMKPlanNode alloc]init];
 start.cityName = @"广州市";
 //    start.name = @"宏太智慧谷";
 start.pt = CLLocationCoordinate2DMake(23.1, 112.1);
 
 BMKPlanNode *target = [[BMKPlanNode alloc]init];
 target.cityName = @"广州市";
 //    target.name = @"天鹿花园";
 target.pt = CLLocationCoordinate2DMake(23.5, 112.5);
 
 
 HMNavigationMapViewController *nVC= [[HMNavigationMapViewController alloc] init];
 //    nVC.startNode = start;
 nVC.targetNode = target;
 [self.navigationController pushViewController:nVC animated:YES];
 */