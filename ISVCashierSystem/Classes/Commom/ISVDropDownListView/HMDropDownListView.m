//
//  HMDropDownListView.m
//  HealthMall
//
//  Created by qiuwei on 15/12/2.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMDropDownListView.h"
#import "HMHorizontalButton.h"

#define SECTION_BTN_TAG_BEGIN   1000
#define SECTION_IV_TAG_BEGIN    3000
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))
#define kDefaultCellHeight 44.0
#define kDefaultDropDownMaxHeight 220.0

@interface HMDropDownListView ()
@property (nonatomic, strong) UIView *mTableBaseView;
@property (nonatomic, strong) UITableView *mTableView;
@end

@implementation HMDropDownListView
{
    UILabel *_nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _currentExtendSection = -1;

        if (_dropDownMaxHeight == 0) {
            _dropDownMaxHeight = kDefaultDropDownMaxHeight;
        }
        self.dataSource = datasource;
        self.delegate = delegate;
        
        NSInteger sectionNum = 0;
        if ([self.dataSource respondsToSelector:@selector(numberOfSections)] ) {
            sectionNum = [self.dataSource numberOfSections];
        }
        
        //初始化默认显示view
        CGFloat sectionWidth = (1.0*(frame.size.width)/sectionNum);
        for (int i = 0; i <sectionNum; i++) {
            HMHorizontalButton *sectionBtn = [[HMHorizontalButton alloc] initWithFrame:CGRectMake(sectionWidth*i, 1, sectionWidth, frame.size.height-2)];
            sectionBtn.tag = SECTION_BTN_TAG_BEGIN + i;
            [sectionBtn addTarget:self action:@selector(sectionBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
            NSString *sectionBtnTitle = @"--";
            if ([self.dataSource respondsToSelector:@selector(titleInSection:index:)]) {
                sectionBtnTitle = [self.dataSource titleInSection:i index:[self.dataSource defaultShowSection:i]];
            }
            [sectionBtn  setTitle:sectionBtnTitle forState:UIControlStateNormal];
            [sectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            sectionBtn.titleLabel.font = HMFontSize(16.0);//默认显示的标题设置
            
            [sectionBtn setImage:[UIImage imageNamed:@"icon_button_Triangle_NotSel"] forState:UIControlStateNormal];
            [sectionBtn setImage:[UIImage imageNamed:@"icon_button_Triangle_Sel"] forState:UIControlStateSelected];

            [self addSubview:sectionBtn];
            
            // 添加中间间隔线条
            if (i<sectionNum && i != 0) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(sectionWidth*i, frame.size.height/4, 1, frame.size.height/2)];
                lineView.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:lineView];
            }
            
        }
        
        // 添加底部横线
        CGFloat bottomLineViewHeight = 1.0;
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - bottomLineViewHeight, frame.size.width, bottomLineViewHeight)];
        bottomLineView.backgroundColor = HMRGB(242, 242, 242);
        [self addSubview:bottomLineView];
    }
    return self;
}

#pragma mark -- <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource numberOfRowsInSection:_currentExtendSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *HMDropDownListViewCell = @"HMDropDownListViewCell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HMDropDownListViewCell];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(0, 0, self.width * 0.5, kDefaultCellHeight);
    _nameLabel.font = HMFontSize(14);
    _nameLabel.textColor = kColorBlackPercent80;
    _nameLabel.text = [self.dataSource titleInSection:_currentExtendSection index:indexPath.row];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:_nameLabel];
    return cell;
}

#pragma mark -- <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kDefaultCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.delegate respondsToSelector:@selector(chooseAtSection:index:)]) {
        NSString *chooseCellTitle = [self.dataSource titleInSection:_currentExtendSection index:indexPath.row];
        
        UIButton *currentSectionBtn = (UIButton *)[self viewWithTag:SECTION_BTN_TAG_BEGIN + _currentExtendSection];
        [currentSectionBtn setTitle:chooseCellTitle forState:UIControlStateNormal];
        [currentSectionBtn setTitle:chooseCellTitle forState:UIControlStateSelected];
        
        [self.delegate chooseAtSection:_currentExtendSection index:indexPath.row];
        [self hideExtendedChooseView];
    }
}

#pragma mark - Event
- (void)sectionBtnTouch:(UIButton *)btn
{
    NSInteger section = btn.tag - SECTION_BTN_TAG_BEGIN;

    for (UIButton *subView in self.subviews) {
        if (subView != btn && [subView isKindOfClass:[UIButton class]]) {
            subView.selected = NO;
        }
    }
    btn.selected = !btn.selected;
    
    if (_currentExtendSection == section) {
        [self hideExtendedChooseView];
    }else{
        _currentExtendSection = section;
        
        [self showChooseListViewInSection:_currentExtendSection choosedIndex:[self.dataSource defaultShowSection:_currentExtendSection]];
    }
    
}
- (void)bgTappedAction:(UITapGestureRecognizer *)tap
{
    UIImageView *currentIV = (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN + _currentExtendSection)];
    [UIView animateWithDuration:0.3 animations:^{
        currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
    }];
    [self hideExtendedChooseView];
}

- (BOOL)isShow
{
    if (_currentExtendSection == -1) {
        return NO;
    }
    return YES;
}

- (void)hideExtendedChooseView
{
    if (_currentExtendSection != -1) {
        _currentExtendSection = -1;
        CGRect rect = self.mTableView.frame;
        rect.size.height = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.mTableBaseView.alpha = 1.0f;
            self.mTableView.alpha = 1.0f;
            
            self.mTableBaseView.alpha = 0.2f;
            self.mTableView.alpha = 0.2;
            
            self.mTableView.frame = rect;
        }completion:^(BOOL finished) {
            [self.mTableView removeFromSuperview];
            [self.mTableBaseView removeFromSuperview];
        }];
    }
}

- (void)showChooseListViewInSection:(NSInteger)section choosedIndex:(NSInteger)index
{
    if (!self.mTableView) {
        self.mTableBaseView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height , self.frame.size.width, self.superview.frame.size.height - self.frame.origin.y - self.frame.size.height)];
        self.mTableBaseView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];
        
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
        [self.mTableBaseView addGestureRecognizer:bgTap];
        
        self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, _dropDownMaxHeight) style:UITableViewStylePlain];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
        self.mTableView.showsVerticalScrollIndicator = NO;
        self.mTableView.backgroundColor = [UIColor whiteColor];
        if ([self.mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.mTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.mTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.mTableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    
    //修改tableview的frame
    int sectionWidth = (self.frame.size.width)/[self.dataSource numberOfSections];
    CGRect rect = self.mTableView.frame;
    rect.origin.x = sectionWidth * section;
    rect.size.width = sectionWidth;
    rect.size.height = 0;
    self.mTableView.frame = rect;
    [self.superview addSubview:self.mTableBaseView];
    [self.superview addSubview:self.mTableView];
    
    //动画设置位置
    rect .size.height = _dropDownMaxHeight;
    [UIView animateWithDuration:0.3 animations:^{
        self.mTableBaseView.alpha = 0.2;
        self.mTableView.alpha = 0.2;
        
        self.mTableBaseView.alpha = 1.0;
        self.mTableView.alpha = 1.0;
        self.mTableView.frame =  rect;
    }];
    [self.mTableView reloadData];
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

@end
