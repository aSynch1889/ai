//
//  HMBaseFormItemFieldView.m
//  HealthMall
//
//  Created by qiuwei on 15/11/15.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMBaseFormItemFieldView.h"

@interface HMBaseFormItemFieldView ()

@property (weak, nonatomic) IBOutlet UIImageView *JumpIndicatorImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;

@end

@implementation HMBaseFormItemFieldView

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
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.layer.cornerRadius = kFormItemTextFieldCornerRadius;
    self.textField.textLeftMargin = kFormItemTextLeftMargin;
    self.textField.placeholderColor = kFormItemPlaceholderColor;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_titleWidth > 0) {
        _labelWidth.constant = _titleWidth;
    }
}

- (void)setFormItem:(HMBaseFormItemModel *)formItem
{
    _formItem = formItem;
    
    // 设置占位字体
    self.textField.placeholder = formItem.placeholder;
    
    self.titleLabel.text = formItem.title;
    self.textField.text = formItem.text;
    if (formItem.isImportant) {
        self.titleLabel.textColor = [UIColor redColor];
    }
    
    // 跳转指示器
    self.JumpIndicatorImageView.hidden = !formItem.JumpIndicator;
    
    // 只读
    if(formItem.readonly){
        self.titleLabel.textColor = self.textField.placeholderColor;
        self.textField.textColor = self.textField.placeholderColor;
        self.textField.enabled = NO;
    }
}
- (void)setTitleWidth:(CGFloat)titleWidth
{
    _titleWidth = titleWidth;
    [self setNeedsLayout];
}
@end
