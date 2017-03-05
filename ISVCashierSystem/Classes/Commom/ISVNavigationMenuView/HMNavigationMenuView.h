//
//  HMNavigationMenuView.h
//  test
//
//  Created by healthmall005 on 15/12/2.
//  Copyright © 2015年 healthmall005. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMMenuTable.h"

@protocol HMNavigationMenuDelegate <NSObject>
/**
 *  代理方法，判断选择的是下拉列表哪一行
 */
- (void)didSelectItemAtIndex:(NSUInteger)index;

@end

@interface HMNavigationMenuView : UIView <HMMenuDelegate>

@property (nonatomic, weak) id <HMNavigationMenuDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
/**
 *  初始化frame和title
 *
 *  @param frame <#frame description#>
 *  @param title <#title description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
/**
 *  需要将视图显示在哪个视图上
 */
- (void)displayMenuInView:(UIView *)view;
@end
