//
//  HMMenuTable.h
//  test
//
//  Created by healthmall005 on 15/12/2.
//  Copyright © 2015年 healthmall005. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HMMenuDelegate <NSObject>
/**
 *  代理方法，点击了背景视图
 */
- (void)didBackgroundTap;
/**
 *  选择了哪一行
 */
- (void)didSelectItemAtIndex:(NSUInteger)index;
@end

@interface HMMenuTable : UIView <UITableViewDelegate,UITableViewDataSource>
{
    CGRect endFrame;
    CGRect startFrame;
    NSIndexPath *currentIndexPath;
}
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *items;//下来列表title数组
@property (nonatomic, weak) id <HMMenuDelegate> menuDelegate;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items;
/**
 *  显示下拉列表
 */
- (void)show;
/**
 *  隐藏下拉列表
 */
- (void)hide;
@end
