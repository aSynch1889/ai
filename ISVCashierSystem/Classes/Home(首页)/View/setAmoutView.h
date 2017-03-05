//
//  setAmoutView.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/5.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setAmoutView : UIView
@property(nonatomic, strong)UILabel *titleLabel;//!<收款金额
@property(nonatomic, strong)UITextField *inputField;//!<输入框
@property(nonatomic, strong)UILabel *unitLabel;//!<  单位
@property(nonatomic, strong)UIButton *confirmBtn;//!<下一步按钮
- (void)viewInit;

@end
