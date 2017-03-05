//
//  HMBaseFormItemLabel.m
//  HealthMall
//
//  Created by jkl on 15/12/12.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMBaseFormItemLabel.h"

@implementation HMBaseFormItemLabel

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

}

- (void)setFormItem:(HMBaseFormItemModel *)formItem
{
    _formItem = formItem;
    
    self.titleLabel.text = formItem.title;
    self.contentLabel.text = formItem.text;
    if (formItem.isImportant) {
        self.titleLabel.textColor = [UIColor redColor];
    }
    
}

@end
