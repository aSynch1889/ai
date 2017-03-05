//
//  ISVSearchResultViewController.m
//  ISV
//
//  Created by aaaa on 15/12/16.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVSearchResultViewController.h"
#import "ISVSearchCell.h"
#import <MJExtension.h>
#import "ISVHUD.h"

static NSString * const ksearchResultCellID = @"SearchResultCell";
static CGFloat const kSearchResultViewControllerCellHeight = 64.0;

@implementation ISVSearchResultViewController

+ (instancetype)defaultViewController
{
    return [[self alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ISVBackgroundColor;
}

#pragma mark - ResultsList<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(searchResultWithTableView:cellForRowAtIndexPath:)]) {
        return [_delegate searchResultWithTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    ISVSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ksearchResultCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ISVSearchCell class]) owner:nil options:nil] lastObject];
    }
    
    id<ISVSearchPotocol> obj = self.searchResults[indexPath.row];
    cell.model = obj;
    
    return cell;
}

#pragma mark - ResultsList<UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(searchResultWithTableView:heightForRowAtIndexPath:)]) {
        return [_delegate searchResultWithTableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return kSearchResultViewControllerCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 模型
    id<ISVSearchPotocol>obj = self.searchResults[indexPath.row];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 点击某个结果执行操作
    !_resultOpreation ? : _resultOpreation(obj);
    
}
// 去掉iOS7 以上cell的间距
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - setter/getter 
- (void)setSearchResults:(NSMutableArray<id<ISVSearchPotocol>> *)searchResults
{
    _searchResults = searchResults;
    [self.tableView reloadData];
}

#pragma mark - 搜索结果更新后调用（可以抽到一个处理结果的工具类里，但暂时写在这）

- (void)searchResultsUpdateWithSources:(NSArray<id<ISVSearchPotocol>> *)sources searchText:(NSString *)searchText
{
    if (!sources.count) { return; }
    
    if (searchText.length == 0) {  // 没有输入任何关键词
        
        if (self.searchResults != nil) {
            [self.searchResults removeAllObjects];
        }
        return;
    } else {
        
        // 过滤条件
        NSPredicate *predicate = [self filteredsPredicate:searchText];
        // 过滤数据
        NSArray *results = [sources filteredArrayUsingPredicate:predicate];

        if (results.count == 0) {
            
            [ISVHUD showPageWithPageType:ISVHUDPageTypeNoData InView:self.tableView];
            return;
        }
        
        [ISVHUD dismiss];
        // 字典转模型
        self.searchResults = [[[[sources firstObject] class] objectArrayWithKeyValuesArray:results] mutableCopy];
    }
}

// 返回过滤条件
- (NSPredicate *)filteredsPredicate:(NSString *)searchStr
{
    if (!self.searchFiltereds.count) return nil;
    
    NSString *filteredStr = [searchStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // [cd] 为不区分大小写@"(FriendNickName LIKE[cd] %@) OR (FriendUserName LIKE[cd] %@) OR (Remark LIKE[cd] %@)"
    NSMutableString *filteredSQL = [NSMutableString string];
    for (int i = 0; i < self.searchFiltereds.count; i++) {
        NSString *filtered = self.searchFiltereds[i];
        if (i == self.searchFiltereds.count - 1) {
            [filteredSQL appendFormat:@"(%@ LIKE[cd] '*%@*') ", filtered, filteredStr];
        }else{
            [filteredSQL appendFormat:@"(%@ LIKE[cd] '*%@*') OR ", filtered, filteredStr];
        }
    }
    return [NSPredicate predicateWithFormat:filteredSQL];
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.rowHeight = kSearchResultViewControllerCellHeight;
        tableView.tableFooterView = [[UIView alloc] init];
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [tableView setLayoutMargins:UIEdgeInsetsZero];
        }

        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
@end
