//
//  setAmoutView.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/5.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "setAmoutView.h"

@implementation setAmoutView

- (void)viewInit {
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(kNavBarHeight + 10);
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(@200);
    }];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    
    self.titleLabel = [[UILabel alloc]init];
    [bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@10);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@22);
    }];
    self.titleLabel.text = @"收款金额";
    self.titleLabel.font = ISVFontSize(14);
    
    self.unitLabel = [[UILabel alloc]init];
    [bgView addSubview:self.unitLabel];
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.titleLabel.center);
        make.width.mas_equalTo(self.titleLabel.mas_width);
        make.height.mas_equalTo(@22);
    }];
    self.unitLabel.text = @"￥";
    
    self.inputField = [[UITextField alloc]init];
    [bgView addSubview:self.inputField];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.unitLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.titleLabel.center);
        make.width.mas_equalTo(self.titleLabel.mas_width);
        make.height.mas_equalTo(@44);
    }];
    self.inputField.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *lineView = [[UIView alloc]init];
    [self.inputField addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputField.mas_bottom).offset(-1);
        make.width.mas_equalTo(self.inputField.mas_width);
        make.centerX.mas_equalTo(self.inputField.mas_centerX);
        make.height.mas_equalTo(1);
    }];
    lineView.backgroundColor = kDefaultLineColor;
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputField.mas_bottom).offset(20);
        make.left.mas_equalTo(bgView.mas_left).offset(10);
        make.right.mas_equalTo(bgView.mas_right).offset(-10);
        make.height.mas_equalTo(@44);
    }];
    self.confirmBtn.layer.cornerRadius = 4;
    self.confirmBtn.layer.masksToBounds = YES;
    [self.confirmBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:ISVMainColor];
    

    
}

@end
