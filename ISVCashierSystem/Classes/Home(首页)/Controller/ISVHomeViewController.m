//
//  ISVHomeViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/2.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "ISVHomeViewController.h"

@interface ISVHomeViewController ()
@property(nonatomic, strong)UIButton *collectionBtn;//收款码
@property(nonatomic, strong)UIButton *scanBtn;//扫一扫
@property(nonatomic, strong)UILabel *collectionLabel;//收款码
@property(nonatomic, strong)UIButton *scanLabel;//扫一扫

@property(nonatomic, strong)UIButton *aiBtn;//智能分析
@property(nonatomic, strong)UIButton *addMemberBtn;//新增会员
@property(nonatomic, strong)UIButton *memberManagerBtn;//会员管理

@end

@implementation ISVHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    // Called when the view is about to made visible. Default does nothing

    [super viewWillAppear:animated];



}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColor:@"#eeedf3"];
    
    [self setUp];
    
    
}

- (void)setUp {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kSCREEN_WIDTH, 140)];
    bgView.backgroundColor = ISVMainlColor;
    [self.view addSubview:bgView];
    
    self.collectionBtn = [[UIButton alloc]init];
    [bgView addSubview:self.collectionBtn];
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.left.mas_equalTo(@0);
        make.width.mas_equalTo(kSCREEN_WIDTH/2);
        make.height.mas_equalTo(@80);
    }];
    [self.collectionBtn setImage:[UIImage imageNamed:@"collectionBtn"] forState:UIControlStateNormal];
    
    self.collectionLabel = [[UILabel alloc]init];
    [bgView addSubview:self.collectionLabel];
    [self.collectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionBtn.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.collectionBtn.mas_centerX);
        make.height.mas_equalTo(@22);
    }];
    self.collectionLabel.text = @"收款码";
    self.collectionLabel.font = ISVFontSize(14);
    
    
    self.scanBtn = [[UIButton alloc]init];
    [bgView addSubview:self.scanBtn];
    [self.scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.collectionBtn.mas_centerY);
        make.left.mas_equalTo(self.collectionBtn.mas_right).offset(0);
        make.width.mas_equalTo(kSCREEN_WIDTH/2);
        make.height.mas_equalTo(@80);
    }];
    [self.scanBtn setImage:[UIImage imageNamed:@"scanBtn"] forState:UIControlStateNormal];
    
    UIView *dataView = [[UIView alloc]init];
    [self.view addSubview:dataView];
    [dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).offset(-30);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(@-10);
        make.height.mas_equalTo(@60);
    }];
    dataView.backgroundColor = [UIColor whiteColor];
    
    self.aiBtn = [[UIButton alloc]init];
    [self.view addSubview:self.aiBtn];
    [self.aiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dataView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(kSCREEN_WIDTH/2);
        make.height.mas_equalTo(@200);
    }];
    [self.aiBtn setTitle:@"智能分析" forState:UIControlStateNormal];
    self.aiBtn.backgroundColor = ISVMainlColor;
    
    self.addMemberBtn = [[UIButton alloc]init];
    [self.view addSubview:self.addMemberBtn];
    [self.addMemberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.aiBtn.mas_top);
        make.left.mas_equalTo(self.aiBtn.mas_right).offset(1);
        make.width.mas_equalTo(kSCREEN_WIDTH/2);
        make.height.mas_equalTo(@100);
    }];
    [self.addMemberBtn setTitle:@"新增会员" forState:UIControlStateNormal];
    self.addMemberBtn.backgroundColor = ISVMainlColor;
    
    self.memberManagerBtn = [[UIButton alloc]init];
    [self.view addSubview:self.memberManagerBtn];
    [self.memberManagerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addMemberBtn.mas_bottom).offset(1);
        make.left.mas_equalTo(self.aiBtn.mas_right).offset(1);
        make.width.mas_equalTo(kSCREEN_WIDTH/2);
        make.height.mas_equalTo(@100);
    }];
    [self.memberManagerBtn setTitle:@"会员管理" forState:UIControlStateNormal];
    self.memberManagerBtn.backgroundColor = ISVMainlColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
