//
//  HMSortChooseBar.m
//  HealthMall
//
//  Created by jkl on 15/11/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMSortChooseBar.h"
#import "HMSortBarCell.h"
#import "NSString+HMExtension.h"
#import "HMBottomToolBar.h"
#import "HMHollowButton.h"
#import "HMItemChooseView.h"
#import "HMEasyHitBtn.h"
#import "NSString+HMExtension.h"

#import "HMCoachApplySelectQualificationsViewController.h"  // 资质选择
#import "HMCoachQualification.h"

#define qcFont [UIFont systemFontOfSize:14]  // 资质标签字体

@interface HMSortChooseBar ()
<UITableViewDataSource, UITableViewDelegate,
HMItemChooseViewDelegate, HMBottomToolBarDelagate>

@property (nonatomic, weak) UIImageView *triangle1;
@property (nonatomic, weak) UIImageView *triangle2;
/// 用来显示筛选列表的view
@property (nonatomic, weak) UIView *showView;
@property (nonatomic, assign) CGRect showFrame;

/// 黑色透明背景
@property (nonatomic, weak) UIView *coverView;

/// 综合排序列表
@property (nonatomic, strong) UITableView *sortTableView;

/// 筛选列表
@property (nonatomic, strong) UIView *chooseView;


///  综合排序按钮
@property (nonatomic, weak) UIButton *sortBtn;
/// 筛选按钮
@property (nonatomic, weak) UIButton *chooseBtn;

@property (nonatomic, assign) NSInteger selectedSortAtIndex;

@property (nonatomic, weak) UIImageView *maleIcon;
@property (nonatomic, weak) UIImageView *femaleIcon;
@property (nonatomic, weak) HMEasyHitBtn *maleBtn;
@property (nonatomic, weak) HMEasyHitBtn *femaleBtn;

@property (nonatomic, weak) HMItemChooseView *ageChoose;
@property (nonatomic, weak) HMItemChooseView *heightChoose;
/// 运动时间
@property (nonatomic, weak) HMItemChooseView *timeChoose;

/// 选择资质按钮
@property (nonatomic, weak) HMHollowButton *qcBtn;
/// 资质标签
@property (nonatomic, weak) UILabel *qcLabel;
@property (nonatomic, assign) CGFloat maleX;  // 性别按钮x值

@property (nonatomic, strong) NSMutableDictionary *chooseItems;

@end

@implementation HMSortChooseBar

