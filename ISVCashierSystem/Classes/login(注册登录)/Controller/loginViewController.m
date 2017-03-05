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
#import "UINavigationBar+ISVExtension.h"
@interface loginViewController ()
@property (nonatomic, strong) loginView *aView;  //实例化一个VView的对象
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //登录页面
//    self.title = @"登录";
    _aView = [[loginView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [_aView viewInit];
    [_aView.regBtn addTarget:self action:@selector(userRegister) forControlEvents:UIControlEventTouchUpInside];
    [_aView.forgetPwdBtn addTarget:self action:@selector(retrievePwd) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_aView];
    
    [self.navigationController.navigationBar ISV_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.tintColor = kColorBlackPercent60;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorBlackPercent60}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"X" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
}

- (void)rightClick {
    NSLog(@"关闭登录");
    __weak typeof(self) weakSelf = self;
    [weakSelf dismissViewControllerAnimated:YES completion:^{
        
    }];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_aView.phoneField resignFirstResponder];
    [_aView.pwdField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

