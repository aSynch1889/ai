//
//  ISVMenuPopover.m
//  ISV
//
//  Created by aaaa on 15/11/7.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVMenuPopover.h"
#import <QuartzCore/QuartzCore.h>

#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

#define RIGHTM_ARGIN 10.0
#define MENU_ITEM_HEIGHT        28
#define FONT_SIZE               14.0
#define CELL_IDENTIGIER         @"ISVMenuPopoverCell"

#define SEPERATOR_LINE_RECT     CGRectMake(0, MENU_ITEM_HEIGHT - 1, self.frame.size.width, 1)

#define CONTAINER_BG_COLOR      RGBA(0, 0, 0, 0.f)

#define ZERO                    0.0f
#define ONE                     1.0f
#define ANIMATION_DURATION      0.5f

#define MENU_POINTER_TAG        1011
#define MENU_TABLE_VIEW_TAG     1012

#define LANDSCAPE_WIDTH_PADDING 35

@interface ISVMenuPopover () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,retain) NSArray *menuItems;
@property(nonatomic,retain) NSArray *imageItems;
@property(nonatomic,retain) UIImageView *bgView;
@property(nonatomic,retain)UITableView *menuItemsTableView;
@property(nonatomic,retain)UIImageView *menuPointerView;
- (void)hide;
- (void)addSeparatorImageToCell:(UITableViewCell *)cell;

@end

@implementation ISVMenuPopover

@synthesize menuPopoverDelegate;
@synthesize menuItems;
@synthesize imageItems;
@synthesize containerButton;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)aMenuItems andIconItems:(NSArray*)iconItems
{
    frame.origin.x -= RIGHTM_ARGIN;
    frame.size.width += RIGHTM_ARGIN;
    if (self = [super initWithFrame:frame])
    {
        self.menuItems = aMenuItems;
        self.imageItems = iconItems;
        
        // Adding Container Button which will take care of hiding menu when user taps outside of menu area
        self.containerButton = [[UIButton alloc] init];
        [self.containerButton setBackgroundColor:CONTAINER_BG_COLOR];
        [self.containerButton addTarget:self action:@selector(dismissMenuPopover) forControlEvents:UIControlEventTouchUpInside];
        [self.containerButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
        
        // Adding Menu Options Pointer
        UIImage *pointerImg = [UIImage imageNamed:@"ISVPopover_pointer"];
        _menuPointerView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - LANDSCAPE_WIDTH_PADDING, frame.origin.y, pointerImg.size.width, pointerImg.size.height)];
        
        _menuPointerView.image = pointerImg;
        _menuPointerView.tag = MENU_POINTER_TAG;
        [self.containerButton addSubview:_menuPointerView];
        
        // Adding menu Items table
        _menuItemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _menuPointerView.bounds.size.height, frame.size.width - RIGHTM_ARGIN, frame.size.height)];
        NSLog(@"%f  %f",frame.size.width,frame.size.height);
        _menuItemsTableView.dataSource = self;
        _menuItemsTableView.delegate = self;
        _menuItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuItemsTableView.scrollEnabled = NO;
        _menuItemsTableView.backgroundColor = [UIColor clearColor];
        _menuItemsTableView.tag = MENU_TABLE_VIEW_TAG;
        // 去掉iOS7 以上cell的间距
        if ([_menuItemsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_menuItemsTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_menuItemsTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_menuItemsTableView setLayoutMargins:UIEdgeInsetsZero];
        }

        _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ISVPopover_item_bg"]];
        
        
        _menuItemsTableView.backgroundView = _bgView;
        
        
        [self addSubview:_menuItemsTableView];
        
        [self.containerButton addSubview:self];
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)aMenuItems
{
    if (self = [super initWithFrame:frame])
    {
        self.menuItems = aMenuItems;
        
        // Adding Container Button which will take care of hiding menu when user taps outside of menu area
        self.containerButton = [[UIButton alloc] init];
        [self.containerButton setBackgroundColor:CONTAINER_BG_COLOR];
        [self.containerButton addTarget:self action:@selector(dismissMenuPopover) forControlEvents:UIControlEventTouchUpInside];
        [self.containerButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
        
        // Adding Menu Options Pointer
        UIImage *pointerImg = [UIImage imageNamed:@"ISVPopover_pointer"];
        _menuPointerView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - LANDSCAPE_WIDTH_PADDING, frame.origin.y, pointerImg.size.height, pointerImg.size.height)];
        
        _menuPointerView.image = [UIImage imageNamed:@"ISVPopover_pointer"];
        _menuPointerView.tag = MENU_POINTER_TAG;
        [self.containerButton addSubview:_menuPointerView];
        
        // Adding menu Items table
        _menuItemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _menuPointerView.bounds.size.height, frame.size.width - RIGHTM_ARGIN, frame.size.height)];
        NSLog(@"%f  %f",frame.size.width,frame.size.height);
        _menuItemsTableView.dataSource = self;
        _menuItemsTableView.delegate = self;
        _menuItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuItemsTableView.scrollEnabled = NO;
        _menuItemsTableView.backgroundColor = [UIColor clearColor];
        _menuItemsTableView.tag = MENU_TABLE_VIEW_TAG;
        // 去掉iOS7 以上cell的间距
        if ([_menuItemsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_menuItemsTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_menuItemsTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_menuItemsTableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
        _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ISVPopover_item_bg"]];
        
        
        _menuItemsTableView.backgroundView = _bgView;
        
        
        [self addSubview:_menuItemsTableView];
        
        [self.containerButton addSubview:self];
    }
    
    return self;
}

