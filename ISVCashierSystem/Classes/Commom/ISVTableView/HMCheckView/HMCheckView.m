//
//  HMCheckView.m
//  HealthMall
//
//  Created by qiuwei on 15/11/17.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMCheckView.h"
#import "HMCheckCell.h"

#import "UIView+HMAnimation.h"
#import "pinyin.h"

CGFloat const kHeadTitleLeftMargin = 30.0;
CGFloat const kHeadTitleFontSize = 15.0;
CGFloat const kHeadTitleTopBottomMargin = 5.0;
NSString * const HMCheckCellID = @"HMCheckCellID";

@interface HMCheckView ()<UITableViewDataSource, UITableViewDelegate>
{
    NSIndexPath *_currenIndexPath;// 单选当前选中行
    NSMutableArray<id<HMCheckPotocol>> *_checkeds;
    int _character_num;
}
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *indexDict;
@property (nonatomic, strong) NSArray *indexs;
@property (nonatomic, strong) UILabel *characterLabel;  // 字母索引提示

@end

@implementation HMCheckView

#pragma mark - 初始化

// 需要开启多选模式可以使用此方法创建（默认单选）
+ (instancetype)checkWithMultipleCheck:(BOOL)isMultipleCheck
{
    HMCheckView *checkV = [[self alloc] init];
    checkV.multipleCheck = isMultipleCheck;
    return checkV;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
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
//    _multipleCheck = YES;// 多行模式
    self.iconRounded = YES;
    self.backgroundColor = HMBackgroundColor;
    _currenIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.checkeds removeAllObjects];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexs.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self getDatasForSection:section] count];
}
//添加索引列
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    if(_showIndexs){
        return self.indexs;
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:HMCheckCellID];
    
    if (!self.iconRounded) {
        cell.iconImageView.layer.cornerRadius = 0.0;
        cell.iconImageView.layer.masksToBounds = NO;
    }
    if(self.iconBackgroundColor){
        cell.iconImageView.backgroundColor = self.iconBackgroundColor;
    }
    
    // 取出某一行的模型
    NSArray *arr = [self getDatasForSection:indexPath.section];
    id<HMCheckPotocol> check = arr[indexPath.row];
    
    // 初始化选中
    if (!_multipleCheck) {// 单选
        if (check.isCheck) {
            // 如果有多个值为YES，默认选最开始的那个
            if (self.checkeds.count == 1 && ![self.checkeds containsObject:check]){
                check.isCheck = NO;
            }else{
                _currenIndexPath = indexPath;
                [self.checkeds addObject:check];
            }
        }
    }else{// 多选
        
        if (check.isCheck) {
            if (![self.checkeds containsObject:check]) {
                [self.checkeds addObject:check];
            }
        }else{
            [self.checkeds removeObject:check];
        }
    }
    
    cell.showCheckMark = self.isShowCheckMark;
    cell.check = check;
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出某一行的模型
    NSArray *arr = [self getDatasForSection:indexPath.section];
    id<HMCheckPotocol> check = arr[indexPath.row];
    
    if([self.delegate respondsToSelector:@selector(checkViewShouldBeginSelectCheck:)]){
        BOOL isShould = [self.delegate checkViewShouldBeginSelectCheck:check];
        if (!isShould) { return; }
    }
    
    if (!_multipleCheck) {// 单选
        
        // 不存在被选数组
        if (![self.checkeds containsObject:check]) {
            // 取出上一行模型
            NSArray *arr = [self getDatasForSection:_currenIndexPath.section];
            id<HMCheckPotocol> currenCheck = arr[_currenIndexPath.row];
            currenCheck.isCheck = NO;
            [tableView reloadRowsAtIndexPaths:@[_currenIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            _currenIndexPath = indexPath;
            
            [self.checkeds removeAllObjects];
            
            // 选中当行
            check.isCheck = YES;
        }
        
    }else{// 多选
        check.isCheck = !check.isCheck;
    }
    
    // 刷新点击的行
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    NSLog(@"%@%@",@[@"移除", @"选中"][check.isCheck], check.title);
    // NSLog(@"%@",self.checkeds);
    if([self.delegate respondsToSelector:@selector(checkViewClick:checkeds:)]){
        [self.delegate checkViewClick:self checkeds:self.checkeds];
    }
}

// 索引列点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
//    NSLog(@"===%@  ===%zd",title, index);
    
    //弹出首字母提示
    [self setCharacterAnimation:title];
    
    //点击索引，列表跳转到对应索引的行
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    return index;
    
}

// 每一组的标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //标题文字
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.backgroundColor = [UIColor colorWithWhite:0.921 alpha:1.000];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont boldSystemFontOfSize:kHeadTitleFontSize];
    titleLabel.frame = CGRectMake(kHeadTitleLeftMargin, 0, kSCREEN_WIDTH, kHeadTitleFontSize);
    titleLabel.text = [NSString stringWithFormat:@"\t%@",[self.indexs objectAtIndex:section]];
    titleLabel.textColor = kContactListColor;
    return titleLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeadTitleFontSize + kHeadTitleTopBottomMargin;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kHeadTitleTopBottomMargin;
}
#pragma mark - Private
- (NSArray *)getDatasForSection:(NSInteger)section
{
    NSString *index = self.indexs[section];// 通过section拿到对应的索引
    return [self.indexDict objectForKey:index];// 通过这个索引获得对应的Array
}

