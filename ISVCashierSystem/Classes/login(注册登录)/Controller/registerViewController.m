//
//  registerViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "registerViewController.h"
#import "registerView.h"
#import "UINavigationBar+ISVExtension.h"
@interface registerViewController ()
@property (nonatomic, strong) registerView *aView;  //实例化一个VView的对象
@end

@implementation registerViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar ISV_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar ISV_reset];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    //注册页面 modal 方式弹出
    _aView = [[registerView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [_aView.regBtn addTarget:self action:@selector(regBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_aView viewInit];
    [self.view addSubview:_aView];
    [self.navigationController.navigationBar ISV_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.tintColor = kColorBlackPercent60;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorBlackPercent60}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"X" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
}

- (void)rightClick {
    
}

/**
    提交注册
 */
- (void)regBtnClick {
    NSLog(@"提交注册");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_aView.phoneField resignFirstResponder];
    [_aView.pwdField resignFirstResponder];
    [_aView.verField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
