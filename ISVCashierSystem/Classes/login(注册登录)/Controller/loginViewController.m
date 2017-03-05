//
//  loginViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "loginViewController.h"
#import "loginView.h"
#import "retrievePwdViewController.h"
#import "registerViewController.h"
@interface loginViewController ()
@property (nonatomic, strong) loginView *aView;  //实例化一个VView的对象
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //登录页面
    _aView = [[loginView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];  //初始化时一定要设置frame，否则VView上的两个按钮将无法被点击
    
    [_aView viewInit];
    [_aView.regBtn addTarget:self action:@selector(userRegister) forControlEvents:UIControlEventTouchUpInside];
    [_aView.forgetPwdBtn addTarget:self action:@selector(retrievePwd) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_aView];
}


/**
    用户注册
 */
- (void)userRegister {
    registerViewController *regVC = [[registerViewController alloc]init];
    [self.navigationController pushViewController:regVC animated:YES];
}

/**
    忘记密码
 */
- (void)retrievePwd {
    NSLog(@"忘记密码");
    retrievePwdViewController *retVC = [[retrievePwdViewController alloc]init];
    [self.navigationController pushViewController:retVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

