//
//  HMAssetsGroupCell.h
//  imgPicker
//
//  Created by qiuwei on 16/1/5.
//  Copyright © 2016年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface HMAssetsGroupCell : UITableViewCell
@property (nonatomic,strong) ALAssetsGroup *group;
+ (instancetype)groupCell:(UITableView *)tableView;
@end
