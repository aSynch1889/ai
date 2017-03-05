//
//  ISVItemSwitchBar.h
//  ISV
//
//  Created by aaaa on 15/12/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISVItemSwitchBar;
@protocol ISVItemSwitchBarDelegate <NSObject>
- (void)itemSwitchBar:(ISVItemSwitchBar *)bar didSelectedAtIndex:(NSInteger)index;
@end


/******** 带下划线按钮切换工具条 **********/
@interface ISVItemSwitchBar : UIView
@property (nonatomic, weak) id <ISVItemSwitchBarDelegate> delegate;

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
