//
//  collectionSuccessViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "collectionSuccessViewController.h"

@interface collectionSuccessViewController ()
@property(nonatomic, strong)UIImageView *titleImgView;//!<imageview
@property(nonatomic, strong)UILabel *statusLabel;//!<状态
@property(nonatomic, strong)UILabel *amountLabel;//!<金额
@end

@implementation collectionSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收款成功";
    
    
    
    
}

- (void)setUpUI {
    self.titleImgView = [[UIImageView alloc]init];
    [self.view addSubview:self.titleImgView];
    [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
