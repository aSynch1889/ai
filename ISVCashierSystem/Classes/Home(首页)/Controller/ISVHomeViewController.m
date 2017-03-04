//
//  ISVHomeViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/2.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "ISVHomeViewController.h"
#import "UIButton+ISVExt.h"
#import "scanCodeViewController.h"
#import "salesAnalysisViewController.h"
#import "addMemberViewController.h"
#import "memberManagerViewController.h"
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

- (void)collectionBtnClick {
    scanCodeViewController* scanCodeVC = [[scanCodeViewController alloc]init];
    [self .navigationController pushViewController:scanCodeVC animated:YES];
}

/**
    智能分析
 */
- (void)aiBtnClick {
    salesAnalysisViewController *saVC = [[salesAnalysisViewController alloc]init];
    [self.navigationController pushViewController:saVC animated:YES];
    
}

/**
    新增会员
 */
- (void)addMemberBtnClick {
    addMemberViewController *addMemVC = [[addMemberViewController alloc]init];
    [self.navigationController pushViewController:addMemVC animated:YES];
}

/**
    会员管理
 */
- (void)memberManagerBtnClick {
    memberManagerViewController *memMangerVC = [[memberManagerViewController alloc]init];
    [self.navigationController pushViewController:memMangerVC animated:YES];
    
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
    [self.collectionBtn setImage:[UIImage imageNamed:@"collectionButton"] forState:UIControlStateNormal];
    [self.collectionBtn adjustButtonImageTopAndTitleBottom];
    [self.collectionBtn addTarget:self action:@selector(collectionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    self.aiBtn.showsTouchWhenHighlighted = YES;
    [self.aiBtn setTitleColor:ISVMainlColor forState:UIControlStateNormal];
    [self.aiBtn adjustButtonImageTopAndTitleBottom];
    [self.aiBtn addTarget:self action:@selector(aiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    [self.addMemberBtn adjustButtonImageRightAndTitleLeft];
    self.addMemberBtn.showsTouchWhenHighlighted = YES;
    [self.addMemberBtn setTitleColor:ISVMainlColor forState:UIControlStateNormal];
    [self.addMemberBtn addTarget:self action:@selector(addMemberBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
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
    self.memberManagerBtn.showsTouchWhenHighlighted = YES;
    [self.memberManagerBtn adjustButtonImageRightAndTitleLeft];
    
    [self.memberManagerBtn setTitleColor:ISVMainlColor forState:UIControlStateNormal];
    [self.memberManagerBtn addTarget:self action:@selector(memberManagerBtnClick) forControlEvents:UIControlEventTouchUpInside];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
