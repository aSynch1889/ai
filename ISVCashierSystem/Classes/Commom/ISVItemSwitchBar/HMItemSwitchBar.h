//
//  HMItemSwitchBar.h
//  HealthMall
//
//  Created by jkl on 15/12/5.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMItemSwitchBar;
@protocol HMItemSwitchBarDelegate <NSObject>
- (void)itemSwitchBar:(HMItemSwitchBar *)bar didSelectedAtIndex:(NSInteger)index;
@end


/******** 带下划线按钮切换工具条 **********/
@interface HMItemSwitchBar : UIView
@property (nonatomic, weak) id <HMItemSwitchBarDelegate> delegate;

+ (instancetype)itemSwitchBarWithTitles:(NSArray *)titles;


/**
 * `设置第几个按钮被选中`
 */
- (void)setItemSelectedAtIndex:(NSInteger)index;


/**
 * `移动下滑线`
 *
 */

@end
