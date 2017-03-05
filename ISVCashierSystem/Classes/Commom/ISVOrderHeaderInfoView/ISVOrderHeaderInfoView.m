//
//  ISVOrderHeaderInfoView.m
//  ISV
//
//  Created by ISV005 on 15/12/1.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVOrderHeaderInfoView.h"
#import "Masonry.h"
#import "UIImage+ISVExtension.h"
#import "UIImageView+ISVUser.h"
#import <UIImageView+WebCache.h>

@interface ISVOrderHeaderInfoView ()

@property (nonatomic, strong) UIImageView* headerIcon;//头像
@property (nonatomic, strong) UILabel* nameLabel;//名字
@property (nonatomic, strong) UIButton* telephoneButton;//电话
@property (nonatomic, strong) UIImageView* sepImage;//分隔线
@property (nonatomic, strong) UIButton* messageButton;//短信
@property (nonatomic, copy) NSString* phoneNum;//联系号码

@end

@implementation ISVOrderHeaderInfoView

- (instancetype)initWithFrame:(CGRect)frame{

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
    self.backgroundColor = [UIColor whiteColor];
    [self.headerIcon setImage:kPlaceholder60_60];
    UITapGestureRecognizer *iconTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTapAction:)];
    [self.headerIcon addGestureRecognizer:iconTap];
    [self.messageButton addTarget:self action:@selector(messageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.telephoneButton addTarget:self action:@selector(telephoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 电话和短信功能
/**
 *  电话联系
 */
- (void)telephoneButtonClick:(UIButton *)button{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"拨打" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.phoneNum, nil];
    actionSheet.tag = 1;
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}
/**
 *  短信联系
 */
-(void)messageButtonClick:(UIButton *)button{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"发送短信" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.phoneNum, nil];
    actionSheet.tag = 2;
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}
/**
 *  调用系统方法，拨打电话，发送短信
 */
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            NSMutableString * str;
            str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.phoneNum];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }else if (actionSheet.tag == 2){
        if (buttonIndex == 0) {
            NSMutableString * str;
            str=[[NSMutableString alloc] initWithFormat:@"sms://%@",self.phoneNum];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
        }
    }

}

- (void)iconTapAction:(UITapGestureRecognizer *)tap{

    NSLog(@"--点击了详情的头像--1");
    if ([_delegate respondsToSelector:@selector(didUserTapIcon:userid:)]) {
        [_delegate didUserTapIcon:tap userid:_model.userId];
    }
    
}

#pragma mark - 设置模型
-(void)setModel:(ISVOrderHeaderInfoModel *)model{
    _model = model;
    self.phoneNum = _model.phoneNum;
    [self.headerIcon setHeaderPic:_model.avatorIcon];

    self.nameLabel.text = _model.name;
}

#pragma mark - 懒加载

- (UIImageView *)headerIcon{
    if (_headerIcon == nil) {
        UIImageView *imageview = [[UIImageView alloc]init];
        [self addSubview:imageview];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(20);
            make.width.with.height.mas_equalTo(60);

        }];
        imageview.userInteractionEnabled = YES;
        _headerIcon = imageview;
    }
    return _headerIcon;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = ISVFontSize(14.0);
        label.textColor = kColorBlackForText;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.headerIcon.mas_centerY);
            make.left.mas_equalTo(self.headerIcon.mas_right).offset(10);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(14);
        }];
        _nameLabel = label;
    }
    return _nameLabel;
}

-(UIButton *)telephoneButton{
    if (_telephoneButton == nil) {
        UIButton *button = [[UIButton alloc]init];
        button.pr_acceptEventInterval = 2;//间隔2秒允许点击
        [self addSubview:button];
        [button setImage:[UIImage imageNamed:@"myOrder_phone"] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.headerIcon.mas_centerY);
            make.right.mas_equalTo(self.sepImage.mas_left).offset(-20);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(26);
        }];
        _telephoneButton = button;

    }
    return _telephoneButton;
}

- (UIButton *)messageButton{
    if (_messageButton == nil) {
        UIButton *button = [[UIButton alloc]init];
        button.pr_acceptEventInterval = 2;
        [self addSubview:button];
        [button setImage:[UIImage imageNamed:@"myOrder_message"] forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-20);
            make.centerY.mas_equalTo(self.headerIcon.mas_centerY);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(18);
        }];
        _messageButton = button;

    }
    return _messageButton;
}

- (UIImageView *)sepImage{
    if (_sepImage == nil) {
        UIImageView *imageview= [[UIImageView alloc]init];
        [self addSubview:imageview];
        [imageview setImage:[UIImage createImageWithColor:kColorBlackPercent20]];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.headerIcon.mas_centerY);
            make.right.mas_equalTo(self.messageButton.mas_left).offset(-22);;
            make.width.mas_equalTo(2);
            make.height.mas_equalTo(24);
        }];
        _sepImage = imageview;

    }
    return _sepImage;
}

@end
