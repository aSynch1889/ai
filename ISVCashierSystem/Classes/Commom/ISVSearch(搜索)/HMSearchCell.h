//
//  HMSearchCell.h
//  HealthMall
//
//  Created by qiuwei on 15/12/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSearchPotocol.h"

@interface HMSearchCell : UITableViewCell
@property (nonatomic, strong) id<HMSearchPotocol> model;
@end
