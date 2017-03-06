//
//  salesAnalysisViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "salesAnalysisViewController.h"
#import "salesAnalysisTableViewCell.h"
#import "ISVCustomSegView.h"
@interface salesAnalysisViewController ()<UITableViewDelegate,UITableViewDataSource,ISVCustomSegViewDelegate>
@property (nonatomic, weak) UITableView* dataTableView;
@property (nonatomic, weak) UISegmentedControl *dataSegControl;
@property (nonatomic, strong)NSMutableArray *dataList;//数据源数组
@end

@implementation salesAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"销售分析";
    self.view.backgroundColor = ISVBackgroundColor;
    [self.view addSubview:self.dataTableView];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"今天",@"本周",@"本月",@"更多",nil];

    ISVCustomSegView *segView = [[ISVCustomSegView alloc]initWithNumberOfTitles:segmentedArray andFrame:CGRectMake(0, kNavBarHeight, kSCREEN_WIDTH, 44) delegate:self];
    
    [self.view addSubview:segView];
}

- (void)D_selectedTag:(NSInteger)tag{
    NSLog(@"%ld",(long)tag);
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    salesAnalysisTableViewCell *cell = [salesAnalysisTableViewCell cellWithTableView:tableView];
    cell.timeLabel.text = @"2017-10-11";
    cell.amountLabel.text = @"+2000";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%ld",(long)indexPath.row);
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
    
}
@end
