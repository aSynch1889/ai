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
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(@-20);
        make.height.mas_equalTo(@44);
    }];
    _phoneField.placeholder = @"请输入手机号码";
    _phoneField.keyboardType = UIKeyboardTypeASCIICapable;
    _phoneField.returnKeyType = UIReturnKeyNext;
    _phoneField.delegate = self;
    
    UIView *lineView = [[UIView alloc]init];
    [self.phoneField addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(-1);
        make.width.mas_equalTo(self.phoneField.mas_width);
        make.centerX.mas_equalTo(self.phoneField.mas_centerX);
        make.height.mas_equalTo(1);
    }];
    lineView.backgroundColor = kDefaultLineColor;
    
    _verField = [[UITextField alloc]init];
    [self addSubview:_verField];
    [_verField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneField.mas_bottom).offset(10);
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(@-20);
        make.height.mas_equalTo(@44);
    }];
    _verField.placeholder = @"请输入验证码";
    _verField.keyboardType = UIKeyboardTypeASCIICapable;
    _verField.returnKeyType = UIReturnKeyNext;
    _verField.delegate = self;
    
    UIView *lineView2 = [[UIView alloc]init];
    [_verField addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_verField.mas_bottom).offset(-1);
        make.width.mas_equalTo(_verField.mas_width);
        make.centerX.mas_equalTo(_verField.mas_centerX);
        make.height.mas_equalTo(1);
    }];
    lineView2.backgroundColor = kDefaultLineColor;
    
    
    _verBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _verBtn.frame = CGRectMake(0, 5, 88, 30);
    [_verBtn setTitle:@"验证码" forState:UIControlStateNormal];
    _verBtn.backgroundColor = ISVTextColor;
    _verBtn.titleLabel.font = ISVFontSize(14);
    _verBtn.layer.cornerRadius =4;
    _verBtn.clipsToBounds = YES;
    UIView *rView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 88, 30)];
    [rView addSubview:_verBtn];
    _verField.rightView = rView;
    _verField.rightViewMode = UITextFieldViewModeAlways;
    
    
    _pwdField = [[UITextField alloc]init];
    [self addSubview:_pwdField];
    [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_verField.mas_bottom).offset(10);
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(@-20);
        make.height.mas_equalTo(@44);
    }];
    _pwdField.placeholder = @"请输入密码";
    _pwdField.keyboardType = UIKeyboardTypeASCIICapable;
    _pwdField.returnKeyType = UIReturnKeyDone;
    _pwdField.delegate = self;
    UIView *lineView3 = [[UIView alloc]init];
    [_pwdField addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdField.mas_bottom).offset(-1);
        make.width.mas_equalTo(_pwdField.mas_width);
        make.centerX.mas_equalTo(_pwdField.mas_centerX);
        make.height.mas_equalTo(1);
    }];
    lineView3.backgroundColor = kDefaultLineColor;
    
    _regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_regBtn];
    [_regBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdField.mas_bottom).offset(40);
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(@-20);
        make.height.mas_equalTo(@30);
    }];
    [_regBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _regBtn.backgroundColor = ISVTextColor;
    _regBtn.layer.cornerRadius =4;
    _regBtn.clipsToBounds = YES;
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.phoneField) {
        [self.phoneField resignFirstResponder];
        [self.verField becomeFirstResponder];
    }else if (textField == self.verField){
        [self.verField resignFirstResponder];
        [self.pwdField becomeFirstResponder];
    }else if (textField == self.pwdField){
        [self.pwdField resignFirstResponder];
    }
    return YES;
}

@end
