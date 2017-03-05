//
//  ISVScanViewController.h
//  ISV
//
//  Created by johnWu on 15/11/12.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISVScanViewController : UIViewController
/**
 *  扫描后的回调
 */
@property (nonatomic, copy) void(^completeBlock)(NSString *resultValue);

/**
 *  停止扫描
 */
- (void)stopScan;

@end
