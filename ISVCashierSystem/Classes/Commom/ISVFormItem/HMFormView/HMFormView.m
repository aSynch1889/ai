//
//  HMFormView.m
//  HealthMall
//
//  Created by qiuwei on 15/11/18.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMFormView.h"
#import "HMBaseFormItemModel.h"
#import "HMBaseFormItemFieldView.h"
#import "HMBaseFormItemTextView.h"
#import "HMTextField.h"
#import "HMPlaceholderTextView.h"
#import "BSKeyboardControls.h"
#import "HMBaseFormSwitch.h"

//static CGFloat const kFormItemFieldViewHeight = 40.0;
//static CGFloat const kFormItemTextViewHeight = 120.0;
//static CGFloat const kFormItemSwitchViewHeight = 40.0;

@interface HMFormView ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate, BSKeyboardControlsDelegate>
{
    CGFloat _lastItemMaxHeight;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *cellHeights; // 所有cell高度

@property (nonatomic, strong) NSMutableArray *formItemViews;    // 所有表单元素
@property (nonatomic, strong) NSMutableArray *fields;           // 所有textField或者textView
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@end

@implementation HMFormView

#pragma mark - 初始化
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
    // 监听键盘
    [self registerForKeyboardNotifications];
    
    // 禁止子控件自动布局
    self.tableView.tableFooterView.autoresizesSubviews = NO;
    _cellHeights = [NSMutableDictionary dictionary];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;

    _edgeInsets = self.tableView.contentInset;
//    self.tableView.tableHeaderView.height = _headViewHeight;
    self.tableView.tableFooterView.height = _footViewHeight;
    
    _lastItemMaxHeight = self.tableView.tableFooterView.y;
}

- (void)dealloc
{
    self.fields = nil;
    self.keyboardControls = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.formItems.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出当前模型
    HMBaseFormItemModel *formItem = self.formItems[indexPath.row];
    
    CGFloat h = formItem.height;
    
    if ([self.dataSource respondsToSelector:@selector(formView:heightForRowAtIndex:)]) {
        h = [self.dataSource formView:self heightForRowAtIndex:indexPath.row];
    }
    
    [_cellHeights setObject:@(h) forKey:@(indexPath.row)];
    
    return h;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const HMFormViewCellID = @"HMFormViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HMFormViewCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HMFormViewCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CGFloat cellH = [[_cellHeights objectForKey:@(indexPath.row)] doubleValue];
    
    UIEdgeInsets Insets = UIEdgeInsetsZero;
    if ([self.dataSource respondsToSelector:@selector(formView:edgeInsetsForRowAtIndex:)]) {
        Insets = [self.dataSource formView:self edgeInsetsForRowAtIndex:indexPath.row];
    }
    [cell.contentView removeAllSubviews];
    
    cell.frame = CGRectMake(Insets.left, Insets.top, self.width - Insets.left - Insets.right, cellH - Insets.top - Insets.bottom);
    
    UIView *itemView = [self.formItemViews objectAtIndex:indexPath.row];
    
    itemView.frame = cell.contentView.bounds;
    [cell.contentView addSubview:itemView];
    
    return cell;
}

// 解决iOS8默认15像素的空白问题
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEditing:YES];
    self.keyboardControls.activeField.layer.borderWidth = 0.0;
    self.keyboardControls.activeField = nil;
    
    if ([self.delegate respondsToSelector:@selector(formViewWillBeginDragging:)]) {
        [self.delegate formViewWillBeginDragging:self];
    }
}

#pragma mark -
#pragma mark Text Field Delegate

