//
//  ISVTextField.m
//  ISV
//
//  Created by aaaa on 15/11/15.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVTextField.h"

static NSString * const kPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

#define kDefaultPlaceholderColor [UIColor lightGrayColor] // 默认占位字符颜色
#define kDefaultTextLeftMargin 10.0 // 默认文本左边距

@interface ISVTextField ()
@property (nonatomic, assign) NSInteger maxLength;          // 限制最大字符长度
@property (nonatomic, copy) overflowBlock overflowBlock;    // 超出最大字符会调用
@property (nonatomic, copy) inputBlock inputBlock;    // 超出最大字符会调用

@end

@implementation ISVTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp
{
    // 实现左侧空出一定的边距，光标左移
    [self setTextFieldLeftPadding:self forWidth:kDefaultTextLeftMargin];

    if(self.placeholderColor == nil)
        self.placeholderColor = kDefaultPlaceholderColor;

    // 设置光标颜色和文字颜色一致
    self.tintColor = self.placeholderColor;

    // 不成为第一响应者
    [self resignFirstResponder];

    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// 实现左侧空出一定的边距，光标左移
- (void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}

#pragma mark - Private
- (void)textFieldTextDidChange:(NSNotification *)note
{
    if (!_maxLength) return;

    NSString *toBeString = self.text;
    UITextRange *selectedRange = [self markedTextRange];
    // 获取高亮部分
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];

    if (!position) {
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger dataLength = [[toBeString dataUsingEncoding:enc] length];
        if (dataLength > _maxLength) {
            int toBeLength = (int)[toBeString length];
            for (int i = 0; i < toBeLength; i++) {
                NSString *fromString = [toBeString substringToIndex:i];
                NSInteger fromLength = [[fromString dataUsingEncoding:enc] length];
                if (fromLength == _maxLength) {
                    self.text = fromString;
                }
            }
#warning 数字键盘的奔溃处理，暂时注释
            // 超出限制长度的block
//            ! _overflowBlock ? : _overflowBlock(self, [toBeString substringWithRange:NSMakeRange(-1, 1)]);
            ! _overflowBlock ? : _overflowBlock(self, nil);
            return;
        }else{
            self.text = toBeString;
            // 未超过时block
            ! _inputBlock ? : _inputBlock(self, toBeString);
        }
    }
    
}
- (void)keepToLength:(NSInteger)length inputBlock:(inputBlock)inputBlock overflowBlock:(overflowBlock)overflowBlock
{
    _maxLength = length ;//- 2 > 0 ? length - 2 : 0;
    _inputBlock = inputBlock;
    _overflowBlock = overflowBlock;
}

#pragma mark - setter/getter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setValue:placeholderColor forKeyPath:kPlacerholderColorKeyPath];
    [self setNeedsDisplay];
}
- (void)setTextLeftMargin:(CGFloat)textLeftMargin
{
    _textLeftMargin = textLeftMargin;
    [self setNeedsLayout];
}

-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 10, 0);
    
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 10, 0);
    
}

@end
