//
//  changePwdView.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changePwdView : UIView

@property(nonatomic, strong)UITextField *oldPwdField;//!<  旧密码
@property(nonatomic, strong)UITextField *pwdField;//!<  新密码
@property(nonatomic, strong)UITextField *confirmPwdField;//!<  再次输入新密码

- (void)viewInit;

@end
