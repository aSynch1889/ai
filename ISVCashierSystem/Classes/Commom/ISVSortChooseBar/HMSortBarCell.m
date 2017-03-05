//
//  HMSortChooseCell.m
//  HealthMall
//
//  Created by jkl on 15/11/17.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMSortBarCell.h"
#import "NSString+HMExtension.h"

@interface HMSortBarCell ()
@property (nonatomic, weak) UILabel *label;
@end

@implementation HMSortBarCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *reuseID = @"HMSortBarCell";
    HMSortBarCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = HMRGB(150, 150, 150);
        label.font = [UIFont systemFontOfSize:14];
        self.tintColor = HMMainlColor;
        [self.contentView addSubview:label];
        self.label = label;
    }
    
    return self;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    self.label.text = title;
}

- (void)setDidSelected:(BOOL)didSelected
{
    _didSelected = didSelected;
    
    if (didSelected)
    {
        self.label.textColor = HMMainlColor;
    } else
    {
        self.label.textColor = HMRGB(150, 150, 150);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 让排序列表cell的文字跟工具条排序按钮的文字左对齐
    CGFloat btnWidth = kSCREEN_WIDTH * 0.5 - 30;
    
    CGSize titleSize = [self.title sizeWithFont:kTitleFont maxSize:CGSizeMake(btnWidth, kTitleFont.lineHeight)];
    
    self.label.frame = CGRectMake(self.titleX, 0, titleSize.width, 43);
}

@end
