//
//  HMCheckViewController.h
//  HealthMall
//
//  Created by qiuwei on 15/12/22.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCheckView.h"

typedef void(^checkedsBlock)(NSArray<id<HMCheckPotocol>> *checks);

@interface HMCheckViewController : UIViewController

@property (nonatomic, weak) HMCheckView *checkView;
@property (nonatomic, copy) checkedsBlock checkedsBlock;
@property (nonatomic, assign) NSInteger Max;    // 最多选择多少项(默认为10000)
@property (nonatomic, assign) NSInteger Min;    // 最少选择多少项(默认为1)

@end
