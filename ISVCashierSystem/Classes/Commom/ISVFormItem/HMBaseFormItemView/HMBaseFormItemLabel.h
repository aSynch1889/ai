//
//  HMBaseFormItemLabel.h
//  HealthMall
//
//  Created by jkl on 15/12/12.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMBaseFormItemModel.h"

@interface HMBaseFormItemLabel : UIView
@property (nonatomic, strong) HMBaseFormItemModel *formItem;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end
