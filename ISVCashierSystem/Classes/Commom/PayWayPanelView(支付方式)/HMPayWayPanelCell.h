//
//  HMPayWayPanelCell.h
//  HealthMall
//
//  Created by qiuwei on 16/1/22.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMPayWayModel;

@interface HMPayWayPanelCell : UITableViewCell

@property (nonatomic, strong) HMPayWayModel *model;

- (void)setHiddenLine:(BOOL)hiddenLine;

@end