#pragma mark -
#pragma mark UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MENU_ITEM_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = CELL_IDENTIGIER;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.textAlignment = NSTextAlignmentRight;
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    if( [tableView numberOfRowsInSection:indexPath.section] > ONE && !(indexPath.row == numberOfRows - 1) )
    {
        [self addSeparatorImageToCell:cell];
    }
    
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];

    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, MENU_ITEM_HEIGHT)];
    imageview.image = [UIImage imageNamed:[self.imageItems objectAtIndex:indexPath.row]];
    imageview.contentMode = UIViewContentModeCenter;
    [cell addSubview:imageview];

    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    [self.menuPopoverDelegate menuPopover:self didSelectMenuItemAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark -
#pragma mark Actions

- (void)toggleShowHideInView:(UIView *)view
{
    _isShowMenu = !self.containerButton.alpha == 0;
    
    if(_isShowMenu){
        [self dismissMenuPopover];
    }else{
        [self showInView:view];
    }
    _isShowMenu = !_isShowMenu;

}

- (void)dismissMenuPopover
{
    [self hide];
}

- (void)showInView:(UIView *)view
{
    self.containerButton.alpha = ZERO;
    self.containerButton.frame = view.bounds;
    [view addSubview:self.containerButton];
    
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.containerButton.alpha = ONE;
                     }
                     completion:^(BOOL finished) {}];
}

- (void)hide
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.containerButton.alpha = ZERO;
                     }
                     completion:^(BOOL finished) {
                         [self.containerButton removeFromSuperview];
                     }];
}

#pragma mark -
#pragma mark Separator Methods

- (void)addSeparatorImageToCell:(UITableViewCell *)cell
{
    UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:SEPERATOR_LINE_RECT];
    [separatorImageView setImage:[UIImage imageNamed:@"ISVPopover_Line"]];
    separatorImageView.opaque = YES;
    [cell.contentView addSubview:separatorImageView];
}

#pragma mark -
#pragma mark Orientation Methods

- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL landscape = (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
    UIImageView *menuPointerView = (UIImageView *)[self.containerButton viewWithTag:MENU_POINTER_TAG];
    UITableView *menuItemsTableView = (UITableView *)[self.containerButton viewWithTag:MENU_TABLE_VIEW_TAG];
    
    if( landscape )
    {
        menuPointerView.frame = CGRectMake(menuPointerView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
        
        menuItemsTableView.frame = CGRectMake(menuItemsTableView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
    }
    else
    {
        menuPointerView.frame = CGRectMake(menuPointerView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
        
        menuItemsTableView.frame = CGRectMake(menuItemsTableView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
    }
}

@end
