//
//  collectionCodeViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/8.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "collectionCodeViewController.h"
#import "UIView+ISVRoundedCorners.h"
#import "setAmountViewController.h"
#import "collectionCodeView.h"
#import "UINavigationBar+ISVExtension.h"
@interface collectionCodeViewController ()
@property(nonatomic, copy)collectionCodeView *aView;
@end

@implementation collectionCodeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar ISV_setBackgroundColor:ISVMainColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar ISV_reset];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扫描二维/条形码";
    self.view.backgroundColor = ISVMainColor;
    
    _aView = [[collectionCodeView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    
    [_aView viewInit];
    
    [_aView.setAmountBtn addTarget:self action:@selector(setAmountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_aView];
    
    [self.navigationController.navigationBar ISV_setBackgroundColor:ISVMainColor];
    
}

- (void)setAmountBtnClick {
    NSLog(@"点击了设置金额按钮");
    setAmountViewController *setVC = [[setAmountViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
