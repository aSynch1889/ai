//
//  HMSearchBar.m
//  HealthMall
//
//  Created by jkl on 16/2/3.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "HMSearchBar.h"

@implementation HMSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 30);
//        self.backgroundColor = HMRGB(47, 189, 110);
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 30)];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.font = [UIFont systemFontOfSize:14];
        self.textColor = HMRGB(172, 228, 197);
        self.tintColor = HMRGB(172, 228, 197);
        self.returnKeyType = UIReturnKeySearch;
    }

    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: HMRGB(172, 228, 197)}];
}

@end
