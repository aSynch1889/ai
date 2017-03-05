//
//  ISVSearchBar.m
//  ISV
//
//  Created by aaaa on 16/2/3.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "ISVSearchBar.h"

@implementation ISVSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 30);
//        self.backgroundColor = ISVRGB(47, 189, 110);
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 30)];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.font = [UIFont systemFontOfSize:14];
        self.textColor = ISVRGB(172, 228, 197);
        self.tintColor = ISVRGB(172, 228, 197);
        self.returnKeyType = UIReturnKeySearch;
    }

    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: ISVRGB(172, 228, 197)}];
}

@end
