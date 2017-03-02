//
//  ViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/2.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"导航";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44+20)];
    
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    
    //在这个集合Item中添加标题，按钮
    //style:设置按钮的风格，一共有三种选择
    //action：@selector:设置按钮的点击事件
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton)];
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"右边" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton)];
    
    //设置导航栏的内容
    [navItem setTitle:@"导航栏"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:YES];
    
    // 把左右两个按钮添加到导航栏集合中去
    [navItem setLeftBarButtonItem:leftButton];
    [navItem setRightBarButtonItem:rightButton];
    
    // 将导航栏中的内容全部添加到主视图当中
    [self.view addSubview:navBar];
    
    // 最后将控件在内存中释放掉，以避免内存泄露
    // [navItem release];
    // [leftButton release];
    // [rightButton release];
}


-(void) clickLeftButton
{
    [self showDialog:@"点击了导航栏左边按钮"];
}


-(void) clickRightButton
{
    [self showDialog:@"点击了导航栏右边按钮"];
}


-(void)showDialog:(NSString *)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    // [alert release];
}

//- (void)viewWillAppear:(BOOL)animated{
//    // Called when the view is about to made visible. Default does nothing
//    
//    [super viewWillAppear:animated];
//    
//    //去除导航栏下方的横线
//    
////    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[self colorFromHexRGB:@"33cccc"]]
////     
////                       forBarPosition:UIBarPositionAny
////     
////                           barMetrics:UIBarMetricsDefault];
////    
////    [navigationBar setShadowImage:[UIImage new]];
//    
//    
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
