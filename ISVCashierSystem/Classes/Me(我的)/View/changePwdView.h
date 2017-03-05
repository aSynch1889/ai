//
//  changePwdView.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISVTextField.h"
@interface changePwdView : UIView<UITextFieldDelegate>

@property(nonatomic, strong)ISVTextField *oldPwdField;//!<  旧密码
@property(nonatomic, strong)ISVTextField *pwdField;//!<  新密码
@property(nonatomic, strong)ISVTextField *confirmPwdField;//!<  再次输入新密码

- (void)viewInit;

@end
