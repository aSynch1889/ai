//
//  UIControl+ISVPreventRepeatClick.m
//  test
//
//  Created by aaaa on 15/11/5.
//  Copyright © 2015年 qiuwei. All rights reserved.
//

#import "UIControl+ISVPreventRepeatClick.h"
#import <objc/runtime.h>

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *preventTouken = "preventTouken";

@implementation UIControl (ISVPreventRepeatClick)

@dynamic pr_ignoreEvent;

+ (void)load{
    
    // 交换系统点击方法
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(__pr_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}


- (NSTimeInterval)pr_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setPr_acceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(uxy_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)pr_ignoreEvent
{
    return [objc_getAssociatedObject(self, preventTouken) boolValue];
    
}

- (void)setPr_ignoreEvent:(BOOL)ignore
{
    objc_setAssociatedObject(self, preventTouken, @(ignore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 私有方法（解决按钮失效的问题）
- (void)setPr_ignoreEvent_Private:(id)ignore
{
    objc_setAssociatedObject(self, preventTouken, ignore, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 交换后的方法
- (void)__pr_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    
    if (self.pr_ignoreEvent) return;
    if (self.pr_acceptEventInterval > 0)
    {
        NSLog(@"----%f",self.pr_acceptEventInterval);
        self.pr_ignoreEvent = YES;
        [self performSelector:@selector(setPr_ignoreEvent_Private:) withObject:@(NO) afterDelay:self.pr_acceptEventInterval];
    }
    [self __pr_sendAction:action to:target forEvent:event];
}

@end
