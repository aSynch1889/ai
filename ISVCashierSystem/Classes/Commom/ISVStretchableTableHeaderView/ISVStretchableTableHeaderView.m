//
//  ISVStretchableTableHeaderView.m
//  ISV
//
//  Created by ISV005 on 15/11/23.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVStretchableTableHeaderView.h"

@implementation ISVStretchableTableHeaderView
{
    CGRect initialFrame;
    CGFloat defaultViewHeight;
    CGFloat defaultViewWidth;
}
- (void)stretchHeaderForTableView:(UITableView*)tableView withView:(UIView*)view
{
    _tableView = tableView;
    _view = view;
    
    initialFrame       = _view.frame;
    defaultViewHeight  = initialFrame.size.height;
    defaultViewWidth  = initialFrame.size.width;
    
    UIView* emptyTableHeaderView = [[UIView alloc] initWithFrame:initialFrame];
    _tableView.tableHeaderView = emptyTableHeaderView;
    
    [_tableView addSubview:_view];
}
/**
 *  scrollview滚动时处理tableview的headerview的拉伸
 *
 *  @param scrollView 
 */
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    CGRect f = _view.frame;
    f.size.width = _tableView.frame.size.width;
    _view.frame = f;
//    NSLog(@"prama++ %f ++1",scrollView.contentOffset.y);

    if(scrollView.contentOffset.y < -64) {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
//        NSLog(@"offsetY=== %f ==",offsetY);
        initialFrame.origin.y = offsetY * -1;
        initialFrame.origin.x = offsetY * - 1/2;
//        NSLog(@"prama-- %f  --1",initialFrame.origin.x);
        initialFrame.size.width = defaultViewWidth + offsetY;
        initialFrame.size.height = defaultViewHeight + offsetY;
        _view.frame = initialFrame;
    }
}

- (void)resizeView
{
    initialFrame.size.width = _tableView.frame.size.width;
    _view.frame = initialFrame;
}
@end
