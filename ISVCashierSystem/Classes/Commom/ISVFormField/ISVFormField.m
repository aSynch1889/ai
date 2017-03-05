//
//  ISVIndicatorField.m
//  ISV
//
//  Created by aaaa on 15/12/12.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVFormField.h"

@interface ISVFormField () <UITextFieldDelegate>

@end

@implementation ISVFormField

+ (instancetype)indicatorFieldWithPoint:(CGPoint)point tapBlock:(void (^)())block
{
    ISVFormField *field = [[self alloc] initWithFrame:CGRectMake(point.x, point.y, kSCREEN_WIDTH - point.x - 25, 30)];

    field.tapBlock = block;
    
    return field;
}

- (void)setTapBlock:(void (^)())block
{
    if (block == nil)
    {
        _tapBlock = nil;
        self.delegate = nil;
        return;
    }
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 9+5, 30)];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:
                             CGRectMake(0, 7, 9, 16)];
    // icon_JumpIndicator  9*16
    iconView.image = [UIImage imageNamed:@"icon_JumpIndicator"];
    [rightView addSubview:iconView];
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
    _tapBlock = block;
    self.delegate = self;
}


+ (instancetype)normalFieldWithPoint:(CGPoint)point
{
    return [self indicatorFieldWithPoint:point tapBlock:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = ISVRGB(243, 243, 243);
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 30)];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.font = [UIFont systemFontOfSize:14];
    self.textColor = ISVRGB(100, 100, 100);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.tapBlock();
    return NO;
}

@end
