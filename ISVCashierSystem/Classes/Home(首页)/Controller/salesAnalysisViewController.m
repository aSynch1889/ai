//
//  salesAnalysisViewController.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "salesAnalysisViewController.h"

@interface salesAnalysisViewController ()<UITableViewDelegate,UITableViewDataSource>
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
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0,kNavBarHeight,kSCREEN_WIDTH,44);
    segmentedControl.selectedSegmentIndex = 0;
//    segmentedControl.tintColor = [UIColor redColor];
    segmentedControl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:segmentedControl];
    
    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
}

- (void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %li",(long)Index);
    switch (Index) {
        case 0:
            NSLog(@"点击了第一个");
            break;
        case 1:
            NSLog(@"点击了第二个");
            break;
        case 2:
            NSLog(@"点击了第三个");
            break;
        case 3:
            NSLog(@"点击了第四个");
            break;
        default:
            break;
    }
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
    static NSString* cellID = @"cellID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - 懒加载
- (UITableView *)dataTableView{
    if (_dataTableView == nil) {
        
        CGFloat height = kSCREEN_HEIGHT+ 44;
        UITableView* tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kSCREEN_WIDTH, height) style:UITableViewStyleGrouped];
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
