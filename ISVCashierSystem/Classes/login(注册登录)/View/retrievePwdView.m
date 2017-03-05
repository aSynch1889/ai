//
//  retrievePwdView.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/5.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "retrievePwdView.h"

@implementation retrievePwdView

- (void)viewInit {
    _phoneField = [[ISVTextField alloc]init];
    [self addSubview:_phoneField];
    [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarHeight + 10);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@44);
    }];
    _phoneField.placeholder = @"请输入手机号码";
    _phoneField.backgroundColor = [UIColor whiteColor];
    _phoneField.layer.cornerRadius = 4;
    _phoneField.layer.masksToBounds = YES;
    _phoneField.returnKeyType = UIReturnKeyNext;
    _phoneField.keyboardType = UIKeyboardTypeASCIICapable;
    _phoneField.delegate = self;
    
    [_phoneField setLeftViewWithImage:@"pwd"];
    
    _verField = [[ISVTextField alloc]init];
    [self addSubview:_verField];
    [_verField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneField.mas_bottom).offset(10);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(@44);
    }];
    _verField.placeholder = @"请输入验证码";
    _verField.backgroundColor = [UIColor whiteColor];
    _verField.layer.cornerRadius = 4;
    _verField.layer.masksToBounds = YES;
    _verField.returnKeyType = UIReturnKeyNext;
    _verField.keyboardType = UIKeyboardTypeASCIICapable;
    _verField.delegate = self;
    [_verField setLeftViewWithImage:@"pwd"];
    
    _verBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _verBtn.frame = CGRectMake(0, 0, 88, 30);
    [_verBtn setTitle:@"验证码" forState:UIControlStateNormal];
    _verBtn.backgroundColor = ISVTextColor;
    _verBtn.titleLabel.font = ISVFontSize(14);
    _verBtn.layer.cornerRadius =4;
    _verBtn.clipsToBounds = YES;
    UIView *rView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [rView addSubview:_verBtn];
    _verField.rightView = rView;
    _verField.rightViewMode = UITextFieldViewModeAlways;

    
    _pwdField = [[ISVTextField alloc]init];
    [self addSubview:_pwdField];
    [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_verField.mas_bottom).offset(10);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@44);
    }];
    _pwdField.placeholder = @"请输入密码";
    _pwdField.backgroundColor = [UIColor whiteColor];
    _pwdField.layer.cornerRadius = 4;
    _pwdField.layer.masksToBounds = YES;
    _pwdField.returnKeyType = UIReturnKeyNext;
    _pwdField.keyboardType = UIKeyboardTypeASCIICapable;
    _pwdField.delegate = self;
    [_pwdField setLeftViewWithImage:@"pwd"];
    
    _confirmPwdField = [[ISVTextField alloc]init];
    [self addSubview:_confirmPwdField];
    [_confirmPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdField.mas_bottom).offset(10);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@44);
    }];
    _confirmPwdField.placeholder = @"再次输入密码";
    _confirmPwdField.backgroundColor = [UIColor whiteColor];
    _confirmPwdField.layer.cornerRadius = 4;
    _confirmPwdField.layer.masksToBounds = YES;
    _confirmPwdField.returnKeyType = UIReturnKeyDone;
    _confirmPwdField.keyboardType = UIKeyboardTypeASCIICapable;
    _confirmPwdField.delegate = self;
    [_confirmPwdField setLeftViewWithImage:@"confirmPwd"];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _phoneField) {
        [_phoneField resignFirstResponder];
        [_verField becomeFirstResponder];
    }else if (textField == _verField){
        [_verField resignFirstResponder];
        [_pwdField becomeFirstResponder];
    }else if (textField == _pwdField){
        [_pwdField resignFirstResponder];
        [_confirmPwdField becomeFirstResponder];
    }else if (textField == _confirmPwdField){
        [_confirmPwdField resignFirstResponder];
        
    }
    return YES;
}

@end
