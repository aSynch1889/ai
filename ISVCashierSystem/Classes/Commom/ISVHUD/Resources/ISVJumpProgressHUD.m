//
//  ISVJumpProgressHUD.m
//  加载动画
//
//  Created by aaaa on 15/12/8.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVJumpProgressHUD.h"

#define panelW 112.0
#define panelH 135.0
#define cat_width 99.0
#define cat_height_begin 74.0
#define cat_height_down 60.0

@interface ISVJumpProgressHUD ()
@property (nonatomic, weak) UIImageView *catView;
@property (nonatomic, weak) UIImageView *holeView;
@property (nonatomic, assign) BOOL shouldEnd;
@property (nonatomic, copy) void(^block)();
@end

@implementation ISVJumpProgressHUD

- (void)stopWithBlock:(void (^)())block
{
    self.shouldEnd = YES;
    self.block = block;
}

- (void)beginJump
{
    CGRect cat_rect_begin = CGRectMake((panelW - cat_width)*0.5, 25, cat_width, cat_height_begin);
    self.holeView.frame = CGRectMake(0, 115, 112, 24);
    self.catView.frame = cat_rect_begin;
    [self beginToDown];
}

- (void)beginToDown
{
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    CGRect cat_rect_down = CGRectMake((panelW - cat_width)*0.5, 75, cat_width, cat_height_down);
    self.shouldEnd = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.catView.frame = cat_rect_down;
    } completion:^(BOOL fiØnished) {
        [self downToUp];
    }];
}


- (void)downToUp
{
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

    [UIView animateWithDuration:0.2 animations:^{
        self.catView.frame = CGRectMake(6, 5, cat_width, cat_height_begin);
        self.holeView.frame = CGRectMake(16, 115, 80, 24);
    } completion:^(BOOL finished) {
        [self upToDown];
    }];
}

- (void)upToDown
{
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    // 最低
    CGRect cat_rect_down = CGRectMake((panelW - cat_width)*0.5, 75, cat_width, cat_height_down);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.catView.frame = cat_rect_down;
        self.holeView.frame = CGRectMake(0, 115, 112, 24);
    } completion:^(BOOL finished) {
        
        if (self.shouldEnd || self.window==nil)
        {
            [self downToEnd];
        }
        else
        {
            [self downToUp];
        }
    }];
}

- (void)downToEnd
{
    self.catView.contentMode = UIViewContentModeTop;
    self.catView.layer.masksToBounds = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.catView.frame = CGRectMake(5, panelH - 18, 99, 0.01);
        
    } completion:^(BOOL finished) {
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.05 animations:^{
            
            self.holeView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            
        } completion:^(BOOL finished) {
            [self releaseView];
        }];
    });
}

- (void)releaseView
{
    [self.catView removeFromSuperview];
    
    [self.holeView removeFromSuperview];
    
    [self removeFromSuperview];
    
    if (self.block)
    {
        self.block();
    }
}

- (UIImageView *)catView
{
    if (_catView == nil)
    {
        UIImageView *catView = [[UIImageView alloc] init];
        catView.image = [UIImage imageNamed:@"HUD_loading_cat"];
        catView.contentMode = 0;
        catView.layer.masksToBounds = NO;
        [self addSubview:catView];
        _catView = catView;
    }
    
    return _catView;
}

- (UIImageView *)holeView
{
    if (_holeView == nil)
    {
        UIImageView *holeView = [[UIImageView alloc] init];
        holeView.image = [UIImage imageNamed:@"HUD_loading_hole"];
        
        [self addSubview:holeView];
        _holeView = holeView;
    }
    
    return _holeView;
}

@end
