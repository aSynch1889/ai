//
//  HMItemPanelView.h
//  HealthMall
//
//  Created by jkl on 15/11/5.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMItemPanelView;

@protocol HMItemPanelViewDelegate <NSObject>
- (void)itemPanelView:(HMItemPanelView *)panelView didSelectedAtIndex:(NSInteger)index;
@end


/***********多排按钮****************/
@interface HMItemPanelView : UIView

@property (nonatomic, weak) id <HMItemPanelViewDelegate> delegate;

/**
 * titles:标题名数组
 * icons:图片名数组
 */
+ (instancetype)itemPanelViewWithTitles:(NSArray<NSString *> *)titles icons:(NSArray<NSString *> *)icons;

@end
