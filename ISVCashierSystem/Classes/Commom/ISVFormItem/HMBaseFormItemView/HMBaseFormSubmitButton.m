//
//  HMBaseFormSubmitButton.m
//  HealthMall
//
//  Created by qiuwei on 15/11/15.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMBaseFormSubmitButton.h"

CGFloat const kButtonMargin = 30.0; // 左右间距
CGFloat const kButtonHeight = 35.0; // 高

@implementation HMBaseFormSubmitButton

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
    [self setBackgroundImage:[UIImage imageNamed:@"footButton_green_nor"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"footButton_green_hig"] forState:UIControlStateHighlighted];
    self.layer.cornerRadius = 5.0;
    self.titleLabel.font = HMFontSize(15.0);
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.frame = CGRectMake(kButtonMargin, 0, kSCREEN_WIDTH - 2 * kButtonMargin, kButtonHeight);

}

- (void)setBgtype:(HMBaseFormSubmitButtonType)bgtype
{
    _bgtype = bgtype;
    if (bgtype == HMBaseFormSubmitButtonTypeGreen) {
        [self setBackgroundImage:[UIImage imageNamed:@"footButton_green_nor"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"footButton_green_hig"] forState:UIControlStateHighlighted];
    }else if (bgtype == HMBaseFormSubmitButtonTypeRed) {
        [self setBackgroundImage:[UIImage imageNamed:@"footButton_red_nor"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"footButton_red_hig"] forState:UIControlStateHighlighted];
    }
}
@end
