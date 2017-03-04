//
//  systemSetupViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "systemSetupViewController.h"
#import "changePwdViewController.h"
@interface systemSetupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, weak)UITableView *sysTableView;
@property(nonatomic, strong)NSArray *nameArr;
@end

@implementation systemSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"系统设置";
    self.view.backgroundColor = ISVBackgroundColor;
    self.nameArr = @[@"修改密码",@"联系客服"];
    [self.view addSubview:self.sysTableView];
    
}
#pragma  mark tabelview 代理及数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellID = @"cellID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.nameArr[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        changePwdViewController *cVC = [[changePwdViewController alloc]init];
        [self.navigationController pushViewController:cVC animated:YES];
    }else if (indexPath.row == 1){
        //拨打客服电话
        
    }
}

#pragma mark - 懒加载
- (UITableView *)sysTableView{
    if (_sysTableView == nil) {
        
        CGFloat height = kSCREEN_HEIGHT+ 44;
        UITableView* tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, height) style:UITableViewStyleGrouped];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.showsVerticalScrollIndicator = NO;
        tableview.tableFooterView = [[UIView alloc]init];
        tableview.contentSize = CGSizeMake(0, height);
        tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableview setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [tableview setLayoutMargins:UIEdgeInsetsZero];
        }
        [self.view addSubview:tableview];
        _sysTableView = tableview;
    }
    return _sysTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
