//
//  ISVCustomSegView.h
//  ISVCashierSystem
//
//  Created by aaaa on 17/3/6.
//  Copyright © 2017年 ISV Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ISVCustomSegViewDelegate <NSObject>

- (void)D_selectedTag:(NSInteger)tag;

@end

@interface ISVCustomSegView : UIView


- (instancetype)initWithNumberOfTitles:(NSArray *)titles andFrame:(CGRect)frame delegate:(id<ISVCustomSegViewDelegate>)delegate;

@end
