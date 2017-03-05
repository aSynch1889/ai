//
//  HMMenuTable.m
//  test
//
//  Created by healthmall005 on 15/12/2.
//  Copyright © 2015年 healthmall005. All rights reserved.
//

#import "HMMenuTable.h"
#import "HMMenuConfiguration.h"
#import "UIColor+HMExtension.h"
#import "HMMenuCell.h"
#import <QuartzCore/QuartzCore.h>

@interface HMMenuTable ()
@property (nonatomic, assign) NSInteger currentRow;
@end

@implementation HMMenuTable

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = [NSArray arrayWithArray:items];
        
//        self.layer.backgroundColor = [UIColor color:[HMMenuConfiguration mainColor] withAlpha:0.0].CGColor;
        self.clipsToBounds = YES;
        
        endFrame = self.bounds;
        startFrame = endFrame;
        startFrame.origin.y -= self.items.count*[HMMenuConfiguration itemCellHeight];
        
        self.table = [[UITableView alloc] initWithFrame:startFrame style:UITableViewStylePlain];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.backgroundColor = [UIColor clearColor];
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.table.bounds.size.height, [HMMenuConfiguration menuWidth], self.table.bounds.size.height)];
        header.backgroundColor = [UIColor color:[HMMenuConfiguration itemsColor] withAlpha:[HMMenuConfiguration menuAlpha]];
//        [self.table addSubview:header];
        
    }
    return self;
}

- (void)show
{
    [self addSubview:self.table];
    if (!self.table.tableFooterView) {
        [self addFooter];
    }
    [UIView animateWithDuration:[HMMenuConfiguration animationDuration] animations:^{
//        self.layer.backgroundColor = [UIColor color:[HMMenuConfiguration mainColor] withAlpha:[HMMenuConfiguration backgroundAlpha]].CGColor;
        self.table.frame = endFrame;
        self.table.contentOffset = CGPointMake(0, [HMMenuConfiguration bounceOffset]);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
            self.table.contentOffset = CGPointMake(0, 0);
        }];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
        self.table.contentOffset = CGPointMake(0, [HMMenuConfiguration bounceOffset]);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[HMMenuConfiguration animationDuration] animations:^{
//            self.layer.backgroundColor = [UIColor color:[HMMenuConfiguration mainColor] withAlpha:0.0].CGColor;
            self.table.frame = startFrame;
        } completion:^(BOOL finished) {
            //            [self.table deselectRowAtIndexPath:currentIndexPath animated:NO];
            HMMenuCell *cell = (HMMenuCell *)[self.table cellForRowAtIndexPath:currentIndexPath];
            [cell setSelected:NO withCompletionBlock:^{
                
            }];
            currentIndexPath = nil;
            [self removeFooter];
            [self.table removeFromSuperview];
            [self removeFromSuperview];
        }];
    }];
}
/**
 *  弹性动画持续时间
 */
- (float)bounceAnimationDuration
{
    float percentage = 28.57;
    return [HMMenuConfiguration animationDuration]*percentage/100.0;
}

- (void)addFooter
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [HMMenuConfiguration menuWidth], self.table.bounds.size.height - (self.items.count * [HMMenuConfiguration itemCellHeight]))];
    self.table.tableFooterView = footer;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTap:)];
    [footer addGestureRecognizer:tap];
}

- (void)removeFooter
{
    self.table.tableFooterView = nil;
}

- (void)onBackgroundTap:(id)sender
{
    [self.menuDelegate didBackgroundTap];
}

- (void)dealloc
{
    self.items = nil;
    self.table = nil;
    self.menuDelegate = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HMMenuConfiguration itemCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    HMMenuCell *cell = (HMMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[HMMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
//    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    cell.title = [self.items objectAtIndex:indexPath.row];
    
    cell.checked = indexPath.row == self.currentRow;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    currentIndexPath = indexPath;
    self.currentRow = indexPath.row;
    [tableView reloadData];
//    [self removeFromSuperview];
    
    HMMenuCell *cell = (HMMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES withCompletionBlock:^{
        [self.menuDelegate didSelectItemAtIndex:indexPath.row];
    }];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMMenuCell *cell = (HMMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO withCompletionBlock:^{
        
    }];
}


@end
