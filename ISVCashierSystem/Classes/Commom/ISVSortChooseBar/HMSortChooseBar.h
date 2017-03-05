//
//  HMSortChooseBar.h
//  HealthMall
//
//  Created by jkl on 15/11/16.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMSortChooseBar;
@protocol HMSortChooseBarDelegate <NSObject>

/**
 * 点击综合排序
 * index: 0综合排序, 1距离排序, 2价格排序", 3评分排序
 */
- (void)sortChooseBar:(HMSortChooseBar *)sortChooseBar didSelectedAtIndex:(NSInteger)index;

/// 筛选
- (void)sortChooseBar:(HMSortChooseBar *)sortChooseBar didChoose:(NSDictionary *)dict;

@end



/******* 综合排序筛选工具条 *********/
@interface HMSortChooseBar : UIView

@property (nonatomic, weak) id <HMSortChooseBarDelegate> delegate;
/// 排序选项(默认为:综合排序, 距离排序, 价格排序, 评分排序)
@property (nonatomic, strong) NSArray *sortTitles;
/// 筛选标题数组
@property (nonatomic, strong) NSArray *chooseTitles;
/// 是否显示`运动时间`(默认不显示)
@property (nonatomic, assign) BOOL isShowTimeChoose;


/**
 * `排序筛选工具条`
 *  y:sortChooseBar的frame的y值(x和size是固定的)
 *  showView:用来显示列表的view(通常是控制器的view)
 *  showFrame:列表被展示出来后的frame
 */
+ (instancetype)sortChooseBarWithY:(CGFloat)y showView:(UIView *)showView showFrame:(CGRect)showFrame;

- (void)closeSortChooseBar;

@end
