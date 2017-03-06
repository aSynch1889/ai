//
//  memberManagerTableViewCell.m
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/6.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import "memberManagerTableViewCell.h"

@implementation memberManagerTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"salesAnalysisTableViewCell";
    memberManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[self alloc] initWithStyle:0 reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(5);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        [_iconView setImage:[UIImage imageNamed:@"defaultIcon"]];
        
        _nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_iconView.mas_top);
            make.left.mas_equalTo(_iconView.mas_right).offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(22);
        }];
        _nameLabel.font = ISVFontSize(14);
        
        _phoneLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.mas_bottom);
            make.left.mas_equalTo(_nameLabel.mas_left);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(22);
        }];
        _phoneLabel.font = ISVFontSize(14);
        
        _amountLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_amountLabel];
        [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_iconView.mas_top);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(22);
        }];
        _amountLabel.font = ISVFontSize(14);

        _integralLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_integralLabel];
        [_integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.mas_bottom);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(22);
        }];
        _integralLabel.font = ISVFontSize(14);
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
