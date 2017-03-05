//
//  registerView.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "registerView.h"

@implementation registerView

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
    
    _verField = [[UITextField alloc]init];
    [self addSubview:_verField];
    [_verField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneField.mas_bottom).offset(10);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.height.mas_equalTo(@44);
    }];
    _verField.placeholder = @"请输入验证码";
    
    _pwdField = [[UITextField alloc]init];
    [self addSubview:_pwdField];
    [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_verField.mas_bottom).offset(10);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.height.mas_equalTo(@44);
    }];
    _pwdField.placeholder = @"请输入密码";
    
    
    _regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_regBtn];
    [_regBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdField.mas_bottom).offset(40);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@44);
    }];
    [_regBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _regBtn.backgroundColor = ISVMainColor;
    
}
@end
