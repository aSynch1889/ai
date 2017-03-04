//
//  scanCodeViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/3.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "scanCodeViewController.h"
#import "UIView+ISVRoundedCorners.h"

@interface scanCodeViewController ()

@end

@implementation scanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扫描二维码/条形码";
    self.view.backgroundColor = ISVMainlColor;
    [self setUp];
    
}

- (void)setUp{
    UIView *bgView = [[UIView alloc]init];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(kNavBarHeight + 10);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(@350);
    }];
    bgView.backgroundColor = [UIColor whiteColor];
//    [bgView setRoundedCorners:UIRectCornerAllCorners radius:1];
    
    UIButton *titleBtn = [[UIButton alloc]init];
    [bgView addSubview:titleBtn];
    [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(bgView.mas_width);
        make.height.mas_equalTo(@64);
    }];
    [titleBtn setTitle:@"我要收款" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"titleBtn"] forState:UIControlStateNormal];
    [titleBtn setTitleColor:ISVMainlColor forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
