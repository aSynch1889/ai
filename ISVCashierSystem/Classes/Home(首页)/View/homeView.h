//
//  homeView.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeView : UIView
@property(nonatomic, strong)UIButton *collectionBtn;//收款码
@property(nonatomic, strong)UIButton *scanBtn;//扫一扫
@property(nonatomic, strong)UIButton *aiBtn;//智能分析
@property(nonatomic, strong)UIButton *addMemberBtn;//新增会员
@property(nonatomic, strong)UIButton *memberManagerBtn;//会员管理
@property(nonatomic, strong)UIView *dataView;//!< 中间数据
- (void)viewInit;

@end
