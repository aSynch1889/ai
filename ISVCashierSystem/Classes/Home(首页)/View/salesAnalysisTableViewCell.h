//
//  salesAnalysisTableViewCell.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/4.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface salesAnalysisTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel *timeLabel;//!<  时间
@property (nonatomic, weak) UILabel *amountLabel;//!<  金额

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
