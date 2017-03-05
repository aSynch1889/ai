//
//  loginView.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "loginView.h"

@implementation loginView

- (void)viewInit{
    _phoneField = [[UITextField alloc]init];
    [self addSubview:_phoneField];
    [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarHeight + 10);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.height.mas_equalTo(@44);
    }];
    _phoneField.placeholder = @"请输入手机号码";
    
    _pwdField = [[UITextField alloc]init];
    [self addSubview:_pwdField];
    [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneField.mas_bottom).offset(10);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.height.mas_equalTo(@44);
    }];
    _pwdField.placeholder = @"请输入密码";
    
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdField.mas_bottom).offset(20);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@44);
    }];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.backgroundColor = ISVMainColor;
    
    
    _regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_regBtn];
    [_regBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_loginBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-110);
        make.height.mas_equalTo(@44);
    }];
    [_regBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_regBtn setTitleColor:ISVMainColor forState:UIControlStateNormal];
    
    _forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_forgetPwdBtn];
    [_forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_regBtn.mas_centerY);
        make.right.mas_equalTo(@-10);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@44);
    }];
    [_forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgetPwdBtn setTitleColor:ISVMainColor forState:UIControlStateNormal];
    
}
@end
