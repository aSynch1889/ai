//
//  changePwdView.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "changePwdView.h"

@implementation changePwdView

- (void)viewInit {
    _oldPwdField = [[ISVTextField alloc]init];
    [self addSubview:_oldPwdField];
    [_oldPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarHeight + 22);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@44);
        
    }];
    _oldPwdField.placeholder = @"请输入旧密码";
    _oldPwdField.backgroundColor = [UIColor whiteColor];
    _oldPwdField.layer.cornerRadius =4;
    _oldPwdField.clipsToBounds = YES;
    _oldPwdField.returnKeyType = UIReturnKeyNext;
    _oldPwdField.keyboardType = UIKeyboardTypeASCIICapable;
    _oldPwdField.delegate = self;
    
    [_oldPwdField setLeftViewWithImage:@"pwd"];


    _pwdField = [[ISVTextField alloc]init];
    [self addSubview:_pwdField];
    [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_oldPwdField.mas_bottom).offset(10);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@44);
        
    }];
    _pwdField.placeholder = @"请输入新密码";
    _pwdField.backgroundColor = [UIColor whiteColor];
    _pwdField.layer.cornerRadius =4;
    _pwdField.clipsToBounds = YES;
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
    _confirmPwdField.placeholder = @"请再次输入密码";
    _confirmPwdField.backgroundColor = [UIColor whiteColor];
    _confirmPwdField.layer.cornerRadius =4;
    _confirmPwdField.clipsToBounds = YES;
    _confirmPwdField.returnKeyType = UIReturnKeyDone;
    _confirmPwdField.keyboardType = UIKeyboardTypeASCIICapable;
    _confirmPwdField.delegate = self;
    [_confirmPwdField setLeftViewWithImage:@"confirmPwd"];
    
}

- (BOOL)textFieldShouldReturn:(ISVTextField *)textField{
    if (textField == _oldPwdField) {
        [_oldPwdField resignFirstResponder];
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