- (UIView *)chooseView
{
    if (_chooseView != nil) return _chooseView;
    
    _chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, self.showFrame.origin.y, kSCREEN_WIDTH, 0)];
    _chooseView.backgroundColor = HMRGB(242, 242, 242);
    _chooseView.layer.masksToBounds = YES;
    CGFloat leading = 10;  // 距离屏幕边距
    CGFloat lineH = 1;
    CGFloat lineW = kSCREEN_WIDTH - 2 * leading;
    
    CGFloat btnW = 60;
    CGFloat btnH = 20;
    CGFloat margin = (kSCREEN_WIDTH - leading*2 - btnW*4) / 3.0;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, self.showFrame.size.height-49-4)];
    scrollView.backgroundColor = [UIColor whiteColor];
    [_chooseView addSubview:scrollView];
    
    // 1.私教性别
    UIView *sexView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 35 + lineH)];
    [scrollView addSubview:sexView];
    CGFloat maleX = 10 + btnW + margin;
    CGFloat femaleX = maleX + btnW + margin;
    self.maleX = maleX;
    
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(leading, 7, 70, 21)];
    sexLabel.text = @"私教性别:";
    sexLabel.font = [UIFont systemFontOfSize:14];
    sexLabel.textColor = HMRGB(100, 100, 100);
    [sexView addSubview:sexLabel];
    
    HMEasyHitBtn *maleBtn = [HMEasyHitBtn easyHitBtn];
    maleBtn.frame = CGRectMake(maleX, 3, btnW, 30);
    [maleBtn setTitle:@"      男" forState:UIControlStateNormal];
    maleBtn.tag = 1;
    [maleBtn addTarget:self action:@selector(sexBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:maleBtn];
    self.maleBtn = maleBtn;
    
    HMEasyHitBtn *femaleBtn = [HMEasyHitBtn easyHitBtn];
    femaleBtn.frame = CGRectMake(femaleX, 3, btnW, 30);
    [femaleBtn setTitle:@"      女" forState:UIControlStateNormal];
    femaleBtn.tag = 2;
    [femaleBtn addTarget:self action:@selector(sexBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:femaleBtn];
    self.femaleBtn = femaleBtn;

    
    // Screen_male_nor   Screen_male_sel 12*14
    // Screen_female_nor Screen_female_sel
    UIImageView *maleIcon = [[UIImageView alloc] initWithFrame:CGRectMake(maleX+14, 10, 12, 14)];
    maleIcon.image = [UIImage imageNamed:@"Screen_male_nor"];
    maleIcon.highlightedImage = [UIImage imageNamed:@"Screen_male_sel"];
    [sexView addSubview:maleIcon];
    self.maleIcon = maleIcon;
    
    UIImageView *femaleIcon = [[UIImageView alloc] initWithFrame:CGRectMake(femaleX+14, 10, 12, 14)];
    femaleIcon.image = [UIImage imageNamed:@"Screen_female_nor"];
    femaleIcon.highlightedImage = [UIImage imageNamed:@"Screen_female_sel"];
    [sexView addSubview:femaleIcon];
    self.femaleIcon = femaleIcon;

    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(leading, sexView.height-lineH, lineW, lineH)];
    line.backgroundColor = HMRGB(242, 242, 242);
    line.userInteractionEnabled = NO;
    [sexView addSubview:line];
    
    // 2.私教年龄
    HMItemChooseView *ageChoose = [HMItemChooseView itemChooseViewWithY:CGRectGetMaxY(sexView.frame) title:@"私教年龄" items:@[@"16-25", @"26-35", @"36-45", @"45以上"]];
    ageChoose.delegate = self;
    [scrollView addSubview:ageChoose];
    self.ageChoose = ageChoose;
    
    // 3.私教身高
    HMItemChooseView *heightChoose = [HMItemChooseView itemChooseViewWithY:CGRectGetMaxY(ageChoose.frame) title:@"私教身高(cm)" items:@[@"150以下", @"151-160", @"161-170", @"171-180", @"180以上"]];
    heightChoose.delegate = self;
    [scrollView addSubview:heightChoose];
    self.heightChoose = heightChoose;
    
    // 4.私教资质
    HMItemChooseView *qualificationChoose = [HMItemChooseView itemChooseViewWithY:CGRectGetMaxY(heightChoose.frame) title:@"私教资质" items:nil];
    [scrollView addSubview:qualificationChoose];
    
    UILabel *qcLabel = [[UILabel alloc] initWithFrame:CGRectMake(maleX, 10, 0, 20)];
    qcLabel.font = qcFont;
    qcLabel.textColor = HMMainlColor;
    [qualificationChoose addSubview:qcLabel];
    self.qcLabel = qcLabel;
    
    HMHollowButton *qcBtn = [HMHollowButton hollowButtonWithTitle:@"选择" frame:CGRectMake(maleX, 10, btnW, btnH)];
    qcBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [qcBtn addTarget:self action:@selector(qualificationBtnPressed)
    forControlEvents:UIControlEventTouchUpInside];
    [qualificationChoose addSubview:qcBtn];
    self.qcBtn = qcBtn;
    
    // 4.运动时间(可选)
    CGRect timeChooseRect = CGRectZero;
    if (self.isShowTimeChoose)
    {
        HMItemChooseView *timeChoose = [HMItemChooseView itemChooseViewWithY:CGRectGetMaxY(qualificationChoose.frame) title:@"运动时间" items:@[@"今天", @"明天", @"一周内", @"一个月内"]];
        timeChoose.delegate = self;
        [scrollView addSubview:timeChoose];
        self.timeChoose = timeChoose;
        
        timeChooseRect = timeChoose.frame;
    } else
    {
        timeChooseRect = qualificationChoose.frame;
    }
    
    // 5.重置按钮
    HMHollowButton *resetBtn = [HMHollowButton hollowButtonWithTitle:@"重 置" frame:CGRectMake((kSCREEN_WIDTH-80)*0.5, CGRectGetMaxY(timeChooseRect)+10, 80, 30)];
    resetBtn.themeColor = HMRGB(255, 99, 99);
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [resetBtn addTarget:self action:@selector(resetBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:resetBtn];
    
    // 6.确定按钮
    HMBottomToolBar *bar = [HMBottomToolBar bottomToolBarWithTitles:@[@"确定"]];
    bar.y = self.showFrame.size.height - bar.height;
    bar.delegate = self;
    [_chooseView addSubview:bar];
    
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(resetBtn.frame) + 49);
    
    return _chooseView;
}

