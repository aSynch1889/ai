//
//  registerView.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface registerView : UIView
@property (nonatomic, strong)UITextField *phoneField;//!<  手机号码输入框
@property (nonatomic, strong)UITextField *verField;//!< 验证码输入框
@property (nonatomic, strong)UIButton *verBtn;//!<  获取验证码按钮
@property (nonatomic, strong)UITextField *pwdField;//!< 密码输入框
@property (nonatomic, strong)UIButton  *regBtn;//!<  注册按钮

- (void)viewInit;

@end
