//
//  HMCheckViewController.m
//  HealthMall
//
//  Created by qiuwei on 15/12/22.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMCheckViewController.h"
#import "HMCheck.h"
#import "HMFormFootView.h"
#import "HMHUD.h"
#import "HMSearchBar.h"

#define kSearchTextMaxCount 20

@interface HMCheckViewController ()<HMCheckViewDelegate, UITextFieldDelegate>
{
    BOOL _isShowSearchBar; // 显示搜索条
}
@property (nonatomic, weak) HMFormFootView *footView;

// 搜索
@property (nonatomic, strong) HMSearchBar *searchBar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray *searchSource;
@property (nonatomic, strong) NSMutableArray *searchResults;
@end

@implementation HMCheckViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.Max = 10000;
        self.Min = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 导航栏搜索按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kSearchIconImage style:0 target:self action:@selector(searchButtonClick)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    _searchSource = [self.checkView.checks copy];
    
    self.checkView.showCheckMark = self.checkView.isMultipleCheck;
    if (self.checkView.isMultipleCheck) {
        self.navigationItem.titleView = self.titleLabel;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 还原数据（防止控制器不能释放时数据错乱）
    self.checkView.checks = [_searchSource copy];
    
    if (!_isShowSearchBar) {
        self.navigationItem.titleView = self.titleLabel;
    }
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    CGFloat footViewHeight = 0.0;
    if(self.checkView.isMultipleCheck){
        self.footView.frame = CGRectMake(0, self.view.height - kFormfootViewHeight, kSCREEN_WIDTH, kFormfootViewHeight);
        footViewHeight = kFormfootViewHeight;
    }
    self.checkView.frame = CGRectMake(0, kNavBarHeight - 20 , self.view.width, self.view.height - (kNavBarHeight - kStatusBarHeight) - footViewHeight);
}

#pragma mark - <HMCheckViewDelegate>
- (void)checkViewClick:(HMCheckView *)checkView checkeds:(NSArray<HMCheck *> *)checkeds
{
    if(self.checkView.isMultipleCheck){return;}

    ! _checkedsBlock ? : _checkedsBlock(checkeds);
    NSLog(@"%@",checkeds);
}
- (BOOL)checkViewShouldBeginSelectCheck:(HMCheck *)check
{
    if (self.checkView.checkeds.count >= self.Max && ![self.checkView.checkeds containsObject:check]) {
        [HMHUD showErrorWithStatus:[NSString stringWithFormat:@"至多选择%zd项！", self.Max]];
        return NO;
    }
    return YES;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (!_isShowSearchBar) {
        [self.searchBar resignFirstResponder];
        self.navigationItem.titleView = self.titleLabel;
    }
}

#pragma mark - <UITextFieldDelegate>
- (void)textDidChange:(UITextField *)textField
{
    if (textField.text.length > kSearchTextMaxCount)
    {
        textField.text = [textField.text substringToIndex:kSearchTextMaxCount];
        
        NSString *maxMsg = [NSString stringWithFormat:
                            @"关键词不能超过%zd个字符", kSearchTextMaxCount];
        [HMHUD showErrorWithStatus:maxMsg];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self searchWithText:textField.text];

    return YES;
}

#pragma mark - Private
// 开始搜索
- (void)searchWithText:(NSString *)text
{
    NSLog(@"%@", text);
    if (text.length == 0 && self.searchSource.count == 0) return;
 
    // 先处理keyword
    NSString *filteredStr = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *tmpStr = [NSString stringWithFormat:@"*%@*",filteredStr];
    // 过滤条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(title LIKE[cd] %@)", tmpStr];
    //过滤数据
    NSMutableArray *results =  [NSMutableArray arrayWithArray:[self.searchSource filteredArrayUsingPredicate:predicate]];
    
    if (results.count) {
        _isShowSearchBar = YES;
        [self.searchResults removeAllObjects];
        self.searchResults = results;
        self.checkView.checks = self.searchResults;

    }else{
        _isShowSearchBar = NO;
        [HMHUD showErrorWithStatus:@"暂时没有找到相关数据"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowHUDInfoDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.searchBar becomeFirstResponder];
        });
    }
}

#pragma mark -Event
// 点击搜索
- (void)searchButtonClick
{
    self.searchBar.hidden = !self.searchBar.hidden;
    if (self.searchBar.hidden)
    {
        self.navigationItem.titleView = self.titleLabel;
        self.checkView.checks = self.searchSource;
        _isShowSearchBar = NO;
    }
    else
    {
        self.navigationItem.titleView = self.searchBar;
        [self.searchBar becomeFirstResponder];
        _isShowSearchBar = YES;
    }
    
}

- (void)confirmClick
{
    if (self.checkView.checkeds.count < self.Min) {
        [HMHUD showErrorWithStatus:[NSString stringWithFormat:@"至少选择%zd项！", self.Min]];
        return;
    }
    if (self.checkView.checkeds.count > self.Max) {
        [HMHUD showErrorWithStatus:[NSString stringWithFormat:@"至多选择%zd项！", self.Max]];
        return;
    }
    ! _checkedsBlock ? : _checkedsBlock(self.checkView.checkeds);
}

#pragma mark - 懒加载
- (HMCheckView *)checkView
{
    if (_checkView == nil) {
        HMCheckView *checkView = [[HMCheckView alloc] init];

        checkView.showIndexs = YES;
        checkView.delegate = self;

        [self.view addSubview:checkView];
        _checkView = checkView;
    }
    return _checkView;
}
- (HMFormFootView *)footView
{
    if (_footView == nil) {
        HMFormFootView *footView = [[HMFormFootView alloc] init];
        [footView.submitButton setTitle:@"确定" forState:UIControlStateNormal];
        [footView.submitButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:footView];
        _footView = footView;
    }
    return _footView;
}

- (HMSearchBar *)searchBar
{
    if (_searchBar == nil)
    {
        _searchBar = [[HMSearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.placeholder = @" 搜索";
        _searchBar.hidden = YES;
        [_searchBar addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _searchBar;
}
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 100, 30);
        label.text = self.title;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