- (BOOL)textField:(HMTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(HMTextField *)textField
{
    [self setActiveStyleFromView:self.keyboardControls.activeField toView:textField];
    
    if (textField != self.keyboardControls.activeField) {
        [self.keyboardControls setActiveField:textField];
        return NO;
    }
    
    for (HMBaseFormItemFieldView *formItemview in self.formItemViews) {
        if ([formItemview isKindOfClass:[HMBaseFormItemFieldView class]]) {
            
            // 执行对应的textField的模型的block
            if (formItemview.textField == textField) {
                
                if (formItemview.formItem.actionBlock ) {
                    [self endEditing:YES];
                    
                    if ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
                        [self.delegate textFieldShouldBeginEditing:textField];
                    }
                    formItemview.formItem.actionBlock();
                    return NO;
                }
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:textField];
    }
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(HMTextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(HMTextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:textField];
    }
}
- (void)textFieldDidEndEditing:(HMTextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:textField];
    }
}
#pragma mark -
#pragma mark TextView Delegate
- (BOOL)textView:(HMPlaceholderTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(HMPlaceholderTextView *)textView
{

    [self setActiveStyleFromView:self.keyboardControls.activeField toView:textView];
    
    if (textView != self.keyboardControls.activeField) {
        [self.keyboardControls setActiveField:textView];
        return NO;
    }
    
    for (HMBaseFormItemTextView *formItemview in self.formItemViews) {

        if ([formItemview isKindOfClass:[HMBaseFormItemTextView class]]) {
            
            // 执行对应的textField的模型的block
            if (formItemview.textView == textView) {
                
                if (formItemview.formItem.actionBlock ) {
                    [self endEditing:YES];
                    
                    if ([self.delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
                        [self.delegate textViewShouldBeginEditing:textView];
                    }
                    
                    formItemview.formItem.actionBlock();
                    return NO;
                }
            }
        }

    }
    
    [self.keyboardControls setActiveField:textView];
    
    if ([self.delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.delegate textViewShouldBeginEditing:textView];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(HMPlaceholderTextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.delegate textViewShouldEndEditing:textView];
    }
    return YES;
}
- (void)textViewDidBeginEditing:(HMPlaceholderTextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.delegate textViewDidBeginEditing:textView];
    }
    
//    [self.keyboardControls setActiveField:textView];
}
- (void)textViewDidEndEditing:(HMPlaceholderTextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.delegate textViewDidEndEditing:textView];
    }
}

#pragma mark -
#pragma mark Keyboard Controls Delegate
- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction
{
    UIView *view;
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        view = field.superview.superview;
    } else {
        view = field.superview.superview.superview;
    }
    
    NSInteger index = [self.fields indexOfObject:field];
    if (direction == BSKeyboardControlsDirectionPrevious) {
        index ++;
        index = (index > self.fields.count) ? self.fields.count : index;
    }else{
        index --;
        index = (index < 0) ? 0 : index;
    }
    UIView *fromView = self.fields[index];
    [self setActiveStyleFromView:fromView toView:field];
    
    [self.tableView scrollRectToVisible:view.frame animated:YES];
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [self endEditing:YES];
    self.keyboardControls.activeField.layer.borderWidth = 0.0;
    self.keyboardControls.activeField = nil;
}

#pragma mark - Private
// 设置活跃中的样式
- (void)setActiveStyleFromView:(UIView *)fromView toView:(UIView *)toView
{
    fromView.layer.borderWidth = 0.0;
    toView.layer.borderWidth = kFieldBorderWidth;
    toView.layer.borderColor = kFieldBorderColor;
}

#pragma mark - setter/getter

- (void)setFormItems:(NSArray<HMBaseFormItemModel *> *)formItems
{
    _formItems = formItems;
    
    // 取出当前模型
    for (int i = 0; i < self.formItems.count; i++) {
        HMBaseFormItemModel *formItem = self.formItems[i];
        
        if (formItem.formItemType == HMBaseFormItemTypeField) {
            
            HMBaseFormItemFieldView *FieldView = [HMBaseFormItemFieldView viewFromXib];
            FieldView.textField.delegate = self;
            FieldView.formItem = formItem;
            FieldView.titleWidth = _titleWidth;
            [self.fields addObject:FieldView.textField];
            
            [self.formItemViews addObject:FieldView];
            
        }else if(formItem.formItemType == HMBaseFormItemTypeText){
            
            HMBaseFormItemTextView *itemTextView = [HMBaseFormItemTextView viewFromXib];
            itemTextView.textView.delegate = self;
            itemTextView.formItem = formItem;
            itemTextView.titleWidth = _titleWidth;
            [self.fields addObject:itemTextView.textView];
            
            [self.formItemViews addObject:itemTextView];

        }else if(formItem.formItemType == HMBaseFormItemTypeSwitch){

            HMBaseFormSwitch *sw = [HMBaseFormSwitch viewFromXib];
            formItem.switchs = formItem.switchs;
            sw.formItem = formItem;
            
            [self.formItemViews addObject:sw];
        }
    }
    
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:self.fields]];
    [self.keyboardControls setDelegate:self];
    [self.keyboardControls setTintColor:HMMainlColor];
    
    [self.tableView reloadData];
}

