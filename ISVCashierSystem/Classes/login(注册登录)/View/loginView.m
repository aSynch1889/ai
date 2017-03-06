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
    _iconView = [[UIImageView alloc]init];
    [self addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarHeight + 10);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(@88);
        make.height.mas_equalTo(@88);
    }];
    [_iconView setImage:[UIImage imageNamed:@"userIcon"]];
    [_iconView setContentMode:UIViewContentModeScaleAspectFill];
    
    _phoneField = [[ISVTextField alloc]init];
    [self addSubview:_phoneField];
    [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconView.mas_bottom).offset(10);
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(@-20);
        make.height.mas_equalTo(@44);
    }];
    _phoneField.placeholder = @"请输入手机号码";
    _phoneField.delegate = self;
    _phoneField.keyboardType = UIKeyboardTypeASCIICapable;
    _phoneField.returnKeyType = UIReturnKeyNext;
    _phoneField.font = ISVFontSize(14);
    [_phoneField setLeftViewWithImage:@"phone"];
    
    UIView *lineView = [[UIView alloc]init];
    [_phoneField addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(-1);
        make.width.mas_equalTo(self.phoneField.mas_width);
        make.centerX.mas_equalTo(self.phoneField.mas_centerX);
        make.height.mas_equalTo(1);
    }];
    lineView.backgroundColor = kDefaultLineColor;
    
    _pwdField = [[ISVTextField alloc]init];
    [self addSubview:_pwdField];
    [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneField.mas_bottom).offset(10);
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(@-20);
        make.height.mas_equalTo(@44);
    }];
    _pwdField.placeholder = @"请输入密码";
    _pwdField.delegate = self;
    _pwdField.keyboardType = UIKeyboardTypeASCIICapable;
    _pwdField.returnKeyType = UIReturnKeyDone;
    _pwdField.font = ISVFontSize(14);
    [_pwdField setLeftViewWithImage:@"pwd"];
    
    UIView *lineView2 = [[UIView alloc]init];
    [_pwdField addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdField.mas_bottom).offset(-1);
        make.width.mas_equalTo(_pwdField.mas_width);
        make.centerX.mas_equalTo(_pwdField.mas_centerX);
        make.height.mas_equalTo(1);
    }];
    lineView2.backgroundColor = kDefaultLineColor;
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdField.mas_bottom).offset(20);
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(@-20);
        make.height.mas_equalTo(@30);
    }];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.backgroundColor = ISVTextColor;
    _loginBtn.layer.cornerRadius =4;
    _loginBtn.clipsToBounds = YES;
    _loginBtn.titleLabel.font = ISVFontSize(14);
    
    _regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_regBtn];
    [_regBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_loginBtn.mas_bottom).offset(10);
//        make.centerX.mas_equalTo(_loginBtn.mas_centerX);
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(@-110);
        make.height.mas_equalTo(@44);
    }];
    [_regBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_regBtn setTitleColor:ISVMainColor forState:UIControlStateNormal];
    _regBtn.titleLabel.font = ISVFontSize(14);
    
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
    _forgetPwdBtn.titleLabel.font = ISVFontSize(12);
}

- (BOOL)textFieldShouldReturn:(ISVTextField *)textField{
    if (textField == _phoneField) {
        [_phoneField resignFirstResponder];
        [_pwdField becomeFirstResponder];
    }else if (textField == _pwdField){
        [_pwdField resignFirstResponder];
    }
    return YES;
}

@end
