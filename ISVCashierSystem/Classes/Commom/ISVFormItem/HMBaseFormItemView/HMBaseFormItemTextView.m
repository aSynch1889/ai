//
//  HMBaseFormItemTextView.m
//  HealthMall
//
//  Created by qiuwei on 15/11/15.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMBaseFormItemTextView.h"

@interface HMBaseFormItemTextView ()
@property (weak, nonatomic) IBOutlet UIImageView *JumpIndicatorImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;
@end

@implementation HMBaseFormItemTextView

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
    self.textView.layer.cornerRadius = kFormItemTextFieldCornerRadius;
    self.textView.textLeftMargin = kFormItemTextLeftMargin;
    self.textView.placeholderColor = kFormItemPlaceholderColor;
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
    
    self.titleLabel.text = formItem.title;
    self.textView.text = formItem.text;
    if (formItem.isImportant) {
        self.titleLabel.textColor = [UIColor redColor];
    }
    
    // 跳转指示器
    self.JumpIndicatorImageView.hidden = !formItem.JumpIndicator;
    
    // 设置占位字体
    self.textView.placeholder = formItem.placeholder;
    
    // 只读
    if(formItem.readonly){
        self.titleLabel.textColor = self.textView.placeholderColor;
        self.textView.textColor = self.textView.placeholderColor;
        self.textView.editable = NO;
    }
}
- (void)setTitleWidth:(CGFloat)titleWidth
{
    _titleWidth = titleWidth;
    [self setNeedsLayout];
}
@end