- (void)setTitleWidth:(CGFloat)titleWidth
{
    _titleWidth = titleWidth;
    [self.tableView reloadData];
}
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    self.tableView.contentInset = edgeInsets;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {

        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView = tableView;
        tableView.dataSource = self;
        tableView.delegate = self;
        
//        tableView.tableHeaderView = [[UIView alloc] init];
        tableView.tableFooterView = [[UIView alloc] init];

        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.showsHorizontalScrollIndicator = NO;
        
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        [self insertSubview:tableView atIndex:0];
    }
    return _tableView;
}

- (NSMutableArray *)fields
{
    if (_fields == nil) {
        _fields = [NSMutableArray array];
    }
    return _fields;
}

- (NSMutableArray *)formItemViews
{
    if (_formItemViews == nil) {
        _formItemViews = [NSMutableArray array];
    }
    return _formItemViews;
}

#pragma mark - Public
// 添加一个控件到第一个元素的上面
- (void)addSubviewOnHeadView:(UIView *)subView
{
    UIView *view = [[UIView alloc] init];
//    view.frame = subView.frame;
    view.frame = CGRectMake(0, 0, subView.frame.size.width, subView.frame.size.height);
    [view addSubview:subView];
    self.tableView.tableHeaderView = view;
}
// 添加一个控件到最后元素的下面
- (void)addSubviewOnFootView:(UIView *)subView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, subView.frame.size.width, subView.frame.size.height);
    [view addSubview:subView];
    self.tableView.tableFooterView = view;
//    [self.tableView.tableFooterView addSubview:subView];
}

/**
 *  获取某一项表单组件
 */
- (UIView *)itemViewForFormViewAtIndex:(NSUInteger)index
{
    return self.formItemViews[index];
}
// 获取某个文本框
- (UIView *)fieldForFormViewAtIndex:(NSUInteger)index
{
    return [self.fields objectAtIndex:index];
}
// 获取某一项的frame
- (CGRect)itemFrameForFormViewAtIndex:(NSUInteger)index
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return cell.frame;
}

- (void)reloadData
{
    [self.tableView reloadData];
}
#pragma mark - Private
// 监听键盘
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)aNotification
{
    // 是否真正显示在主窗口
    if(![self isShowingOnKeyWindow]) return;
    
    NSLog(@"keyboardWasShown Begin %@ \n edgeInsets.top:%f", NSStringFromUIEdgeInsets(self.tableView.contentInset), _edgeInsets.top);
    NSDictionary *info = [aNotification userInfo];
    // UIKeyboardFrameBeginUserInfoKey
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIView *activeField = self.keyboardControls.activeField;
    UIView *view = nil;
    
    if (!SYSTEM_VERSION_LESS_THAN(@"8.0")){ // 系统大于等于iOS8.0
        view = activeField.superview.superview.superview;
    }else{ // 系统小于iOS8.0
        view = activeField.superview.superview.superview.superview;
    }
    
    CGFloat y = CGRectGetMaxY(view.frame);// 当前cell的最大Y值
    CGFloat y2 =  CGRectGetMaxY(self.frame) - (kbSize.height + kKeyboardToolBarHeight);// 键盘y值
    if (y >= ABS(y2) && y < (ABS(y2) + kKeyboardToolBarHeight)) {
        kbSize.height += (kKeyboardToolBarHeight + 25.0);
    }

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(_edgeInsets.top, 0.0, kbSize.height , 0.0);

    self.tableView.scrollEnabled = YES;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    
    if ([activeField isKindOfClass:[UITextView class]] ) {
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your application might not need or want this behavior.
        // 除去键盘之外的范围
        CGRect aRect = self.frame;
        aRect.size.height -= kbSize.height;
        
        // 正在激活的视图最大范围
        CGPoint KeyboardOrigin = CGPointMake(view.frame.origin.x, CGRectGetMaxY(view.frame));
        
        // 这个点不在这个范围内 tableView就往上移动
        if (!CGRectContainsPoint(aRect, KeyboardOrigin)) {
            CGPoint scrollPoint = CGPointMake(0.0, KeyboardOrigin.y - aRect.origin.y - aRect.size.height);
            [self.tableView setContentOffset:scrollPoint animated:YES];
        }
    }
    
    NSLog(@"keyboardWasShown end %@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    // 是否真正显示在主窗口
    if(![self isShowingOnKeyWindow]) return;
    
    UIEdgeInsets contentInsets = _edgeInsets;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}

@end
