//
//  HMNavigationMenuView.m
//  test
//
//  Created by healthmall005 on 15/12/2.
//  Copyright © 2015年 healthmall005. All rights reserved.
//

#import "HMNavigationMenuView.h"
#import "QuartzCore/QuartzCore.h"
#import "HMMenuButton.h"
#import "HMMenuTable.h"
#import "HMMenuConfiguration.h"

@interface HMNavigationMenuView  ()
@property (nonatomic, strong) HMMenuButton *menuButton;
@property (nonatomic, strong) HMMenuTable *table;
@property (nonatomic, strong) UIView *menuContainer;
@end

@implementation HMNavigationMenuView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.y += 1.0;
        self.menuButton = [[HMMenuButton alloc] initWithFrame:frame];
        self.menuButton.title.text = title;
        [self.menuButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.menuButton];
    }
    return self;
}

- (void)displayMenuInView:(UIView *)view
{
    self.menuContainer = view;
}

#pragma mark -
#pragma mark Actions
- (void)onHandleMenuTap:(id)sender
{
    if (self.menuButton.isActive) {
        NSLog(@"On show");
        [self onShowMenu];
    } else {
        NSLog(@"On hide");
        [self onHideMenu];
    }
}

- (void)onShowMenu
{
    if (!self.table) {
        //        UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
        //        CGRect frame = mainWindow.frame;
        //        frame.origin.y += self.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
        self.table = [[HMMenuTable alloc] initWithFrame:CGRectMake(self.menuContainer.frame.origin.x, self.menuContainer.frame.origin.y + 64, self.menuContainer.frame.size.width, self.items.count * [HMMenuConfiguration itemCellHeight]) items:self.items];
        self.table.menuDelegate = self;
    }
    [self.menuContainer addSubview:self.table];
    [self rotateArrow:M_PI];
    [self.table show];
}

- (void)onHideMenu
{
    [self rotateArrow:0];
    [self.table hide];
}

- (void)rotateArrow:(float)degrees
{
    [UIView animateWithDuration:[HMMenuConfiguration animationDuration] delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.menuButton.arrow.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:NULL];
}

#pragma mark -
#pragma mark Delegate methods
- (void)didSelectItemAtIndex:(NSUInteger)index
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
    self.menuButton.title.text = self.items[index];
    [self.delegate didSelectItemAtIndex:index];
}

- (void)didBackgroundTap
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
}

#pragma mark -
#pragma mark Memory management
- (void)dealloc
{
    self.items = nil;
    self.menuButton = nil;
    self.menuContainer = nil;
}
@end
