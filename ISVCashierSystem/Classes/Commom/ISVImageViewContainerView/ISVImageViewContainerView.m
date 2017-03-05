//
//  ISVImageViewContainerView.m
//  ISV
//
//  Created by aaaa on 15/11/24.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVImageViewContainerView.h"

@interface ISVImageViewContainerView ()
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ISVImageViewContainerView

+ (instancetype)containerView;
{
    return [ISVImageViewContainerView viewFromXib];
}

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
    self.deleteButton.hidden = YES;
    self.checkImageView.hidden = YES;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self addGestureRecognizer:tapGR];
    
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPressGR];
    
}

#pragma mark - setter/getter
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

- (void)setType:(ISVImageViewContainerViewType)type
{
    _type = type;
    self.deleteButton.hidden = YES;
    self.checkImageView.hidden = YES;
    
    if (type == ISVImageViewContainerViewTypeDelete) {
        self.deleteButton.hidden = NO;
    }else if (type == ISVImageViewContainerViewTypeChecked) {
        self.checkImageView.hidden = NO;
    }
    
}
- (void)setCoverAlpha:(CGFloat)coverAlpha
{
    _coverAlpha = coverAlpha;
    self.coverView.alpha = coverAlpha;
}

- (void)setContentMode:(UIViewContentMode)contentMode
{
    [super setContentMode:contentMode];
    self.imageView.contentMode = contentMode;
}
#pragma mark - Event
// 点击删除按钮
- (IBAction)deleteClick:(UIButton *)sender
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(deleteImageViewContainerView:)]) {
        [self.delegate deleteImageViewContainerView:self];
    }
}
// 点击覆盖层
- (void)click:(UITapGestureRecognizer *)tapGesture
{
    if ([self.delegate respondsToSelector:@selector(clickImageViewContainerView:)]) {
        [self.delegate clickImageViewContainerView:self];
    }
}

// 长按手势
- (void)longPress:(UILongPressGestureRecognizer *)lpGesture
{
    if (lpGesture.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(clickImageViewContainerView:)]) {
            [self.delegate longPressImageViewContainerView:self];
        }
    }
}

@end
