//
//  memberManagerTableViewCell.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/6.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface memberManagerTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *iconView;//!<  会员头像
@property (nonatomic, strong)UILabel *nameLabel;//!<  名称
@property (nonatomic, strong)UILabel *phoneLabel;//!<  电话
@property (nonatomic, strong)UILabel *amountLabel;//!<  储值
@property (nonatomic, strong)UILabel *integralLabel;//!<  积分

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
