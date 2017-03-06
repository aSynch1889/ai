//
//  memberManagerViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "memberManagerViewController.h"
#import "memberManagerTableViewCell.h"
#import "ISVSearchManager.h"
@interface memberManagerViewController ()<UITableViewDelegate,UITableViewDataSource,ISVSearchManagerDelegate,UISearchBarDelegate>
@property (nonatomic, weak) UITableView* dataTableView;
@property (nonatomic, strong)ISVSearchManager *searchManager;
@end

@implementation memberManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"会员列表";
    self.view.backgroundColor = ISVBackgroundColor;
    [self.view addSubview:self.dataTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.dataTableView.tableHeaderView = self.searchManager.searchBar;
    
}

/**
    新增会员
 */
- (void)rightClick {
    NSLog(@"新增会员");
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    memberManagerTableViewCell *cell = [memberManagerTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text = @"xiaowang";
    cell.phoneLabel.text = @"18699001231";
    cell.amountLabel.text = @"储值：+2000";
    cell.integralLabel.text = @"积分：100";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - <UISearchBarDelegate>
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.searchManager.searchResultViewController.searchResults removeAllObjects];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchManager.searchBar resignFirstResponder];
    
    
    [self.searchManager.searchResultViewController.searchResults removeAllObjects];
    [self searchWithText:searchBar.text];
}

// 开始搜索
- (void)searchWithText:(NSString *)text
{
    NSLog(@"%@", text);
    if (text.length == 0) return;
    
    
}

// 搜索更多
- (void)loadMoreSearchResults
{
    [self searchWithText:self.searchManager.searchBar.text];
}



#pragma mark - 懒加载
- (NSArray *)dataList
{
    return nil;
}

- (ISVSearchManager *)searchManager
{
    if (_searchManager == nil) {
        
        _searchManager = [ISVSearchManager managerWithViewController:self];
        _searchManager.delegate = self;
        _searchManager.searchBar.delegate = self;
        _searchManager.searchBar.placeholder = @"请输入会员名称/手机号/卡号";

        
    }
    return _searchManager;
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
