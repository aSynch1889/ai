//
//  HMBaseFormSwitch.m
//  HealthMall
//
//  Created by qiuwei on 15/11/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMBaseFormSwitch.h"

@interface HMBaseFormSwitch ()<HMSwitchViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation HMBaseFormSwitch

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
    self.switchView.delegate = self;
}


- (void)setFormItem:(HMBaseFormItemModel *)formItem
{
    _formItem = formItem;
    
    self.titleLabel.text = formItem.title;
    self.switchView.switchs = formItem.switchs;
    
    // 默认选中某一项
    self.switchView.selectedIndex = 0;
    self.switchView.selectedIndex = formItem.selectedIndex;
    
    if (formItem.isImportant) {
        self.titleLabel.textColor = [UIColor redColor];
    }
    // 只读
    if(formItem.readonly){
        self.switchView.userInteractionEnabled = NO;
    }
}

#pragma mark - <HMSwitchViewDelegate>
- (void)switchClick:(HMSwitchView *)switchView index:(NSUInteger)index
{
    [self.delegate switchClick:self index:index];
}
@end
