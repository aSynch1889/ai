//
//  loginView.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginView : UIView<UITextFieldDelegate>
@property (nonatomic, strong)UIImageView *iconView;//!<  头像
@property (nonatomic, strong)UITextField *phoneField;//!<  手机号码输入框
@property (nonatomic, strong)UITextField *pwdField;//!< 密码输入框
@property (nonatomic, strong)UIButton  *loginBtn;//!<  登录
@property (nonatomic, strong)UIButton  *regBtn;//!<  注册
@property (nonatomic, strong)UIButton  *forgetPwdBtn;//!< 忘记密码

- (void)viewInit;

@end
