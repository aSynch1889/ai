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
    [self.collectionBtn setTitle:@"收款码" forState:UIControlStateNormal];
    [self.collectionBtn setImage:[UIImage imageNamed:@"collectionBtn"] forState:UIControlStateNormal];
    // 按钮图片和标题总高度
    CGFloat collTotalHeight = (self.collectionBtn.imageView.frame.size.height + self.collectionBtn.titleLabel.frame.size.height);
    
    // 设置按钮图片偏移
    [self.collectionBtn setImageEdgeInsets:UIEdgeInsetsMake(-(collTotalHeight - self.collectionBtn.imageView.frame.size.height), 0.0, 0.0, -self.collectionBtn.titleLabel.frame.size.width)];
    
    // 设置按钮标题偏移
    [self.collectionBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -self.collectionBtn.imageView.frame.size.width, -(collTotalHeight - self.collectionBtn.titleLabel.frame.size.height),0.0)];
    
    
    self.scanBtn = [[UIButton alloc]init];
    [bgView addSubview:self.scanBtn];
    [self.scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.collectionBtn.mas_centerY);
        make.left.mas_equalTo(self.collectionBtn.mas_right).offset(0);
        make.width.mas_equalTo(kSCREEN_WIDTH/2);
        make.height.mas_equalTo(@80);
    }];
    [self.collectionBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [self.scanBtn setImage:[UIImage imageNamed:@"scanBtn"] forState:UIControlStateNormal];
    
    // 按钮图片和标题总高度
    CGFloat scanTotalHeight = (self.scanBtn.imageView.frame.size.height + self.scanBtn.titleLabel.frame.size.height);
    
    // 设置按钮图片偏移
    [self.scanBtn setImageEdgeInsets:UIEdgeInsetsMake(-(scanTotalHeight - self.scanBtn.imageView.frame.size.height), 0.0, 0.0, -self.scanBtn.titleLabel.frame.size.width)];
    
    // 设置按钮标题偏移
    [self.scanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -self.scanBtn.imageView.frame.size.width, -(scanTotalHeight - self.scanBtn.titleLabel.frame.size.height),0.0)];
    
    
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
        make.width.mas_equalTo(kSCREEN_WIDTH/2 - 1);
        make.height.mas_equalTo(@200);
    }];
    [self.aiBtn setTitle:@"智能分析" forState:UIControlStateNormal];
    [self.aiBtn setImage:[UIImage imageNamed:@"ai"] forState:UIControlStateNormal];
    self.aiBtn.backgroundColor = [UIColor whiteColor];
    [self.aiBtn setTitleColor:ISVMainlColor forState:UIControlStateNormal];
    
    // 按钮图片和标题总高度
    CGFloat totalHeight = (self.aiBtn.imageView.frame.size.height + self.aiBtn.titleLabel.frame.size.height);
    
    // 设置按钮图片偏移
    [self.aiBtn setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - self.aiBtn.imageView.frame.size.height), 0.0, 0.0, -self.aiBtn.titleLabel.frame.size.width)];
    
    // 设置按钮标题偏移
    [self.aiBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -self.aiBtn.imageView.frame.size.width, -(totalHeight - self.aiBtn.titleLabel.frame.size.height),0.0)];
    
    
    self.addMemberBtn = [[UIButton alloc]init];
    [self.view addSubview:self.addMemberBtn];
    [self.addMemberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.aiBtn.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_equalTo(kSCREEN_WIDTH/2 - 1);
        make.height.mas_equalTo(@100);
    }];
    [self.addMemberBtn setTitle:@"新增会员" forState:UIControlStateNormal];
    [self.addMemberBtn setImage:[UIImage imageNamed:@"addMember"] forState:UIControlStateNormal];
    self.addMemberBtn.backgroundColor = [UIColor whiteColor];
    [self.addMemberBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.addMemberBtn.imageView.frame.size.width, 0, self.addMemberBtn.imageView.frame.size.width)];
    [self.addMemberBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.addMemberBtn.titleLabel.bounds.size.width, 0, -self.addMemberBtn.titleLabel.bounds.size.width)];
    [self.addMemberBtn setTitleColor:ISVMainlColor forState:UIControlStateNormal];

    
    self.memberManagerBtn = [[UIButton alloc]init];
    [self.view addSubview:self.memberManagerBtn];
    [self.memberManagerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addMemberBtn.mas_bottom).offset(1);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_equalTo(kSCREEN_WIDTH/2 - 1);
        make.height.mas_equalTo(@100);
    }];
    [self.memberManagerBtn setTitle:@"会员管理" forState:UIControlStateNormal];
    [self.memberManagerBtn setImage:[UIImage imageNamed:@"memberManager"] forState:UIControlStateNormal];
    self.memberManagerBtn.backgroundColor = [UIColor whiteColor];
    [self.memberManagerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.memberManagerBtn.imageView.frame.size.width, 0, self.memberManagerBtn.imageView.frame.size.width)];
    [self.memberManagerBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.memberManagerBtn.titleLabel.bounds.size.width, 0, -self.memberManagerBtn.titleLabel.bounds.size.width)];
    [self.memberManagerBtn setTitleColor:ISVMainlColor forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