#pragma mark - 点击性别按钮
- (void)sexBtnPressed:(UIButton *)btn
{
    if (btn.tag == 1)
    {
        self.maleIcon.highlighted = YES;
        self.maleBtn.selected = YES;
        self.femaleIcon.highlighted = NO;
        self.femaleBtn.selected = NO;
        self.chooseItems[@"sex"] = @"1";
    }
    else if (btn.tag == 2)
    {
        self.maleIcon.highlighted = NO;
        self.maleBtn.selected = NO;
        self.femaleIcon.highlighted = YES;
        self.femaleBtn.selected = YES;
        self.chooseItems[@"sex"] = @"2";
    }
    
    [self updateDisplayChooseTriangle];
}

#pragma mark - 选中私教年龄, 私教身高
- (void)didChooseItemWithTitle:(NSString *)title item:(NSString *)item
{
    // 1.转换为后台查询参数
    NSDictionary *converDict = @{@"150以下":@"0-150", @"180以上":@"180-300",
                                 @"45以上":@"45-300",
                                 @"今天":@"1", @"明天":@"2", @"一周内":@"3", @"一个月内内":@"4"};
    
    if ([converDict.allKeys containsObject:item])
    {
        item = converDict[item];
    }

    
    //
    if ([title isEqualToString:@"私教年龄"])
    {
        self.chooseItems[@"age"] = item;
    }
    else if ([title isEqualToString:@"私教身高(cm)"])
    {
        self.chooseItems[@"height"] = item;
    }
    else if ([title isEqualToString:@"运动时间"])
    {
        self.chooseItems[@"time"] = item;
    }
    else
    {
       self.chooseItems[title] = item;
    }
    
    [self updateDisplayChooseTriangle];
}