- (void)reloadData
{
    [self.tableView reloadData];
}

#pragma mark - setter/getter
- (void)setMultipleCheck:(BOOL)multipleCheck
{
    _multipleCheck = multipleCheck;
    
    [self.tableView reloadData];
}
- (void)setShowCheckMark:(BOOL)showCheckMark
{
    _showCheckMark = showCheckMark;
    [self.tableView reloadData];
}
- (void)setShowIndexs:(BOOL)showIndexs
{
    _showIndexs = showIndexs;
    [self.tableView reloadData];
}
- (void)setChecks:(NSArray<id<HMCheckPotocol>> *)checks
{
    _checks = checks;
    self.indexs = nil;
    self.indexDict = nil;
    
    [self makeIndexs];
    
    [self.tableView reloadData];
}

// 重组数据源(带索引)
- (void)makeIndexs
{
    
    for (int i = 0; i < self.checks.count; i++) {
        
        id<HMCheckPotocol> check = [self.checks objectAtIndex:i];
        
        if (!check || [self.filters containsObject:check.title]) continue;
        
        NSString *title = check.title;
        
        char pinYin;
        if (title.length == 0) {
            pinYin = '#';
        }else{
            if (IsLetter([title characterAtIndex:0])) {//判断是否字母
                pinYin = [title characterAtIndex:0];
            }else
            {
                //把汉字取出首字母
                pinYin = pinyinFirstLetter([title characterAtIndex:0]);
            }
        }
        
        //重组数据结构
        NSString *s = [[NSString stringWithFormat:@"%c",pinYin] uppercaseString];
        id rowArray = [self.indexDict objectForKey:s];
        if (rowArray) {
            [rowArray addObject:check];
        }else{
            NSMutableArray *Arr = [NSMutableArray arrayWithObject:check];
            [self.indexDict setObject:Arr forKey:s];
        }
        
    }
    
    // 给索引排序
    self.indexs = [[self.indexDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

#pragma mark UITableView Section Index Animation
- (void)setCharacterAnimation:(NSString *)titleStr
{
    self.characterLabel.text = titleStr;
    if(self.characterLabel.superview == nil){
        [[UIApplication sharedApplication].keyWindow addSubview:self.characterLabel];
        
        [self.characterLabel showScalesAnimation];
        [self performSelector:@selector(checkCharacterLockAndisRemove) withObject:nil afterDelay:0.8];
        
    }else{
        _character_num ++;
        [self performSelector:@selector(checkCharacterLockAndisRemove) withObject:nil afterDelay:0.8];
    }
}

- (BOOL)checkCharacterLockAndisRemove
{
    if(_character_num != 0){
        _character_num--;
        return YES;
    }else{
        [self.characterLabel disScalesAnimation];
        [self.characterLabel performSelector:@selector(removeFromSuperview) withObject:self afterDelay:0.3];
        return NO;
    }
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.tableFooterView = [[UIView alloc] init];
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        // 注册cell
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HMCheckCell class]) bundle:nil] forCellReuseIdentifier:HMCheckCellID];
        tableView.rowHeight = 49;
        
        CGFloat top = kHeadTitleTopBottomMargin + kHeadTitleFontSize;
        [tableView setContentInset:UIEdgeInsetsMake(top, 0, 0, 0)];
        [tableView setContentOffset:CGPointMake(0, -top)];

        //设置索引列文本的颜色
        tableView.sectionIndexColor = HMRGB(137, 137, 137);
        tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
//        tableView.sectionIndexTrackingBackgroundColor = [UIColor whiteColor];
        
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray<id<HMCheckPotocol>> *)checkeds
{
    if (_checkeds == nil) {
        _checkeds = [NSMutableArray array];
    }
    return _checkeds;
}
- (NSArray *)indexs
{
    if (_indexs == nil) {
        _indexs = [NSArray array];
    }
    return _indexs;
}
- (NSMutableDictionary *)indexDict
{
    if (_indexDict == nil) {
        _indexDict = [NSMutableDictionary dictionary];
    }
    return _indexDict;
}
- (UILabel *)characterLabel
{
    if (_characterLabel == nil) {
        
        CGFloat characterLabelWH = 60.0;
        UILabel *characterLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH - characterLabelWH) / 2, 230, characterLabelWH, characterLabelWH)];
        characterLabel.backgroundColor = [UIColor colorWithRed:0.220 green:0.672 blue:0.265 alpha:0.8];
        characterLabel.opaque = NO;
        characterLabel.font = [UIFont boldSystemFontOfSize:28];
        characterLabel.textColor = [UIColor whiteColor];
        characterLabel.textAlignment = NSTextAlignmentCenter;
        characterLabel.layer.cornerRadius = 2.0;
        characterLabel.layer.masksToBounds = YES;
        _characterLabel = characterLabel;
    }
    return _characterLabel;
}
@end
