//
//  ISVHomeViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/2.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "ISVHomeViewController.h"

@interface ISVHomeViewController ()
@property(nonatomic, strong)UIButton *collectionButton;//收款码
@property(nonatomic, strong)UIButton *scanButton;//扫一扫
@property(nonatomic, strong)UILabel *collectionLabel;//收款码
@property(nonatomic, strong)UIButton *scanLabel;//扫一扫

@end

@implementation ISVHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    // Called when the view is about to made visible. Default does nothing

    [super viewWillAppear:animated];



}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kSCREEN_WIDTH, 100)];
    bgView.backgroundColor = ISVMainlColor;
    [self.view addSubview:bgView];
    
    self.collectionButton = [[UIButton alloc]init];
    [bgView addSubview:self.collectionButton];
    [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@2.5);
        make.left.mas_equalTo(@10);
        make.width.mas_equalTo(@85);
        make.height.mas_equalTo(@60);
    }];
    [self.collectionButton setTitle:@"收款码" forState:UIControlStateNormal];

    [self.collectionButton setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
    [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"collectionButton"] forState:UIControlStateNormal];
    
    self.scanButton = [[UIButton alloc]init];
    [bgView addSubview:self.scanButton];
    [self.scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@2.5);
        make.left.mas_equalTo(self.collectionButton.mas_right).offset(20);
        make.width.mas_equalTo(@85);
        make.height.mas_equalTo(@30);
    }];
    [self.scanButton setTitle:@"扫一扫" forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