#pragma mark - 点击选择资质按钮
- (void)qualificationBtnPressed
{
    // HMCoachQualification
    UITabBarController *tab = (UITabBarController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    UINavigationController *nav = (UINavigationController *)[tab selectedViewController];
    UIViewController *top = nav.topViewController;
    
    HMCoachApplySelectQualificationsViewController *vc =
    [[HMCoachApplySelectQualificationsViewController alloc] init];
    
    typeof (self) weakSelf = self;
    typeof (top) weakTop = top;
    vc.completeBlock = ^(HMCoachQualification *q){
        
        if (q != nil)
        {
            weakSelf.chooseItems[@"qualification"] = @(q.quaID).description;
            weakSelf.qcLabel.text = q.quaName;
            
            CGSize quaNameSize = [q.quaName sizeWithFont:qcFont maxSize:CGSizeMake(kSCREEN_WIDTH-weakSelf.maleX-60-10, qcFont.lineHeight)];
            CGRect qcLabelRect = weakSelf.qcLabel.frame;
            qcLabelRect.size.width = quaNameSize.width;
            weakSelf.qcLabel.frame = qcLabelRect;
            
            CGRect qcRect = weakSelf.qcBtn.frame;
            qcRect.origin.x = CGRectGetMaxX(qcLabelRect) + 10;
            weakSelf.qcBtn.frame = qcRect;
            
            [weakSelf.qcBtn setTitle:@"更换" forState:UIControlStateNormal];
            weakSelf.qcBtn.themeColor = HMRGB(200, 200, 200);
            
            [weakSelf updateDisplayChooseTriangle];
        } else
        {
            [weakSelf.qcBtn setTitle:@"选择" forState:UIControlStateNormal];
            weakSelf.qcBtn.themeColor = HMMainlColor;
    
            // 资质
            CGRect qcLabelRect = self.qcLabel.frame;
            qcLabelRect.size.width = 0.0;
            weakSelf.qcLabel.frame = qcLabelRect;
            
            CGRect qcRect = weakSelf.qcBtn.frame;
            qcRect.origin.x = weakSelf.maleX;
            weakSelf.qcBtn.frame = qcRect;
        }
        
        [weakTop.navigationController popViewControllerAnimated:YES];
    };
    vc.title = @"私教资质";
    [top.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 点击重置按钮
- (void)resetBtnPressed
{
    [self.ageChoose reset];
    [self.heightChoose reset];
    [self.timeChoose reset];
    self.maleBtn.selected = NO;
    self.femaleBtn.selected = NO;
    self.maleIcon.highlighted = NO;
    self.femaleIcon.highlighted = NO;
    
    [self.qcBtn setTitle:@"选择" forState:UIControlStateNormal];
    self.qcBtn.themeColor = HMMainlColor;
    
    [self.chooseItems removeAllObjects];
    
    // 资质
    CGRect qcLabelRect = self.qcLabel.frame;
    qcLabelRect.size.width = 0.0;
    self.qcLabel.frame = qcLabelRect;
    
    CGRect qcRect = self.qcBtn.frame;
    qcRect.origin.x = self.maleX;
    self.qcBtn.frame = qcRect;
    
    // 三角图标
    [self updateDisplayChooseTriangle];
}

#pragma mark - 点击(筛选)确定按钮
- (void)bottomToolBarDidSelectedAtIndex:(NSInteger)index
{
    [self closeSortChooseBar];
    [self.delegate sortChooseBar:self didChoose:self.chooseItems];
}

#pragma mark - 更新筛选按钮三角图标
- (void)updateDisplayChooseTriangle
{
    // AskFriend_icon_jiaobiao_select
    // AskFriend_icon_jiaobiao
    
    if (self.chooseItems.allKeys.count >0)
    {
        self.triangle2.image = [UIImage imageNamed:@"AskFriend_icon_jiaobiao_select"];
        self.triangle2.transform = CGAffineTransformMakeRotation(M_PI);
        self.chooseBtn.selected = YES;
    } else
    {
        self.triangle2.image = [UIImage imageNamed:@"AskFriend_icon_jiaobiao"];
        self.triangle2.transform = CGAffineTransformMakeRotation(0.0);
        self.chooseBtn.selected = NO;
    }
}

- (NSMutableDictionary *)chooseItems
{
    if (_chooseItems == nil)
    {
        _chooseItems = [NSMutableDictionary dictionary];
    }
    return _chooseItems;
}

+ (instancetype)sortChooseBarWithY:(CGFloat)y showView:(UIView *)showView showFrame:(CGRect)showFrame
{
    CGRect rect = CGRectMake(30, y, kSCREEN_WIDTH - 30*2, 30);
    HMSortChooseBar *bar = [[self alloc] initWithFrame:rect];
    bar.showView = showView;
    bar.showFrame = showFrame;
    return bar;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _sortTitles = @[@"综合排序", @"距离排序", @"价格排序", @"评分排序"];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        
        // 综合排序按钮
        CGFloat btnWidth = frame.size.width * 0.5;
        UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        sortBtn.frame = CGRectMake(0, 0, btnWidth, 30);
        [sortBtn setTitle:_sortTitles[0] forState:UIControlStateNormal];
        [sortBtn setTitleColor:HMMainlColor forState:UIControlStateNormal];
        sortBtn.titleLabel.font = kTitleFont;
        [sortBtn addTarget:self action:@selector(sortBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sortBtn];
        self.sortBtn = sortBtn;
        
        // 筛选按钮
        UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        chooseBtn.frame = CGRectMake(btnWidth, 0, btnWidth, 30);
        [chooseBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [chooseBtn setTitleColor:HMRGB(150, 150, 150) forState:UIControlStateNormal];
        [chooseBtn setTitleColor:HMMainlColor forState:UIControlStateSelected];
        chooseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [chooseBtn addTarget:self action:@selector(chooseBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        chooseBtn.tintColor = [UIColor whiteColor];
        [self addSubview:chooseBtn];
        self.chooseBtn = chooseBtn;
        
        // 中间竖线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(btnWidth, 5, 1, 20)];
        line.backgroundColor = HMRGB(230, 230, 230);
        [self addSubview:line];
        
        // 角标(小三角图片)
        CGSize titleSize1 = [sortBtn.titleLabel.text boundingRectWithSize:CGSizeMake(btnWidth, sortBtn.titleLabel.font.lineHeight)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                              attributes:@{NSFontAttributeName: sortBtn.titleLabel.font}
                                                                 context:nil].size;
        
        UIImageView *triangle1 = [[UIImageView alloc] initWithFrame:CGRectMake(btnWidth*0.5+titleSize1.width*0.5+5, 12, 6, 6)];
        triangle1.image = [UIImage imageNamed:@"AskFriend_icon_jiaobiao_select"];
        [self addSubview:triangle1];
        self.triangle1 = triangle1;
        
        
        CGSize titleSize2 = [chooseBtn.titleLabel.text boundingRectWithSize:CGSizeMake(btnWidth, chooseBtn.titleLabel.font.lineHeight)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                              attributes:@{NSFontAttributeName: chooseBtn.titleLabel.font}
                                                                 context:nil].size;
        UIImageView *triangle2 = [[UIImageView alloc] initWithFrame:CGRectMake(btnWidth*1.5+titleSize2.width*0.5+5, 12, 6, 6)];
        triangle2.image = [UIImage imageNamed:@"AskFriend_icon_jiaobiao"];
        triangle2.transform = CGAffineTransformMakeRotation(M_PI);
        [self addSubview:triangle2];
        self.triangle2 = triangle2;
    }
    return self;
}

#pragma mark - 点击综合排序按钮
- (void)sortBtnPressed
{
    if (self.sortTableView.window)
    {
        // 关闭综合排序列表
        [self closeSortChooseBar];
    }else
    {
        if (self.chooseView.window)
        {
            // 关闭筛选列表
            [self closeSortChooseBar];
            return;
        }

        // 显示综合排序列表
        [self.coverView addSubview:self.sortTableView];

        CGFloat sortTableHeight = MIN(self.showFrame.size.height, 44*self.sortTitles.count - 1);
        
        UIButton *tapBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.sortTitles.count * 44, kSCREEN_WIDTH, self.showFrame.size.height - self.sortTitles.count * 44)];
        [tapBtn addTarget:self action:@selector(closeSortChooseBar) forControlEvents:UIControlEventTouchUpInside];
        [self.coverView addSubview:tapBtn];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.sortTableView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, sortTableHeight);
            self.coverView.backgroundColor = HMRGBACOLOR(0, 0, 0, 0.5);
            self.triangle1.transform = CGAffineTransformRotate(self.triangle1.transform, M_PI);
        }];
    }
    
}

#pragma mark - 点击筛选按钮
- (void)chooseBtnPressed
{
    if (self.chooseView.window)
    {
        // 关闭筛选列表
        [self closeSortChooseBar];
    }else
    {
        if (self.sortTableView.window)
        {
            // 关闭综合排序列表
            [self closeSortChooseBar];
            return;
        }
        
        // 显示筛选列表
        [self.showView addSubview:self.chooseView];
        [UIView animateWithDuration:0.2 animations:^{
            self.chooseView.frame = self.showFrame;
            self.triangle2.transform = CGAffineTransformRotate(self.triangle2.transform, M_PI);
        }];
    }
}


#pragma mark - getter
- (UIView *)coverView
{
    if (_coverView == nil)
    {
        UIView *coverView = [[UIView alloc] initWithFrame:self.showFrame];
        coverView.backgroundColor = HMRGBACOLOR(0, 0, 0, 0);
        [self.showView addSubview:coverView];
        _coverView = coverView;
    }
    return _coverView;
}

// 综合排序
- (UITableView *)sortTableView
{
    if (_sortTableView) return _sortTableView;

    _sortTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 0)];
    _sortTableView.layer.masksToBounds = YES;
    _sortTableView.separatorColor = HMRGB(242, 242, 242);
    _sortTableView.scrollEnabled = NO;
    _sortTableView.dataSource = self;
    _sortTableView.delegate = self;
    
    if ([_sortTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_sortTableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if ([_sortTableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_sortTableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    
    return _sortTableView;
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sortTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMSortBarCell *cell = [HMSortBarCell cellWithTableView:tableView];
    cell.title = self.sortTitles[indexPath.row];
    
    // 让排序列表cell的文字跟工具条排序按钮的文字左对齐
    CGFloat btnWidth = kSCREEN_WIDTH * 0.5 - 30;
    
    CGSize titleSize = [self.sortTitles[self.selectedSortAtIndex] sizeWithFont:kTitleFont maxSize:CGSizeMake(btnWidth, kTitleFont.lineHeight)];
    
    cell.titleX = (btnWidth - titleSize.width) * 0.5 + 30;
    
    
    if (indexPath.row == self.selectedSortAtIndex)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.didSelected = YES;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.didSelected = NO ;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.被选择的cell
    self.selectedSortAtIndex = indexPath.row;
    
    [tableView reloadData];
    
    // 2.取消高亮状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 3.修改综合排序按钮的标题
    NSString *title = self.sortTitles[indexPath.row];
    if (![self.sortBtn.currentTitle isEqualToString:title])
    {
        // 防止闪屏
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.sortBtn setTitle:title forState:UIControlStateNormal];
        });
    }
    
    // 4.关闭综合排序列表
    [self closeSortChooseBar];
    
    // 5.通知代理
    [self.delegate sortChooseBar:self didSelectedAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 关闭综合排序 关闭筛选
- (void)closeSortChooseBar
{
    if (self.sortTableView.height > 0.0)
    {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.sortTableView.frame = CGRectMake(0, 0.0, kSCREEN_WIDTH, 0);
            self.triangle1.transform = CGAffineTransformRotate(self.triangle1.transform, M_PI);
            self.sortTableView.alpha = 0.8;
            self.coverView.backgroundColor = HMRGBACOLOR(0, 0, 0, 0.0);
        } completion:^(BOOL finished) {
            [self.coverView removeFromSuperview];
            self.sortTableView.alpha = 1.0;
        }];
    } else if (self.chooseView.height > 0.0)
    {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.chooseView.frame = CGRectMake(0, self.showFrame.origin.y, kSCREEN_WIDTH, 0.0);
            self.triangle2.transform = CGAffineTransformRotate(self.triangle2.transform, M_PI);
        } completion:^(BOOL finished) {
            [self.chooseView removeFromSuperview];
        }];
    }
}

- (void)setSortTitles:(NSArray *)sortTitles
{
    _sortTitles = sortTitles;
    
    [self.sortBtn setTitle:_sortTitles[0] forState:UIControlStateNormal];
}

@end
