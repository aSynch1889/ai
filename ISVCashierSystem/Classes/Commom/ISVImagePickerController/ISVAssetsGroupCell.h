//
//  ISVAssetsGroupCell.h
//  imgPicker
//
//  Created by aaaa on 16/1/5.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ISVAssetsGroupCell : UITableViewCell
@property (nonatomic,strong) ALAssetsGroup *group;
+ (instancetype)groupCell:(UITableView *)tableView;
@end
