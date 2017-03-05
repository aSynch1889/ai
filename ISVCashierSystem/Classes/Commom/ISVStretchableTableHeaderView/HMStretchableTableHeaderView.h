//
//  HMStretchableTableHeaderView.h
//  HealthMall
//
//  Created by healthmall005 on 15/11/23.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMStretchableTableHeaderView : NSObject
@property (nonatomic,retain) UITableView* tableView;
@property (nonatomic,retain) UIView* view;
/**
 *  设置tableview的头部视图可拉伸
 *
 *  @param tableView 需设置的tableview
 *  @param view      头部视图
 */
- (void)stretchHeaderForTableView:(UITableView*)tableView withView:(UIView*)view;
/**
 *  设置scrollview代理方法
 *
 *  @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView*)scrollView;
/**
 *  重新布局
 */
- (void)resizeView;
@end
