//
//  homeView.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "homeView.h"
#import "UIButton+ISVExt.h"

@implementation homeView


- (void)viewInit {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kSCREEN_WIDTH, 140)];
    bgView.backgroundColor = ISVMainColor;
    [self addSubview:bgView];
    
    self.collectionBtn = [[UIButton alloc]init];
    [bgView addSubview:self.collectionBtn];
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(@0);
        make.width.mas_equalTo(kSCREEN_WIDTH/2);
        make.height.mas_equalTo(@80);
    }];
    [self.collectionBtn setTitle:@"收款码" forState:UIControlStateNormal];
    [self.collectionBtn setImage:[UIImage imageNamed:@"collectionButton"] forState:UIControlStateNormal];
    [self.collectionBtn adjustButtonImageTopAndTitleBottom];
    
    
    self.scanBtn = [[UIButton alloc]init];
    [bgView addSubview:self.scanBtn];
    [self.scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.collectionBtn.mas_centerY);
        make.left.mas_equalTo(self.collectionBtn.mas_right).offset(0);
        make.width.mas_equalTo(kSCREEN_WIDTH/2);
        make.height.mas_equalTo(@80);
    }];
    [self.scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [self.scanBtn setImage:[UIImage imageNamed:@"scanButton"] forState:UIControlStateNormal];
    [self.scanBtn adjustButtonImageTopAndTitleBottom];
    
    
    
    _dataView = [[UIView alloc]init];
    [self addSubview:_dataView];
    [_dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).offset(-30);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@60);
    }];
    _dataView.backgroundColor = [UIColor whiteColor];
    
    self.aiBtn = [[UIButton alloc]init];
    [self addSubview:self.aiBtn];
    [self.aiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_dataView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(kSCREEN_WIDTH/2 - 1);
        make.height.mas_equalTo(@200);
    }];
    [self.aiBtn setTitle:@"智能分析" forState:UIControlStateNormal];
    [self.aiBtn setImage:[UIImage imageNamed:@"ai"] forState:UIControlStateNormal];
    self.aiBtn.backgroundColor = [UIColor whiteColor];
    self.aiBtn.showsTouchWhenHighlighted = YES;
    [self.aiBtn setTitleColor:ISVMainColor forState:UIControlStateNormal];
    [self.aiBtn adjustButtonImageTopAndTitleBottom];
    
    self.addMemberBtn = [[UIButton alloc]init];
    [self addSubview:self.addMemberBtn];
    [self.addMemberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.aiBtn.mas_top);
        make.right.mas_equalTo(self.mas_right);
        make.width.mas_equalTo(kSCREEN_WIDTH/2 - 1);
        make.height.mas_equalTo(@100);
    }];
    [self.addMemberBtn setTitle:@"新增会员" forState:UIControlStateNormal];
    [self.addMemberBtn setImage:[UIImage imageNamed:@"addMember"] forState:UIControlStateNormal];
    self.addMemberBtn.backgroundColor = [UIColor whiteColor];
    [self.addMemberBtn adjustButtonImageRightAndTitleLeft];
    self.addMemberBtn.showsTouchWhenHighlighted = YES;
    [self.addMemberBtn setTitleColor:ISVMainColor forState:UIControlStateNormal];
    
    self.memberManagerBtn = [[UIButton alloc]init];
    [self addSubview:self.memberManagerBtn];
    [self.memberManagerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addMemberBtn.mas_bottom).offset(1);
        make.right.mas_equalTo(self.mas_right);
        make.width.mas_equalTo(kSCREEN_WIDTH/2 - 1);
        make.height.mas_equalTo(@100);
    }];
    [self.memberManagerBtn setTitle:@"会员管理" forState:UIControlStateNormal];
    [self.memberManagerBtn setImage:[UIImage imageNamed:@"memberManager"] forState:UIControlStateNormal];
    self.memberManagerBtn.backgroundColor = [UIColor whiteColor];
    self.memberManagerBtn.showsTouchWhenHighlighted = YES;
    [self.memberManagerBtn adjustButtonImageRightAndTitleLeft];
    
    [self.memberManagerBtn setTitleColor:ISVMainColor forState:UIControlStateNormal];
    
}

@end
