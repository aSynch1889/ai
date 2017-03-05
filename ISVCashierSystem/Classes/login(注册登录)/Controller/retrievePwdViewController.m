//
//  retrievePwdViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/5.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "retrievePwdViewController.h"
#import "retrievePwdView.h"
@interface retrievePwdViewController ()
@property(nonatomic, strong)retrievePwdView *aView;
@end

@implementation retrievePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"找回密码";
    self.view.backgroundColor = ISVBackgroundColor;
    _aView = [[retrievePwdView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    
    [_aView viewInit];
    [_aView.verBtn addTarget:self action:@selector(getVerCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_aView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"checked"] style:0 target:self action:@selector(rightClick)];
    
}


- (void)rightClick {
    NSLog(@"确认");
}

/**
    获取验证码
 */
- (void)getVerCode {
    NSLog(@"获取验证码");
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
