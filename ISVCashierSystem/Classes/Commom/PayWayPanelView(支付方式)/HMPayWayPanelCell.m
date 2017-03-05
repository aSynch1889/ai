//
//  HMPayWayPanelCell.m
//  HealthMall
//
//  Created by qiuwei on 16/1/22.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "HMPayWayPanelCell.h"
#import "HMPayWayModel.h"
#import <UIImageView+WebCache.h>

#define kPayWayiconName @{@(1):@"icon_alipay",@(2):@"icon_wechat",@(3):@"icon_quickPay"}
#define kPayWayPanelMargin 30.0

@interface HMPayWayPanelCell ()
@property (nonatomic, weak) UIButton *checkView;
@property (nonatomic, weak) UIView *lineView;
@end

@implementation HMPayWayPanelCell

#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
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
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    self.accessoryView = self.checkView;
    self.textLabel.textColor = ISVRGB(92, 92, 92);
    self.textLabel.font = ISVFontSize(14.0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.x = kPayWayPanelMargin;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
    self.accessoryView.x = self.width - (20 + kPayWayPanelMargin);
    self.lineView.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
}

- (void)setModel:(HMPayWayModel *)model
{
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:[kPayWayiconName objectForKey:@(model.ID)]]];
    self.textLabel.text = model.name;
    self.checkView.selected = model.isCheck;
}

- (void)setHiddenLine:(BOOL)hiddenLine
{
    self.lineView.hidden = hiddenLine;
    self.checkView.hidden = hiddenLine;
}

#pragma mark - 懒加载
- (UIButton *)checkView
{
    if (_checkView == nil) {
        UIButton *checkView = [UIButton buttonWithType:UIButtonTypeCustom];
        checkView.frame = CGRectMake(0, 0, 20, 20);
        checkView.contentMode = UIViewContentModeCenter;
        [checkView setImage:[UIImage imageNamed:@"List_Button_NotSelected"] forState:UIControlStateNormal];
        [checkView setImage:[UIImage imageNamed:@"myWallet_progress_now"] forState:UIControlStateSelected];
        checkView.userInteractionEnabled = NO;
        [self.contentView addSubview:checkView];
        _checkView = checkView;
    }
    return _checkView;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = kDefaultLineColor;
        [self addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}
@end
