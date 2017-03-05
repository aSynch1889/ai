//
//  memberManagerViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "memberManagerViewController.h"
#import "memberManagerTableViewCell.h"
@interface memberManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView* dataTableView;

@end

@implementation memberManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"会员管理";
    self.view.backgroundColor = ISVBackgroundColor;
    [self.view addSubview:self.dataTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    memberManagerTableViewCell *cell = [memberManagerTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text = @"xiaowang";
    cell.amountLabel.text = @"+2000";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 懒加载
- (UITableView *)dataTableView{
    if (_dataTableView == nil) {
        
        CGFloat height = kSCREEN_HEIGHT+ 44;
        UITableView* tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, kSCREEN_WIDTH, height) style:UITableViewStyleGrouped];
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
        _dataTableView = tableview;
    }
    return _dataTableView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
