//
//  changePwdViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "changePwdViewController.h"
#import "changePwdView.h"

@interface changePwdViewController ()
@property(nonatomic, strong)changePwdView *aView;
@end

@implementation changePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    self.view.backgroundColor = ISVBackgroundColor;
    _aView = [[changePwdView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    
    [_aView viewInit];
    [self.view addSubview:_aView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"confirmPwd"] style:0 target:self action:@selector(rightClick)];
}

/**
    提交修改
 */
- (void)rightClick {
    NSLog(@"提交修改");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_aView.oldPwdField resignFirstResponder];
    [_aView.pwdField resignFirstResponder];
    [_aView.confirmPwdField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
