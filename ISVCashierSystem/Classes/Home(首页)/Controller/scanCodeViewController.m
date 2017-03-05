//
//  scanCodeViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/3.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "scanCodeViewController.h"
#import "UIView+ISVRoundedCorners.h"
#import "setAmountViewController.h"
#import "scanCodeView.h"
@interface scanCodeViewController ()
@property(nonatomic, copy)scanCodeView *aView;
@end

@implementation scanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扫描二维/条形码";
    self.view.backgroundColor = ISVMainColor;
    
    _aView = [[scanCodeView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    
    [_aView viewInit];
    
    [_aView.setAmountBtn addTarget:self action:@selector(setAmountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_aView];
    
    
    
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
