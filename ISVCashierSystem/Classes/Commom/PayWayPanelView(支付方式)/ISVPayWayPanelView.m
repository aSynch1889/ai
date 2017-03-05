//
//  ISVPayWayPanelView.m
//  ISV
//
//  Created by aaaa on 16/1/8.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "ISVPayWayPanelView.h"
#import "ISVPayWayPanelCell.h"
#import "ISVPayWayModel.h"
#import "ISVHorizontalButton.h"

#import "ISVNetworking+Common.h"
#import <MJExtension.h>

#define kPayWayPanelViewRowH 42.0
#define kPayWayPanelViewtitleLabelH 20.0
#define kPayWayPanelViewtitleLabelTopH 10.0
#define kPayWayPanelViewTime 2  // 重新获取的间隔时间
#define kPayWayPanelViewLastIDKey @"kPayWayPanelViewLastID" // 记录最后一次支付方式
#define kPayWayPanelViewDefaultMaxCount 2 // 默认最大行数

@interface ISVPayWayPanelView ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL isLoadMore;    // 是否加载更多
    NSUInteger _payWayPanelViewMaxCount;   // 最大行数
    ISVPayWayModel *_lastModel;
}
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray<ISVPayWayModel *> *dataList;
@end

@implementation ISVPayWayPanelView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        if (frame.size.height == 0) {
            CGFloat w = frame.size.width ? frame.size.width : kSCREEN_WIDTH;
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, w, 195);
        }
        
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setUp];
}

- (void)setUp
{
    _payWayPanelViewMaxCount = kPayWayPanelViewDefaultMaxCount;
    [self requertPaymentList];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, kPayWayPanelViewtitleLabelTopH, 100, kPayWayPanelViewtitleLabelH);
    CGFloat top = kPayWayPanelViewtitleLabelTopH*2 + kPayWayPanelViewtitleLabelH;
    self.tableView.rowHeight = kPayWayPanelViewRowH;
    self.height = kPayWayPanelViewRowH * self.dataList.count + top;
    self.tableView.frame = CGRectMake(0, top, self.width, self.height);
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isLoadMore) {
        _payWayPanelViewMaxCount = self.dataList.count;
    }
    return self.dataList.count <= _payWayPanelViewMaxCount ? self.dataList.count : _payWayPanelViewMaxCount + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ISVPayWayPanelCellID = @"ISVPayWayPanelCellID";
    ISVPayWayPanelCell *cell = [tableView dequeueReusableCellWithIdentifier:ISVPayWayPanelCellID];
    if (cell == nil) {
        cell = [[ISVPayWayPanelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ISVPayWayPanelCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == _payWayPanelViewMaxCount  && !isLoadMore) {
        
        ISVHorizontalButton *btn = [ISVHorizontalButton buttonwithImageName:@"icon_more_down" title:@"更多"];
        btn.frame = CGRectMake(0, 0, self.width, 38);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:kColorBlackPercent40 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchDown];
        [cell.contentView removeAllSubviews];
        [cell.contentView addSubview:btn];
        [cell setHiddenLine:YES];
        
    }else{
        [cell setHiddenLine:NO];
        ISVPayWayModel *model = self.dataList[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ISVPayWayModel *model = self.dataList[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (model.check) {
        return;
    }
    _selectedPayWay = model.ID;
    model.check = YES;
    _lastModel.check = NO;
    _lastModel = model;
    [[NSUserDefaults standardUserDefaults] setValue:@(model.ID) forKey:kPayWayPanelViewLastIDKey];
    
    if ([self.delegate respondsToSelector:@selector(selectedPayWay:)]) {
        [self.delegate selectedPayWay:model.ID];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Private 
- (void)requertPaymentList
{
    // 获取支付方式
    __weak typeof(self) weakSelf = self;
    [ISVNetworking getPaymentListWithSuccess:^(id respondData) {
        
        NSArray *arr = Response_Valuse;
        if (HasValuse && [arr isKindOfClass:[NSArray class]]) {
            weakSelf.dataList = [ISVPayWayModel objectArrayWithKeyValuesArray:arr];
            
            NSUInteger row = 0;
            
            NSUInteger lastID = [[NSUserDefaults standardUserDefaults] integerForKey:kPayWayPanelViewLastIDKey];
            
            for (NSUInteger i = 0; i < weakSelf.dataList.count; i++ ) {
                ISVPayWayModel *m = weakSelf.dataList[i];
                if (m.ID == lastID) {
                    row = i;
                }
            }
            if (row == 2) {
                isLoadMore = YES;
            }
            // 默认选中第一行
            if (weakSelf.dataList.count) {
                [weakSelf tableView:weakSelf.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
            }
            [weakSelf.tableView reloadData];
            [weakSelf setNeedsLayout];
        }
        
    } failure:^(ISVErrorModel *error) {
        
        // 获取不成功，延迟2秒继续登录。
        dispatch_time_t reLoginTimer = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kPayWayPanelViewTime* NSEC_PER_SEC));
        dispatch_after(reLoginTimer, dispatch_get_main_queue(), ^(void){
            
            [weakSelf requertPaymentList];
        });
    }];
}

#pragma mark - Event

- (void)moreAction:(UIButton *)moreBtn
{
    isLoadMore = YES;
    [moreBtn removeFromSuperview];
    [self.tableView reloadData];
}

#pragma mark - 懒加载
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"支付方式";
        titleLabel.font = ISVFontSize(14.0);
        titleLabel.textColor = kColorBlackPercent60;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.bounces = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = kPayWayPanelViewRowH;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (NSArray *)dataList
{
    if (_dataList == nil) {
        _dataList = [NSArray array];
    }
    return _dataList;
}

@end
