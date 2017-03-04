//
//  registerViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "registerViewController.h"
#import "registerView.h"
@interface registerViewController ()
@property (nonatomic, strong) registerView *aView;  //实例化一个VView的对象
@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    //注册页面
    _aView = [[registerView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];  //初始化时一定要设置frame，否则VView上的两个按钮将无法被点击
    
    [_aView viewInit];
    
    
    [self.view addSubview:_aView];
    
    
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
