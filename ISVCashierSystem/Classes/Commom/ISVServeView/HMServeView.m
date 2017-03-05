//
//  HMServeView.m
//  HealthMall
//
//  Created by johnWu on 16/1/1.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import "HMServeView.h"
#import "HMRegimenModel.h"
#import "HMItemServerBuuton.h"

@interface HMServeView()

@property (nonatomic, strong) NSArray *serverList;
@property (nonatomic, strong) NSArray *iconList;
@property (nonatomic, strong) NSArray *iconSelectArray;

@property (nonatomic, weak) UILabel *serveLable;

@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation HMServeView

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
    
    UILabel *serveLable = [[UILabel alloc] init];
    [self addSubview:serveLable];
    serveLable.text = @"特色服务";
    _serveLable = serveLable;
    
    self.serverList = @[@"Wi-Fi",@"刷卡",@"停车场",@"储物",@"场地卖品",@"等候区",@"温泉池",@"发票",@"洗浴"];
    self.iconList = @[@"home_icon_Wi-Fi_nor", @"home_icon_CreditCard_nor", @"home_icon_ParkingLot_nor", @"home_icon_locker_nor", @"home_icon_shopping_nor", @"home_icon_WaitingArea_nor", @"home_icon_HotSpring_nor", @"home_icon_Invoice_nor",@"home_icon_bath_nor"];
    self.iconSelectArray = @[@"home_icon_Wi-Fi_sel", @"home_icon_CreditCard_sel", @"home_icon_ParkingLot_sel", @"home_icon_locker_sel", @"home_icon_shopping_sel", @"home_icon_WaitingArea_sel", @"home_icon_HotSpring_sel", @"home_icon_Invoice_sel",@"home_icon_bath_sel"];
    
    for (int i=0;i<self.serverList.count;i++) {
        
        HMItemServerBuuton *button = [[HMItemServerBuuton alloc] init];
        [button setTitle:self.serverList[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:9];
        [button setTag:i];
        [button setImage:[UIImage imageNamed:self.iconList[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.iconSelectArray[i]] forState:UIControlStateSelected];
        button.userInteractionEnabled = NO;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttons addObject:button];
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //特色服务
    self.serveLable.frame = CGRectMake(20, 5, 100, 14);
    
    CGFloat buttonW = 50;
    CGFloat buttonH = 55;
    for (int i = 0; i < self.buttons.count; i++) {
        HMItemServerBuuton *button = self.buttons[i];
        CGFloat row = i/5;
        CGFloat rol = i%5;
        CGFloat marge = ((self.width - 40) -5*buttonW)/4.0;
        [button setFrame:CGRectMake(20 +(buttonW +marge)*rol , CGRectGetMaxY(self.serveLable.frame) + 10 + (4+(buttonH +10))*row, buttonW, buttonH)];
    }
    self.serveLable.font = ISVFontSize(14);
    self.serveLable.textColor = kColorBlackForText;
    self.height = CGRectGetMaxY(self.serveLable.frame) + (buttonH + 10) * 2;
}

#pragma mark - Event
- (void)buttonClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (button.tag == 0) {
        _servers.WIFI = button.selected;
    }else if (button.tag == 1) {
        _servers.POS = button.selected;
    }else if (button.tag == 2) {
        _servers.Parking = button.selected;
    }else if (button.tag == 3) {
        _servers.Store = button.selected;
    }else if (button.tag == 4) {
        _servers.Sale = button.selected;
    }else if (button.tag == 5) {
        _servers.RestArea = button.selected;
    }else if (button.tag == 6) {
        _servers.SportsShop = button.selected;
    }else if (button.tag == 7) {
        _servers.Invoice = button.selected;
    }else if (button.tag == 8) {
        _servers.Bath = button.selected;
    }
    
    if ([_delegate respondsToSelector:@selector(didClickServeViewAtIndex:isSelected:)]) {
        [_delegate didClickServeViewAtIndex:button.tag isSelected:button.selected];
    }
}
#pragma mark - setter/getter
- (void)setShouldEdit:(BOOL)shouldEdit
{
    _shouldEdit = shouldEdit;
    for (int i = 0; i < self.buttons.count; i++) {
        HMItemServerBuuton *button = self.buttons[i];
        button.userInteractionEnabled = shouldEdit;
    }
}

- (void)setServers:(hm_pav_specialservices *)servers
{
    _servers = servers;

    UIButton *WIFI = self.buttons[0];
    WIFI.selected = _servers.WIFI;
    UIButton *POS = self.buttons[1];
    POS.selected = _servers.POS;
    UIButton *Parking = self.buttons[2];
    Parking.selected =_servers.Parking;
    UIButton *Store = self.buttons[3];
    Store.selected = _servers.Store;
    UIButton *Sale = self.buttons[4];
    Sale.selected = _servers.Sale;
    UIButton *RestArea = self.buttons[5];
    RestArea.selected = _servers.RestArea;
    UIButton *SportsShop = self.buttons[6];
    SportsShop.selected =_servers.SportsShop;
    UIButton *Invoice = self.buttons[7];
    Invoice.selected = _servers.Invoice;
    UIButton *Bath = self.buttons[8];
    Bath.selected = _servers.Bath;
    
}

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

@end
