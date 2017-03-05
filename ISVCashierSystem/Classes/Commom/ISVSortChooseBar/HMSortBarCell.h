//
//  HMSortChooseCell.h
//  HealthMall
//
//  Created by jkl on 15/11/17.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTitleFont [UIFont systemFontOfSize:14]

/*******综合排序工具条自定义cell**********/
@interface HMSortBarCell : UITableViewCell
@property (nonatomic, copy) NSString *title;
/// 用于保持cell标题于按钮标题的左对齐
@property (nonatomic, assign) CGFloat titleX;
@property (nonatomic, assign) BOOL didSelected;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
