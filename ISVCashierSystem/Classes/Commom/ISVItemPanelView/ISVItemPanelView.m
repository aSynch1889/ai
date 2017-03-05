//
//  ISVItemPanelView.m
//  ISV
//
//  Created by aaaa on 17/3/5.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVItemPanelView.h"
#import "ISVItemButton.h"
#import <AudioToolbox/AudioToolbox.h>

#define kW [UIScreen mainScreen].bounds.size.width
#define kH [UIScreen mainScreen].bounds.size.height
#define kMaxColumn 4
#define BtnWidth kW/kMaxColumn
#define BtnHeight 80

//column 列
//line 行
@implementation ISVItemPanelView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles icons:(NSArray<NSString *> *)icons
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, kW, BtnHeight * ((int)(titles.count / kMaxColumn)));
        NSInteger index = 0;
        for (NSString *title in titles)
        {
            CGFloat buttonX,buttonY;
            buttonX = (index % kMaxColumn) * BtnWidth;
            buttonY = ((index / kMaxColumn) * (BtnHeight));
            CGRect frame = CGRectMake(buttonX, buttonY, BtnWidth, BtnHeight);
            
            ISVItemButton *button = [ISVItemButton itemButtonWithTitle:title icon:icons[index]];
            [button setTag:index];
            [button setTitleColor:ISVRGB(128, 128, 128) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(didSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [button setFrame:frame];
            index ++;
        }
    }
    
    return self;
}

+ (instancetype)itemPanelViewWithTitles:(NSArray<NSString *> *)titles icons:(NSArray<NSString *> *)icons
{
    return [[self alloc] initWithTitles:titles icons:icons];
}

-(ISVItemButton *)addButtonIndex:(NSInteger)index
{
    ISVItemButton *button = [[ISVItemButton alloc] init];
    [button setTag:index];
    [button setTitleColor:[UIColor colorWithWhite:0.38 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

- (void)didSelected:(ISVItemButton *)button
{
    [self playSoundName:@"composer_select" ForType:@"wav"];
    [self.delegate itemPanelView:self didSelectedAtIndex:button.tag];
}

-(void)playSoundName:(NSString *)name ForType:(NSString *)type
{
    NSString *AudioName = [NSString stringWithFormat:@"%@.%@",name,type];
    NSURL *url=[[NSBundle mainBundle]URLForResource:AudioName withExtension:nil];
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

@end
