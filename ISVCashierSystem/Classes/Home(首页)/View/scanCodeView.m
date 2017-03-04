
//
//  scanCodeView.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "scanCodeView.h"

@implementation scanCodeView

- (void)viewInit {
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(kNavBarHeight + 10);
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(@350);
    }];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 8;
    bgView.layer.masksToBounds = YES;
    
    UIButton *titleBtn = [[UIButton alloc]init];
    [bgView addSubview:titleBtn];
    [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(bgView.mas_width);
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.height.mas_equalTo(@64);
    }];
    [titleBtn setTitle:@"我要收款" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"titleBtn"] forState:UIControlStateNormal];
    [titleBtn setTitleColor:ISVMainlColor forState:UIControlStateNormal];
    titleBtn.backgroundColor = ISVBackgroundColor;
    
    self.codeLabel = [[UILabel alloc]init];
    [bgView addSubview:self.codeLabel];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleBtn.mas_bottom).offset(20);
        make.width.mas_equalTo(bgView.mas_width);
        make.height.mas_equalTo(@22);
    }];
    self.codeLabel.text = @"3231 1221 4456 1123";
    self.codeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.codeImageView = [[UIImageView alloc]init];
    [bgView addSubview:self.codeImageView];
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeLabel.mas_bottom);
        make.width.mas_equalTo(bgView.mas_width);
        make.height.mas_equalTo(@44);
    }];
    [self.codeImageView setImage:[UIImage imageNamed:@"ai"]];
    
    self.scanCodeImgView = [[UIImageView alloc]init];
    [bgView addSubview:self.scanCodeImgView];
    [self.scanCodeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeImageView.mas_bottom);
        make.centerX.mas_equalTo(self.codeImageView.mas_centerX);
        make.width.mas_equalTo(@64);
        make.height.mas_equalTo(@64);
    }];
    [self.scanCodeImgView setImage:[UIImage imageNamed:@"ai"]];
    
    self.setAmountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.setAmountBtn];
    [self.setAmountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).offset(20);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@64);
    }];
    [self.setAmountBtn setTitle:@"设置金额" forState:UIControlStateNormal];
    self.setAmountBtn.backgroundColor = [UIColor whiteColor];
    self.setAmountBtn.layer.cornerRadius = 8;
    self.setAmountBtn.layer.masksToBounds = YES;
    [self.setAmountBtn setTitleColor:ISVMainlColor forState:UIControlStateNormal];

}

@end
