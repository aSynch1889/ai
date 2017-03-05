//
//  ISVItemPanelView.h
//  ISV
//
//  Created by aaaa on 15/11/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISVItemPanelView;

@protocol ISVItemPanelViewDelegate <NSObject>
- (void)itemPanelView:(ISVItemPanelView *)panelView didSelectedAtIndex:(NSInteger)index;
@end


/***********多排按钮****************/
@interface ISVItemPanelView : UIView

@property (nonatomic, weak) id <ISVItemPanelViewDelegate> delegate;

/**
 * titles:标题名数组
 * icons:图片名数组
 */
+ (instancetype)itemPanelViewWithTitles:(NSArray<NSString *> *)titles icons:(NSArray<NSString *> *)icons;

@end
