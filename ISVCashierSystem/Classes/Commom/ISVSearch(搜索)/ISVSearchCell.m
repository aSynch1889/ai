//
//  ISVSearchCell.m
//  ISV
//
//  Created by aaaa on 15/12/16.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVSearchCell.h"
#import "UIImageView+ISVUser.h"

@interface ISVSearchCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@end
@implementation ISVSearchCell

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
    
}

- (void)setModel:(id<ISVSearchPotocol>)model
{
    _model = model;
    self.nickNameLabel.text = model.title;
    if([model respondsToSelector:@selector(iconName)]){
        if (model.iconName.length) {
            self.headView.image = [UIImage imageNamed:model.iconName];
        }
    }else if([model respondsToSelector:@selector(iconUrlString)]){
        [self.headView setHeaderPic:model.iconUrlString];
    }
    
}

@end
