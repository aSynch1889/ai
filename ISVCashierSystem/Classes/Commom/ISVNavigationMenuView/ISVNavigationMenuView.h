//
//  ISVNavigationMenuView.h
//  test
//
//  Created by ISV005 on 15/12/2.
//  Copyright © 2017年 ISV005. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISVMenuTable.h"

@protocol ISVNavigationMenuDelegate <NSObject>
/**
 *  代理方法，判断选择的是下拉列表哪一行
 */
- (void)didSelectItemAtIndex:(NSUInteger)index;

@end

@interface ISVNavigationMenuView : UIView <ISVMenuDelegate>

@property (nonatomic, weak) id <ISVNavigationMenuDelegate> delegate;
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
