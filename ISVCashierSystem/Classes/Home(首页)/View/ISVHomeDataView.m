//
//  ISVHomeDataView.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/8.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "ISVHomeDataView.h"

@implementation ISVHomeDataView


- (void)viewInit {
    _dayLabel = [[UILabel alloc]init];
    [self addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo((kSCREEN_WIDTH - 10 * 4)/3);
        make.height.mas_equalTo(22);
    }];
    _dayLabel.text = @"今日(元)";
    _dayLabel.font = ISVFontSize(12);
    
    _weekLabel = [[UILabel alloc]init];
    [self addSubview:_weekLabel];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_dayLabel.mas_centerY);
        make.left.mas_equalTo(_dayLabel.mas_right).offset(10);
        make.width.mas_equalTo(_dayLabel.mas_width);
        make.height.mas_equalTo(22);
    }];
    _weekLabel.text = @"本周(元)";
    _weekLabel.font = ISVFontSize(12);
    
    _monthLabel = [[UILabel alloc]init];
    [self addSubview:_monthLabel];
    [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_weekLabel.mas_centerY);
        make.left.mas_equalTo(_weekLabel.mas_right).offset(10);
        make.width.mas_equalTo(_dayLabel.mas_width);
        make.height.mas_equalTo(22);
    }];
    _monthLabel.text = @"本月(元)";
    _monthLabel.font = ISVFontSize(12);
    
    _dayAmountLabel = [[UILabel alloc]init];
    [self addSubview:_dayAmountLabel];
    [_dayAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_dayLabel.mas_bottom);
        make.centerX.mas_equalTo(_dayLabel.mas_centerX);
        make.width.mas_equalTo(_dayLabel.mas_width);
        make.height.mas_equalTo(22);
    }];
    _dayAmountLabel.font = ISVFontSize(12);
    
    _weekAmountLabel = [[UILabel alloc]init];
    [self addSubview:_weekAmountLabel];
    [_weekAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_dayAmountLabel.mas_centerY);
        make.centerX.mas_equalTo(_weekLabel.mas_centerX);
        make.width.mas_equalTo(_dayLabel.mas_width);
        make.height.mas_equalTo(22);
    }];
    _weekAmountLabel.font = ISVFontSize(12);
    
    _monthAmountLabel = [[UILabel alloc]init];
    [self addSubview:_monthAmountLabel];
    [_monthAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_dayAmountLabel.mas_centerY);
        make.centerX.mas_equalTo(_monthLabel.mas_centerX);
        make.width.mas_equalTo(_dayLabel.mas_width);
        make.height.mas_equalTo(22);
    }];
    _monthAmountLabel.font = ISVFontSize(12);
}

@end
