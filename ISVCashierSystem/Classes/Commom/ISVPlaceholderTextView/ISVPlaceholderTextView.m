//
//  ISVPlaceholderTextView.m
//  ISV
//
//  Created by aaaa on 15/11/4.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVPlaceholderTextView.h"

#define kDefaultPlaceholderColor [UIColor lightGrayColor] // 默认占位字符颜色

@interface ISVPlaceholderTextView ()

/** 占位文字label */
@property (nonatomic, weak) UILabel *placeholderLabel;

@property (nonatomic, assign) NSInteger maxLength;          // 限制最大字符长度
@property (nonatomic, copy) overflowTextViewBlock overflowBlock;    // 超出最大字符会调用
@property (nonatomic, copy) inputTextViewBlock inputBlock;    // 超出最大字符会调用

@end

@implementation ISVPlaceholderTextView

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
    // 垂直方向上永远有弹簧效果
    self.alwaysBounceVertical = YES;
    
//    // 默认字体
//    self.font = [UIFont systemFontOfSize:15];
    
    // 默认的占位文字颜色
    if(self.placeholderColor == nil)
        self.placeholderColor = kDefaultPlaceholderColor;
    
    // 监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];

}

- (void)dealloc
{
    self.placeholder = nil;
    self.placeholderLabel = nil;
    self.placeholderColor = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * 更新占位文字的尺寸
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLabel.x = _textLeftMargin;
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
    
    // 文本内容内边距
    self.textContainerInset = UIEdgeInsetsMake(self.placeholderLabel.y, self.placeholderLabel.x - 3, self.placeholderLabel.y, self.placeholderLabel.x);
}
#pragma mark - Private
/**
 * 监听文字改变
 */
- (void)textDidChange:(NSNotification *)note
{
    // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
    
    if (!_maxLength || !note) return;
    
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
- (void)keepToLength:(NSInteger)length inputBlock:(inputTextViewBlock)inputBlock overflowBlock:(overflowTextViewBlock)overflowBlock
{
    _maxLength = length;
    _inputBlock = inputBlock;
    _overflowBlock = overflowBlock;
}

#pragma mark - 重写setter
- (void)setTextLeftMargin:(CGFloat)textLeftMargin
{
    _textLeftMargin = textLeftMargin;
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    //self.text = nil;    // 如果设置占位文本，则清除文本
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange:nil];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange:nil];
}


#pragma mark - getter/setter
- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        // 添加一个用来显示占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

/**
 * #import "ISVPlaceholderTextView.h"
 @interface ISVHomeViewController () <UITextViewDelegate>
 // 文本输入控件 
@property (nonatomic, weak) ISVPlaceholderTextView *textView;
@end

@implementation ISVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    ISVPlaceholderTextView *textView = [[ISVPlaceholderTextView alloc] init];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
}
#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
 */

@end
