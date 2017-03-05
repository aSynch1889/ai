//
//  ISVSearchCell.h
//  ISV
//
//  Created by aaaa on 15/12/16.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISVSearchPotocol.h"

@interface ISVSearchCell : UITableViewCell
@property (nonatomic, strong) id<ISVSearchPotocol> model;
@end
