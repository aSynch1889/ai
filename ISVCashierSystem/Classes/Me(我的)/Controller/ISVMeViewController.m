//
//  ISVMeViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/2.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "ISVMeViewController.h"
#import "systemSetupViewController.h"
@interface ISVMeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray* imageArray;
    NSArray* userInfoCenterArr;
}
@property (nonatomic, weak) UITableView* myTableView;
@end

@implementation ISVMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ISVBackgroundColor;
    [self.view addSubview:self.myTableView];
    [self setUp];
}

- (void)setUp {
    imageArray = @[@"about",@"feedback",@"sysSetup",@"share"];
    userInfoCenterArr = @[@"推荐给朋友",@"关于我们",@"反馈问题",@"系统设置"];
}

#pragma  mark tabelview 代理及数据源方法
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 2 || section == 3) {
        return 1;
    }else if (section == 1){
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 64;
    }
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellID = @"cellID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
//        cell.UITableViewCellStyle = UITableViewCellStyleSubtitle;
        
    }else if (indexPath.section == 1){
        cell.textLabel.text = userInfoCenterArr[indexPath.row];
        [cell.imageView setImage:[UIImage imageNamed:imageArray[indexPath.row]]];
    }else if (indexPath.section == 2){
        cell.textLabel.text = userInfoCenterArr.lastObject;
        [cell.imageView setImage:[UIImage imageNamed:imageArray.lastObject]];
        
    }else if (indexPath.section == 3){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = ISVMainlColor;
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld----",(long)indexPath.row);

    
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1){
            
            
            
        }else if (indexPath.row == 2){
            
            
            
        }else if (indexPath.row == 3){
            
        }
    }else if (indexPath.section == 2){
        systemSetupViewController *sysVC = [[systemSetupViewController alloc]init];
        [self.navigationController pushViewController:sysVC animated:YES];
    }

}

#pragma mark - 懒加载
- (UITableView *)myTableView{
    if (_myTableView == nil) {
        
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
        _myTableView = tableview;
    }
    return _myTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
