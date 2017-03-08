//
//  ISVHomeDataView.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/8.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISVHomeDataView : UIView

@property (nonatomic, strong)UILabel *dayLabel;//!< 今日
@property (nonatomic, strong)UILabel *weekLabel;//!< 本周
@property (nonatomic, strong)UILabel *monthLabel;//!< 本月
@property (nonatomic, strong)UILabel *dayAmountLabel;//!< 今日收支
@property (nonatomic, strong)UILabel *weekAmountLabel;//!< 本周收支
@property (nonatomic, strong)UILabel *monthAmountLabel;//!< 本月收支

- (void)viewInit;

@end
