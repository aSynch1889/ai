//
//  HMCheckCell.m
//  HealthMall
//
//  Created by qiuwei on 15/11/17.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMCheckCell.h"
#import "UIImageView+HMUser.h"

@interface HMCheckCell ()

@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;

@end

@implementation HMCheckCell

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
    self.iconImageView.layer.cornerRadius = self.iconImageView.width * 0.5;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.backgroundColor = HMBackgroundColor;
    
}

- (void)setCheck:(id<HMCheckPotocol>)check
{
    _check = check;
    
    self.titleLabel.text = check.title;
    if([check respondsToSelector:@selector(iconName)] && check.iconName.length){

        UIImage *image = [UIImage imageNamed:check.iconName];
        self.iconImageView.image = image;
        
    }else if([check respondsToSelector:@selector(iconUrlString)]){
        [self.iconImageView setHeaderPic:check.iconUrlString];
    }

    NSString *checkImgNmae = @"noCheck";
    if (check.isCheck) {
        checkImgNmae = @"isCheck";
    }
    self.checkImageView.image = [UIImage imageNamed:checkImgNmae];
}

- (void)setShowCheckMark:(BOOL)showCheckMark
{
    _showCheckMark = showCheckMark;
    self.checkImageView.hidden = !self.isShowCheckMark;
}

@end
