//
//  ISVMenuCell.m
//  test
//
//  Created by ISV005 on 15/12/2.
//  Copyright © 2017年 ISV005. All rights reserved.
//

#import "ISVMenuCell.h"
#import "ISVMenuConfiguration.h"
#import "UIColor+ISVExtension.h"
#import <QuartzCore/QuartzCore.h>

@interface ISVMenuCell ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *iconView;
@end

@implementation ISVMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.contentView.backgroundColor = [UIColor color:[ISVMenuConfiguration itemsColor] withAlpha:[ISVMenuConfiguration menuAlpha]];
//        self.textLabel.textColor = [ISVMenuConfiguration itemTextColor];
//        self.textLabel.textAlignment = NSTextAlignmentCenter;
//        self.textLabel.font = ISVFontSize(14);
//        self.selectionStyle = UITableViewCellEditingStyleNone;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 40)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = kColorBlackForText;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIImage *icon = [UIImage imageNamed:@"icon_selected"]; // 13*10
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+30, (40-10)*0.5, 13, 10)];
        iconView.image = icon;
        iconView.hidden = YES;
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        
        self.separatorInset = UIEdgeInsetsZero;
        if ([self respondsToSelector:@selector(setLayoutMargins:)])
        {
            self.layoutMargins = UIEdgeInsetsZero;
        }
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.0f);
    
    CGContextSetRGBStrokeColor(ctx, 196/255.f, 196/255.f, 196/255.f, 0.7f);
    CGContextMoveToPoint(ctx, 0, self.contentView.bounds.size.height);
    CGContextAddLineToPoint(ctx, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    CGContextStrokePath(ctx);
    
    CGContextSetRGBStrokeColor(ctx, 196/255.f, 196/255.f, 196/255.f, 0.7f);
    
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, self.contentView.bounds.size.width, 0);
    CGContextStrokePath(ctx);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setSelected:(BOOL)selected withCompletionBlock:(void (^)())completion
{
    float alpha = 0.0;
    if (selected) {
        alpha = 0.5;
    } else {
        alpha = 0.0;
    }
    [UIView animateWithDuration:[ISVMenuConfiguration selectionSpeed] animations:^{
        
    } completion:^(BOOL finished) {
        completion();
    }];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    CGSize size =[title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.titleLabel.frame.size.height)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName:ISVFontSize(14)}
                                                              context:nil].size;
    
    NSLog(@"size.width=%f, size.height=%f", size.width, size.height);
    //根据计算结果重新设置UILabel的尺寸
    [self.titleLabel setFrame:CGRectMake((kSCREEN_WIDTH - size.width)/2, 0, size.width, 40)];
    self.titleLabel.text = title;
    
    [self.iconView setFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10, (40-10)*0.5, 13, 10)];
    
}

- (void)setChecked:(BOOL)checked
{
    _checked = checked;
    
    if (checked)
    {
        self.titleLabel.textColor = ISVMainColor;
        self.iconView.hidden = NO;
    }
    else
    {
        self.titleLabel.textColor = kColorBlackForText;
        self.iconView.hidden = YES;
    }
}

@end
