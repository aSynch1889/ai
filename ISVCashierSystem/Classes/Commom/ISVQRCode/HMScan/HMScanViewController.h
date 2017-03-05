//
//  HMScanViewController.h
//  HealthMall
//
//  Created by johnWu on 15/11/12.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMScanViewController : UIViewController
/**
 *  扫描后的回调
 */
@property (nonatomic, copy) void(^completeBlock)(NSString *resultValue);

/**
 *  停止扫描
 */
- (void)stopScan;

@end
