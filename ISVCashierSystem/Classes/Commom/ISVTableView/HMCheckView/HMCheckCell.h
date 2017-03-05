//
//  HMCheckCell.h
//  HealthMall
//
//  Created by qiuwei on 15/11/17.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCheckPotocol.h"

@interface HMCheckCell : UITableViewCell
@property (nonatomic, strong) id<HMCheckPotocol> check;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, assign, getter=isShowCheckMark) BOOL showCheckMark; // 是否显示选中标记 默认NO
@end
