//
//  retrievePwdView.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/5.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISVTextField.h"
@interface retrievePwdView : UIView<UITextFieldDelegate>
@property (nonatomic, strong)ISVTextField *phoneField;//!<  手机号码输入框
@property (nonatomic, strong)ISVTextField *verField;//!<  验证码输入框
@property (nonatomic, strong)UIButton  *verBtn;//!< 验证码获取
@property (nonatomic, strong)ISVTextField *pwdField;//!< 密码输入框
@property (nonatomic, strong)ISVTextField *confirmPwdField;//!< 再次输入密码

- (void)viewInit;

@end
