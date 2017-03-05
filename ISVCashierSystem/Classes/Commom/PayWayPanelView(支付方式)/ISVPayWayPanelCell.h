//
//  ISVPayWayPanelCell.h
//  ISV
//
//  Created by aaaa on 16/1/22.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISVPayWayModel;

@interface ISVPayWayPanelCell : UITableViewCell

@property (nonatomic, strong) ISVPayWayModel *model;

- (void)setHiddenLine:(BOOL)hiddenLine;

@end
