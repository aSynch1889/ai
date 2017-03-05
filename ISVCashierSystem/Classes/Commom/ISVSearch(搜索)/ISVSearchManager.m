//
//  ISVSearchManager.m
//  ISV
//
//  Created by aaaa on 15/10/8.
//  Copyright © 2015年 Jinzhai Nature Health Technology Co.,Ltd. All rights reserved.
//

#import "ISVSearchManager.h"

@interface ISVSearchManager ()<UISearchControllerDelegate, UISearchDisplayDelegate, UISearchResultsUpdating>
{
    ISVSearchResultViewController *_searchResultViewController;
}

@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;// ios7
@property (nonatomic, strong) UISearchController *searchController;// ios8

@end

@implementation ISVSearchManager

#pragma mark -
#pragma mark - init

+ (instancetype)managerWithViewController:(UIViewController *)viewController
{
    ISVSearchManager *manager = [[self alloc] init];
    
    if (!SYSTEM_VERSION_LESS_THAN(@"8.0")){ // 系统大于等于iOS8.0
        [manager searchController];
    }else{ // 系统小于iOS8.0
        [manager searchDisplayControllerWithViewController:viewController];
    }
    
    [manager setUpSearchBar];
    return manager;
}


#pragma mark -
#pragma mark - ======= ios8 及以后 =======
- (UISearchController *)searchController
{
    if (_searchController == nil) {
        
        // 处理结果的控制器searchResultViewController
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultViewController];
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;   // 监听搜索
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchBar = _searchController.searchBar;

    }
    return _searchController;
}

#pragma mark - <UISearchResultsUpdating>
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self.searchResultViewController searchResultsUpdateWithSources:self.searchSource searchText:searchController.searchBar.text];
    [self.searchResultViewController.tableView reloadData];
}

#pragma mark - <UISearchControllerDelegate>
- (void)willPresentSearchController:(UISearchController *)searchController
{
    if ([self.delegate respondsToSelector:@selector(willShowSearchManager:)]) {
        [self.delegate willShowSearchManager:self];
    }
}
- (void)didPresentSearchController:(UISearchController *)searchController
{
    self.searchResultViewController.tableView.contentInset = UIEdgeInsetsMake(kNavBarHeight, 0, 0, 0);
    if ([self.delegate respondsToSelector:@selector(didShowSearchManager:)]) {
        [self.delegate didShowSearchManager:self];
    }
};
- (void)willDismissSearchController:(UISearchController *)searchController
{
    if ([self.delegate respondsToSelector:@selector(willHideSearchManager:)]) {
        [self.delegate willHideSearchManager:self];
    }
}
- (void)didDismissSearchController:(UISearchController *)searchController
{
    if ([self.delegate respondsToSelector:@selector(didHideSearchManager:)]) {
        [self.delegate didHideSearchManager:self];
    }
}

#pragma mark -
#pragma mark - ======= ios7 及以前 =======
- (UISearchDisplayController *)searchDisplayControllerWithViewController:(UIViewController *)viewController
{
    if (_searchDisplayController == nil) {
        
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:viewController];
        _searchBar = searchBar;
        
        _searchDisplayController.searchResultsTableView.tableFooterView = [[UIView alloc] init];
        _searchDisplayController.searchResultsTableView.rowHeight = 64.0;
        _searchDisplayController.searchResultsDataSource = self.searchResultViewController;
        _searchDisplayController.searchResultsDelegate = self.searchResultViewController;
        self.searchResultViewController.tableView = _searchDisplayController.searchResultsTableView;
        _searchDisplayController.delegate = self;
        
    }
    return _searchDisplayController;
}


#pragma mark - <UISearchDisplayDelegate>
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    if ([self.delegate respondsToSelector:@selector(willShowSearchManager:)]) {
        [self.delegate willShowSearchManager:self];
    }
}
- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    if ([self.delegate respondsToSelector:@selector(didShowSearchManager:)]) {
        [self.delegate didShowSearchManager:self];
    }
}
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    if ([self.delegate respondsToSelector:@selector(willHideSearchManager:)]) {
        [self.delegate willHideSearchManager:self];
    }
}
- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    if ([self.delegate respondsToSelector:@selector(didHideSearchManager:)]) {
        [self.delegate didHideSearchManager:self];
    }
}

// ios7及以前，搜索到字符串时调用，统一交给searchResultViewController处理，这里不需要手动去刷新显示结果的表格
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self.searchResultViewController searchResultsUpdateWithSources:self.searchSource searchText:searchString];
    return YES;
}

#pragma mark - 
#pragma mark - Private
- (void)setUpSearchBar
{
    _searchBar.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 44);
    _searchBar.placeholder = @"搜索";
    _searchBar.tintColor = kColorBlackPercent40;
    [_searchBar setSearchFieldBackgroundImage:kSearchBarBgImage forState:UIControlStateNormal];

//    searchFieldBackgroundPositionAdjustment
    if (!SYSTEM_VERSION_LESS_THAN(@"8.0")){ // 系统大于等于iOS8.0
        [_searchBar setBackgroundImage:[UIImage imageNamed:@"bg_serch_bar"]];
        _searchBar.searchBarStyle = UISearchBarStyleProminent;
        
    }else{ // 系统小于iOS8.0
        
    }
}

#pragma mark -
#pragma mark - setter method
- (void)setResultOpreation:(void (^)(id<ISVSearchPotocol>))resultOpreation
{
    _resultOpreation = resultOpreation;
    self.searchResultViewController.resultOpreation = resultOpreation;
}

- (void)setSearchFiltereds:(NSArray<NSString *> *)searchFiltereds
{
    _searchFiltereds = searchFiltereds;
    self.searchResultViewController.searchFiltereds = searchFiltereds;
}

- (void)setActive:(BOOL)active
{
    if (active) {
        [self.searchBar becomeFirstResponder];
    }else{
        [self.searchBar resignFirstResponder];
        if (!SYSTEM_VERSION_LESS_THAN(@"8.0")){ // 系统大于等于iOS8.0
            [_searchController setActive:NO];
        }else{ // 系统小于iOS8.0
            [_searchDisplayController setActive:NO];
        }
    }
}

- (BOOL)isActive
{
    return self.searchBar.isFirstResponder;
}

#pragma mark -
#pragma mark - getter method
- (ISVSearchResultViewController *)searchResultViewController
{
    if (_searchResultViewController == nil) {
        _searchResultViewController = [ISVSearchResultViewController defaultViewController];
        _searchResultViewController.tableView.frame = [UIScreen mainScreen].bounds;
//        _searchResultViewController.tableView.backgroundColor = [UIColor whiteColor];
    }
    return _searchResultViewController;
}

@end
