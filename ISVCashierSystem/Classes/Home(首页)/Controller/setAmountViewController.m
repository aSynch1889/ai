//
//  setAmountViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "setAmountViewController.h"
#import "setAmoutView.h"
@interface setAmountViewController ()
@property(nonatomic, strong)setAmoutView *aView;
@end

@implementation setAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置金额";
    self.view.backgroundColor = ISVBackgroundColor;
    
    _aView = [[setAmoutView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [_aView viewInit];
    [_aView.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_aView];
    
}

/**
    设置金额下一步
 */
- (void)confirmBtnClick {
    NSLog(@"下一步");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
