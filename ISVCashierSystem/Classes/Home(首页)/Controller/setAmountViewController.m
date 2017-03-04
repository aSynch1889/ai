//
//  setAmountViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "setAmountViewController.h"

@interface setAmountViewController ()
@property(nonatomic, strong)UILabel *titleLabel;//!<收款金额
@property(nonatomic, strong)UITextField *inputField;//!<输入框
@property(nonatomic, strong)UIButton *confirmBtn;//!<下一步按钮
@end

@implementation setAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置金额";
    self.view.backgroundColor = ISVBackgroundColor;
    
    [self setUpUI];
}

- (void)setUpUI {
    UIView *bgView = [[UIView alloc]init];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(kNavBarHeight + 10);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(@350);
    }];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    
    self.titleLabel = [[UILabel alloc]init];
    [bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_top);
        make.left.mas_equalTo(bgView.mas_left);
        make.width.mas_equalTo(bgView.mas_width);
        make.height.mas_equalTo(@22);
    }];
    self.titleLabel.text = @"收款金额";
    
    self.inputField = [[UITextField alloc]init];
    [bgView addSubview:self.inputField];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.titleLabel.center);
        make.width.mas_equalTo(self.titleLabel.mas_width);
        make.height.mas_equalTo(@44);
    }];
//    self.inputField.borderStyle = UITextBorderStyleLine;
    self.inputField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputField.mas_bottom).offset(10);
        make.left.mas_equalTo(bgView.mas_left).offset(10);
        make.right.mas_equalTo(bgView.mas_right).offset(-10);
        make.height.mas_equalTo(@44);
    }];
    [self.confirmBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:ISVMainlColor];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
