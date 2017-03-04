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
    self.oldPwdField = [[UITextField alloc]init];
    [self addSubview:self.oldPwdField];
    [self.oldPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarHeight + 22);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@10);
        make.height.mas_equalTo(@44);
        
    }];
    self.oldPwdField.placeholder = @"请输入旧密码";
    self.oldPwdField.backgroundColor = [UIColor whiteColor];
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    [leftImageView setImage:[UIImage imageNamed:@"pwd"]];
//    [self.oldPwdField.leftView addSubview:leftImageView];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 30)];
    [leftView addSubview:leftImageView];
    self.oldPwdField.leftView = leftView;
    self.oldPwdField.leftViewMode = UITextFieldViewModeAlways;
    
    self.pwdField = [[UITextField alloc]init];
    [self addSubview:self.pwdField];
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oldPwdField.mas_bottom).offset(10);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@10);
        make.height.mas_equalTo(@44);
        
    }];
    self.pwdField.placeholder = @"请输入新密码";
    self.pwdField.backgroundColor = [UIColor whiteColor];
    
    self.confirmPwdField = [[UITextField alloc]init];
    [self addSubview:self.confirmPwdField];
    [self.confirmPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdField.mas_bottom).offset(10);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@10);
        make.height.mas_equalTo(@44);
        
    }];
    self.confirmPwdField.placeholder = @"请再次输入密码";
    self.confirmPwdField.backgroundColor = [UIColor whiteColor];
    
}

@end
