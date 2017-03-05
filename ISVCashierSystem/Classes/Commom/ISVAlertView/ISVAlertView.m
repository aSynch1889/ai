//
//  ISVAlertView.m
//  ISV
//
//  Created by aaaa on 15/11/20.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVAlertView.h"

// >>>>>>>>>>>>>>>>>>>>>>>>>>> 配置AlertView begin >>>>>>>>>>>>>>>>>>>>>>>>>>

// Size
//static const CGFloat kAlertViewWidth = 270.0;
#define kAlertViewWidth ([UIScreen mainScreen].bounds.size.width * 0.8)

static const CGFloat AlertViewContentMargin = 9.0;
static const CGFloat AlertViewVerticalElementSpace = 10.0;
static const CGFloat AlertViewTitleHeight = 44.0;
static const CGFloat AlertViewButtonHeight = 44.0;
static const CGFloat AlertViewLineLayerWidth = 0.5;
static const CGFloat AlertViewVerticalEdgeMinMargin = 25.0;
static const CGFloat AlertViewLayerCornerRadius = 8.0;
static const CGFloat AlertViewLayerOpacity = 0.95;

// Font
#define kAlertViewTitleFont [UIFont boldSystemFontOfSize:17]
#define kAlertViewMessageFont [UIFont systemFontOfSize:15]
#define kAlertViewButtonTitleFont [UIFont systemFontOfSize:17]
#define kAlertViewCancelButtonTitleFont [UIFont boldSystemFontOfSize:17]

// Color
//#define kBackgroundViewBackgroundColor [UIColor colorWithWhite:0 alpha:0.25]
//#define kAlertViewBackgroundColor [UIColor colorWithWhite:0.25 alpha:1]
//#define kAlertViewLineLayerColor [UIColor colorWithWhite:0.90 alpha:0.3]
////#define kAlertViewButtonBackgroundColor [UIColor colorWithRed:94/255.0 green:196/255.0 blue:221/255.0 alpha:1.0]
////#define kAlertViewButtonBackgroundColor [UIColor colorWithRed:78/255.0 green:204/255.0 blue:193/255.0 alpha:1.0]
//#define kAlertViewButtonBackgroundColor [UIColor clearColor]
//#define kAlertViewButtonTitleColorNormal [UIColor whiteColor]
//#define kAlertViewButtonTitleColorHighlighted [UIColor colorWithWhite:0.25 alpha:1]
//#define kAlertViewButtonTitleEdgeInsets UIEdgeInsetsMake(2, 2, 2, 2)

#define kAlertViewConmomTextColor [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0]
#define kBackgroundViewBackgroundColor [UIColor colorWithWhite:0 alpha:0.25]
#define kAlertViewBackgroundColor [UIColor colorWithWhite:1.0 alpha:1]
#define kAlertViewTitleBackgroundColor [UIColor clearColor]
#define kAlertViewTitleTextColor kAlertViewConmomTextColor

#define kAlertViewMessageBackgroundColor [UIColor clearColor]
#define kAlertViewMessageTextColor kAlertViewConmomTextColor

#define kAlertViewLineLayerColor [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0]
#define kAlertViewButtonBackgroundColor [UIColor colorWithWhite:0.8 alpha:0.8]
#define kAlertViewButtonTitleColorNormal [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1.0]
#define kAlertViewButtonTitleColorHighlighted [UIColor colorWithWhite:1.0 alpha:1.0]
#define kAlertViewButtonTitleEdgeInsets UIEdgeInsetsMake(2, 2, 2, 2)


// Key
#define kAlertViewButtonTitle_ok @"确定"
#define kAlertViewAnimateKey_showAlert @"showAlert"
#define kAlertViewAnimateKey_transform @"transform"
#define kAlertViewAnimateKey_dismissAlert @"dismissAlert"
// >>>>>>>>>>>>>>>>>>>>>>>>>>> 配置AlertView end >>>>>>>>>>>>>>>>>>>>>>>>>>>

// 定义AlertView任务处理类
@interface ISVAlertViewStack : NSObject

@property (nonatomic) NSMutableArray *alertViews;

+ (ISVAlertViewStack *)sharedInstance;

- (void)push:(ISVAlertView *)alertView;
- (void)pop:(ISVAlertView *)alertView;

@end


// 定义AlertView实体类
@interface ISVAlertView ()

@property (nonatomic) BOOL buttonsShouldStack;
@property (nonatomic) UIWindow *mainWindow;
@property (nonatomic) UIWindow *alertWindow;
@property (nonatomic) UIView *backgroundView;
@property (nonatomic) UIView *alertView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIView *contentView;
@property (nonatomic) UIScrollView *messageScrollView;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UIButton *cancelButton;
@property (nonatomic) UIButton *otherButton;
@property (nonatomic) NSArray *buttons;
@property (nonatomic) CGFloat buttonsY;
@property (nonatomic) CALayer *verticalLine;
@property (nonatomic) UITapGestureRecognizer *tap;
@property (nonatomic, copy) void (^completion)(BOOL cancelled, NSInteger buttonIndex);

@end

@implementation ISVAlertView

- (UIWindow *)windowWithLevel:(UIWindowLevel)windowLevel
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (window.windowLevel == windowLevel) {
            return window;
        }
    }
    return nil;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
        cancelTitle:(NSString *)cancelTitle
         otherTitle:(NSString *)otherTitle
 buttonsShouldStack:(BOOL)shouldstack
        contentView:(UIView *)contentView
         completion:(ISVAlertViewCompletionBlock)completion
{
    return [self initWithTitle:title
                       message:message
                   cancelTitle:cancelTitle
                   otherTitles:(otherTitle) ? @[ otherTitle ] : nil
            buttonsShouldStack:(BOOL)shouldstack
                   contentView:contentView
                    completion:completion];
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
        cancelTitle:(NSString *)cancelTitle
        otherTitles:(NSArray *)otherTitles
 buttonsShouldStack:(BOOL)shouldstack
        contentView:(UIView *)contentView
         completion:(ISVAlertViewCompletionBlock)completion
{
    self = [super init];
    if (self) {
        self.mainWindow = [self windowWithLevel:UIWindowLevelNormal];
        
        self.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.alertWindow.windowLevel = UIWindowLevelAlert;
        self.alertWindow.backgroundColor = [UIColor clearColor];
        self.alertWindow.rootViewController = self;
        
        CGRect frame = [self frameForOrientation];
        self.view.frame = frame;
        
        self.backgroundView = [[UIView alloc] initWithFrame:frame];
        self.backgroundView.backgroundColor = kBackgroundViewBackgroundColor;
        self.backgroundView.alpha = 0;
        [self.view addSubview:self.backgroundView];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = kAlertViewBackgroundColor;
        self.alertView.layer.cornerRadius = AlertViewLayerCornerRadius;
        self.alertView.layer.opacity = AlertViewLayerOpacity;
        self.alertView.clipsToBounds = YES;
        [self.view addSubview:self.alertView];
        
        // Title
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AlertViewContentMargin,
                                                                    AlertViewVerticalElementSpace,
                                                                    kAlertViewWidth - AlertViewContentMargin*2,
                                                                    AlertViewTitleHeight)];
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = kAlertViewTitleBackgroundColor;
        self.titleLabel.textColor = kAlertViewTitleTextColor;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = kAlertViewTitleFont;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.frame = [self adjustLabelFrameHeight:self.titleLabel];
        [self.alertView addSubview:self.titleLabel];
        
        CGFloat messageLabelY = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + AlertViewVerticalElementSpace;
        
        // Optional Content View
        if (contentView) {
            self.contentView = contentView;
            self.contentView.frame = CGRectMake(0,
                                                messageLabelY,
                                                self.contentView.frame.size.width,
                                                self.contentView.frame.size.height);
            self.contentView.center = CGPointMake(kAlertViewWidth/2, self.contentView.center.y);
            [self.alertView addSubview:self.contentView];
            messageLabelY += contentView.frame.size.height + AlertViewVerticalElementSpace;
        }
        
        // Message
        self.messageScrollView = [[UIScrollView alloc] initWithFrame:(CGRect){
            AlertViewContentMargin,
            messageLabelY,
            kAlertViewWidth - AlertViewContentMargin*2,
            44}];
        self.messageScrollView.scrollEnabled = YES;
        
        self.messageLabel = [[UILabel alloc] initWithFrame:(CGRect){0, 0,
            self.messageScrollView.frame.size}];
        self.messageLabel.text = message;
        self.messageLabel.backgroundColor = kAlertViewMessageBackgroundColor;
        self.messageLabel.textColor = kAlertViewMessageTextColor;
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.font = kAlertViewMessageFont;
        self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.frame = [self adjustLabelFrameHeight:self.messageLabel];
        self.messageScrollView.contentSize = self.messageLabel.frame.size;
        
        [self.messageScrollView addSubview:self.messageLabel];
        [self.alertView addSubview:self.messageScrollView];
        
        // Get total button height
        CGFloat totalBottomHeight = AlertViewLineLayerWidth;
        if(self.buttonsShouldStack)
        {
            if(cancelTitle)
            {
                totalBottomHeight += AlertViewButtonHeight;
            }
            if (otherTitles && [otherTitles count] > 0)
            {
                totalBottomHeight += (AlertViewButtonHeight + AlertViewLineLayerWidth) * [otherTitles count];
            }
        }
        else
        {
            totalBottomHeight += AlertViewButtonHeight;
        }
        
        self.messageScrollView.frame = (CGRect) {
            self.messageScrollView.frame.origin,
            self.messageScrollView.frame.size.width,
            MIN(self.messageLabel.frame.size.height, self.alertWindow.frame.size.height - self.messageScrollView.frame.origin.y - totalBottomHeight - AlertViewVerticalEdgeMinMargin * 2)
        };
        
        // Line
        CALayer *lineLayer = [self lineLayer];
        lineLayer.frame = CGRectMake(0, self.messageScrollView.frame.origin.y + self.messageScrollView.frame.size.height + AlertViewVerticalElementSpace, kAlertViewWidth, AlertViewLineLayerWidth);
        [self.alertView.layer addSublayer:lineLayer];
        
        self.buttonsY = lineLayer.frame.origin.y + lineLayer.frame.size.height;
        
        // Buttons
        self.buttonsShouldStack = shouldstack;
        
        if (cancelTitle) {
            [self addButtonWithTitle:cancelTitle];
        } else {
            [self addButtonWithTitle:NSLocalizedString(kAlertViewButtonTitle_ok, nil)];
        }
        
        if (otherTitles && [otherTitles count] > 0) {
            for (id otherTitle in otherTitles) {
                NSParameterAssert([otherTitle isKindOfClass:[NSString class]]);
                [self addButtonWithTitle:(NSString *)otherTitle];
            }
        }
        
        self.alertView.bounds = CGRectMake(0, 0, kAlertViewWidth, 150);
        
        if (completion) {
            self.completion = completion;
        }
        
        [self resizeViews];
        
        self.alertView.center = [self centerWithFrame:frame];
        
        [self setupGestures]; 
        
        if ((self = [super init])) {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
            [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        }
        return self;
    }
    return self;
}

- (id)initWithTitles:(NSArray *)otherTitles
  buttonsShouldStack:(BOOL)shouldstack
         contentView:(UIView *)contentView
          completion:(ISVAlertViewCompletionBlock)completion
{
    self = [super init];
    if (self) {
        self.mainWindow = [self windowWithLevel:UIWindowLevelNormal];
        
        self.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.alertWindow.windowLevel = UIWindowLevelAlert;
        self.alertWindow.backgroundColor = [UIColor clearColor];
        self.alertWindow.rootViewController = self;
        
        CGRect frame = [self frameForOrientation];
        self.view.frame = frame;
        
        self.backgroundView = [[UIView alloc] initWithFrame:frame];
        self.backgroundView.backgroundColor = kBackgroundViewBackgroundColor;
        self.backgroundView.alpha = 0;
        [self.view addSubview:self.backgroundView];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = kAlertViewBackgroundColor;
        self.alertView.layer.cornerRadius = AlertViewLayerCornerRadius;
        self.alertView.layer.opacity = AlertViewLayerOpacity;
        self.alertView.clipsToBounds = YES;
        [self.view addSubview:self.alertView];
        
        // Get total button height
        CGFloat totalBottomHeight = AlertViewLineLayerWidth;
        if(self.buttonsShouldStack)
        {
            if (otherTitles && [otherTitles count] > 0)
            {
                totalBottomHeight += (AlertViewButtonHeight + AlertViewLineLayerWidth) * [otherTitles count];
            }
        }
        else
        {
            totalBottomHeight += AlertViewButtonHeight * otherTitles.count;
        }
        
        //根据titles的位置确定
        // Optional Content View
        if (contentView) {
            self.contentView = contentView;
            self.contentView.frame = CGRectMake(0,
                                                totalBottomHeight,
                                                self.contentView.frame.size.width,
                                                self.contentView.frame.size.height);
            self.contentView.center = CGPointMake(kAlertViewWidth/2, self.contentView.center.y);
            [self.alertView addSubview:self.contentView];
            totalBottomHeight += contentView.frame.size.height + AlertViewVerticalElementSpace;
        }
        self.messageScrollView.frame = (CGRect) {
            self.messageScrollView.frame.origin,
            self.messageScrollView.frame.size.width,
            MIN(self.messageLabel.frame.size.height, self.alertWindow.frame.size.height - self.messageScrollView.frame.origin.y - totalBottomHeight - AlertViewVerticalEdgeMinMargin * 2)
        };
        
        // Line
        CALayer *lineLayer = [self lineLayer];
        lineLayer.frame = CGRectMake(0, 0, kAlertViewWidth, AlertViewLineLayerWidth);
        [self.alertView.layer addSublayer:lineLayer];
        
        self.buttonsY = lineLayer.frame.origin.y + lineLayer.frame.size.height;
        
        // Buttons
        self.buttonsShouldStack = shouldstack;
        
        if (otherTitles && [otherTitles count] > 0) {
            for (id otherTitle in otherTitles) {
                NSParameterAssert([otherTitle isKindOfClass:[NSString class]]);
                [self addButtonWithTitle:(NSString *)otherTitle];
            }
        }
        
        self.alertView.bounds = CGRectMake(0, 0, kAlertViewWidth, 150);
        
        if (completion) {
            self.completion = completion;
        }
        
        [self resizeViews];
        
        self.alertView.center = [self centerWithFrame:frame];
        
        [self setupGestures];
        
        if ((self = [super init])) {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
            [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        }
        return self;
    }
    return self;
}



- (void)keyboardWillShown:(NSNotification*)notification
{
//    if(self.isVisible)
    {
        CGRect keyboardFrameBeginRect = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0 && (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight))
        {
            keyboardFrameBeginRect = (CGRect){keyboardFrameBeginRect.origin.y, keyboardFrameBeginRect.origin.x, keyboardFrameBeginRect.size.height, keyboardFrameBeginRect.size.width};
        }
        CGRect interfaceFrame = [self frameForOrientation];
        
        if(interfaceFrame.size.height -  keyboardFrameBeginRect.size.height <= _alertView.frame.size.height + _alertView.frame.origin.y)
        {
            [UIView animateWithDuration:.35 delay:0 options:0x70000 animations:^(void)
             {
                 _alertView.frame = (CGRect){_alertView.frame.origin.x, MAX(84, interfaceFrame.size.height - keyboardFrameBeginRect.size.height - _alertView.frame.size.height - 70), _alertView.frame.size};
             } completion:nil];
        }
    }
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    if(self.isVisible)
    {
        [UIView animateWithDuration:.35 delay:0 options:0x70000 animations:^(void)
         {
             _alertView.center = [self centerWithFrame:[self frameForOrientation]];
         } completion:nil];
    }
}

- (CGRect)frameForOrientation
{
    UIWindow *window = [[UIApplication sharedApplication].windows count] > 0 ? [[UIApplication sharedApplication].windows objectAtIndex:0] : nil;
    if (!window)
        window = [UIApplication sharedApplication].keyWindow;
    if([[window subviews] count] > 0)
    {
        return [[[window subviews] objectAtIndex:0] bounds];
    }
    return [[self windowWithLevel:UIWindowLevelNormal] bounds];
}

- (CGRect)adjustLabelFrameHeight:(UILabel *)label
{
    CGFloat height;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGSize size = [label.text sizeWithFont:label.font
                             constrainedToSize:CGSizeMake(label.frame.size.width, FLT_MAX)
                                 lineBreakMode:NSLineBreakByWordWrapping];
        
        height = size.height;
#pragma clang diagnostic pop
    } else {
        NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
        context.minimumScaleFactor = 1.0;
        CGRect bounds = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, FLT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:label.font}
                                                 context:context];
        height = bounds.size.height;
    }
    
    return CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, height);
}

- (UIButton *)genericButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = kAlertViewButtonTitleFont;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.titleEdgeInsets = kAlertViewButtonTitleEdgeInsets;
    [button setTitleColor:kAlertViewButtonTitleColorNormal forState:UIControlStateNormal];
    [button setTitleColor:ISVMainColor forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(setBackgroundColorForButton:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(setBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragEnter];
    [button addTarget:self action:@selector(clearBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragExit];
    return button;
}

- (CGPoint)centerWithFrame:(CGRect)frame
{
    return CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - [self statusBarOffset]);
}

- (CGFloat)statusBarOffset
{
    CGFloat statusBarOffset = 0;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        statusBarOffset = 20;
    }
    return statusBarOffset;
}

- (void)setupGestures
{
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    self.tap.enabled = NO;
    [self.tap setNumberOfTapsRequired:1];
    [self.backgroundView setUserInteractionEnabled:YES];
    [self.backgroundView setMultipleTouchEnabled:NO];
    [self.backgroundView addGestureRecognizer:self.tap];
}

- (void)resizeViews
{
    CGFloat totalHeight = 0;
    for (UIView *view in [self.alertView subviews]) {
        if ([view class] != [UIButton class]) {
            totalHeight += view.frame.size.height + AlertViewVerticalElementSpace;
        }
    }
    if (self.buttons) {
        NSUInteger otherButtonsCount = [self.buttons count];
        if (self.buttonsShouldStack) {
            totalHeight += AlertViewButtonHeight * otherButtonsCount;
        } else {
            totalHeight += AlertViewButtonHeight * (otherButtonsCount > 2 ? otherButtonsCount : 1);
        }
    }
    totalHeight += AlertViewVerticalElementSpace;
    
    self.alertView.frame = CGRectMake(self.alertView.frame.origin.x,
                                      self.alertView.frame.origin.y,
                                      self.alertView.frame.size.width,
                                      MIN(totalHeight, self.alertWindow.frame.size.height));
}

- (void)setBackgroundColorForButton:(id)sender
{
    [sender setBackgroundColor:kAlertViewButtonBackgroundColor];
}

- (void)clearBackgroundColorForButton:(id)sender
{
    [sender setBackgroundColor:[UIColor clearColor]];
}

- (void)show
{
    [[ISVAlertViewStack sharedInstance] push:self];
}

- (void)showInternal
{
    [self.alertWindow addSubview:self.view];
    [self.alertWindow makeKeyAndVisible];
    self.visible = YES;
    [self showBackgroundView];
    [self showAlertAnimation];
}

- (void)showBackgroundView
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        self.mainWindow.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
        [self.mainWindow tintColorDidChange];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.alpha = 1.0;
    }];
}

- (void)hide
{
    [self.view removeFromSuperview];
}

- (void)dismiss
{
    [self dismiss:nil];
}

- (void)dismiss:(id)sender
{
    [self dismiss:sender animated:YES];
}

- (void)dismiss:(id)sender animated:(BOOL)animated
{
    self.visible = NO;
    
    [UIView animateWithDuration:(animated ? 0.2 : 0) animations:^{
        self.alertView.alpha = 0;
        self.alertWindow.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.completion) {
            BOOL cancelled = NO;
            if (sender == self.cancelButton || sender == self.tap) {
                cancelled = YES;
            }
            NSInteger buttonIndex = -1;
            if (self.buttons) {
                NSUInteger index = [self.buttons indexOfObject:sender];
                if (index != NSNotFound) {
                    buttonIndex = index;
                }
            }
            if (sender) {
                self.completion(cancelled, buttonIndex);
            }
        }
        
        if ([[[ISVAlertViewStack sharedInstance] alertViews] count] == 1) {
            if (animated) {
                [self dismissAlertAnimation];
            }
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
                self.mainWindow.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
                [self.mainWindow tintColorDidChange];
            }
            [UIView animateWithDuration:(animated ? 0.2 : 0) animations:^{
                self.backgroundView.alpha = 0;
                [self.alertWindow setHidden:YES];
                [self.alertWindow removeFromSuperview];
                self.alertWindow.rootViewController = nil;
                self.alertWindow = nil;
            } completion:^(BOOL finished) {
                [self.mainWindow makeKeyAndVisible];
            }];
        }
        
        [[ISVAlertViewStack sharedInstance] pop:self];
    }];
}

- (void)showAlertAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:kAlertViewAnimateKey_transform];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .3;
    
    [self.alertView.layer addAnimation:animation forKey:kAlertViewAnimateKey_showAlert];
}

- (void)dismissAlertAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:kAlertViewAnimateKey_transform];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeRemoved;
    animation.duration = .2;
    
    [self.alertView.layer addAnimation:animation forKey:kAlertViewAnimateKey_dismissAlert];
}

- (CALayer *)lineLayer
{
    CALayer *lineLayer = [CALayer layer];
    lineLayer.backgroundColor = [kAlertViewLineLayerColor CGColor];
    return lineLayer;
}

#pragma mark -
#pragma mark UIViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return [UIApplication sharedApplication].statusBarHidden;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect frame = [self frameForOrientation];
    self.backgroundView.frame = frame;
    self.alertView.center = [self centerWithFrame:frame];
}

#pragma mark -
#pragma mark Public

+ (instancetype)showAlertWithTitle:(NSString *)title
{
    return [[self class] showAlertWithTitle:title message:nil cancelTitle:NSLocalizedString(kAlertViewButtonTitle_ok, nil) completion:nil];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
{
    return [[self class] showAlertWithTitle:title message:message cancelTitle:NSLocalizedString(kAlertViewButtonTitle_ok, nil) completion:nil];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                        completion:(ISVAlertViewCompletionBlock)completion
{
    return [[self class] showAlertWithTitle:title message:message cancelTitle:NSLocalizedString(kAlertViewButtonTitle_ok, nil) completion:completion];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        completion:(ISVAlertViewCompletionBlock)completion
{
    ISVAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                              otherTitle:nil
                                      buttonsShouldStack:NO
                                             contentView:nil
                                              completion:completion];
    [alertView show];
    return alertView;
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                        completion:(ISVAlertViewCompletionBlock)completion
{
    ISVAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                              otherTitle:otherTitle
                                      buttonsShouldStack:NO
                                             contentView:nil
                                              completion:completion];
    [alertView show];
    return alertView;
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                buttonsShouldStack:(BOOL)shouldStack
                        completion:(ISVAlertViewCompletionBlock)completion
{
    ISVAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                              otherTitle:otherTitle
                                      buttonsShouldStack:shouldStack
                                             contentView:nil
                                              completion:completion];
    [alertView show];
    return alertView;
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                        completion:(ISVAlertViewCompletionBlock)completion
{
    ISVAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                             otherTitles:otherTitles
                                      buttonsShouldStack:NO
                                             contentView:nil
                                              completion:completion];
    [alertView show];
    return alertView;
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                       contentView:(UIView *)view
                        completion:(ISVAlertViewCompletionBlock)completion
{
    ISVAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                              otherTitle:otherTitle
                                      buttonsShouldStack:NO
                                             contentView:view
                                              completion:completion];
    [alertView show];
    return alertView;
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                buttonsShouldStack:(BOOL)shouldStack
                       contentView:(UIView *)view
                        completion:(ISVAlertViewCompletionBlock)completion
{
    ISVAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                              otherTitle:otherTitle
                                      buttonsShouldStack:shouldStack
                                             contentView:view
                                              completion:completion];
    [alertView show];
    return alertView;
}


+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                       contentView:(UIView *)view
                        completion:(ISVAlertViewCompletionBlock)completion
{
    ISVAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                             otherTitles:otherTitles
                                      buttonsShouldStack:NO
                                             contentView:view
                                              completion:completion];
    [alertView show];
    return alertView;
}

+ (instancetype)showAlertWithTitles:(NSArray *)otherTitles
                       contentView:(UIView *)view
                        completion:(ISVAlertViewCompletionBlock)completion
{
    ISVAlertView *alertView = [[self alloc]initWithTitles:otherTitles buttonsShouldStack:NO contentView:view completion:completion];
    [alertView show];
    return alertView;
}

- (NSInteger)addButtonWithTitle:(NSString *)title
{
    UIButton *button = [self genericButton];
    [button setTitle:title forState:UIControlStateNormal];
    
    if (!self.cancelButton) {
        button.titleLabel.font = kAlertViewCancelButtonTitleFont;
        self.cancelButton = button;
        self.cancelButton.frame = CGRectMake(0, self.buttonsY, kAlertViewWidth, AlertViewButtonHeight);
    } else if (self.buttonsShouldStack) {
        button.titleLabel.font = kAlertViewButtonTitleFont;
        self.otherButton = button;
        
        button.frame = self.cancelButton.frame;
        
        CGFloat lastButtonYOffset = self.cancelButton.frame.origin.y + AlertViewButtonHeight;
        self.cancelButton.frame = CGRectMake(0, lastButtonYOffset, kAlertViewWidth, AlertViewButtonHeight);
        
        CALayer *lineLayer = [self lineLayer];
        lineLayer.frame = CGRectMake(0, lastButtonYOffset, kAlertViewWidth, AlertViewLineLayerWidth);
        [self.alertView.layer addSublayer:lineLayer];
    } else if (self.buttons && [self.buttons count] > 1) {
        UIButton *lastButton = (UIButton *)[self.buttons lastObject];
        lastButton.titleLabel.font = kAlertViewButtonTitleFont;
        if ([self.buttons count] == 2) {
            [self.verticalLine removeFromSuperlayer];
            CALayer *lineLayer = [self lineLayer];
            lineLayer.frame = CGRectMake(0, self.buttonsY + AlertViewButtonHeight, kAlertViewWidth, AlertViewLineLayerWidth);
            [self.alertView.layer addSublayer:lineLayer];
            CALayer *lineLayer2 = [self lineLayer];
            lineLayer2.frame = CGRectMake(0, self.buttonsY + AlertViewButtonHeight * 2, kAlertViewWidth, AlertViewLineLayerWidth);
            [self.alertView.layer addSublayer:lineLayer2];
            lastButton.frame = CGRectMake(0, self.buttonsY + AlertViewButtonHeight, kAlertViewWidth, AlertViewButtonHeight);
            self.cancelButton.frame = CGRectMake(0, self.buttonsY, kAlertViewWidth, AlertViewButtonHeight);
        }
        CGFloat lastButtonYOffset = lastButton.frame.origin.y + AlertViewButtonHeight;
        button.frame = CGRectMake(0, lastButtonYOffset, kAlertViewWidth, AlertViewButtonHeight);
    } else {
        self.verticalLine = [self lineLayer];
        self.verticalLine.frame = CGRectMake(kAlertViewWidth/2, self.buttonsY, AlertViewLineLayerWidth, AlertViewButtonHeight);
        [self.alertView.layer addSublayer:self.verticalLine];
        button.frame = CGRectMake(kAlertViewWidth/2, self.buttonsY, kAlertViewWidth/2, AlertViewButtonHeight);
        self.otherButton = button;
        self.cancelButton.frame = CGRectMake(0, self.buttonsY, kAlertViewWidth/2, AlertViewButtonHeight);
        self.cancelButton.titleLabel.font = kAlertViewButtonTitleFont;
    }
    
    [self.alertView addSubview:button];
    self.buttons = (self.buttons) ? [self.buttons arrayByAddingObject:button] : @[ button ];
    return [self.buttons count] - 1;
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if (buttonIndex >= 0 && buttonIndex < [self.buttons count]) {
        [self dismiss:self.buttons[buttonIndex] animated:animated];
    }
}

- (void)setTapToDismissEnabled:(BOOL)enabled
{
    self.tap.enabled = enabled;
}

- (NSArray *)otherButtons
{
    return self.buttons;
}

@end


@implementation ISVAlertViewStack

+ (instancetype)sharedInstance
{
    static ISVAlertViewStack *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ISVAlertViewStack alloc] init];
        _sharedInstance.alertViews = [NSMutableArray array];
    });
    
    return _sharedInstance;
}

- (void)push:(ISVAlertView *)alertView
{
    for (ISVAlertView *av in self.alertViews) {
        if (av != alertView) {
            [av hide];
        }
        else {
            return;
        }
    }
    [self.alertViews addObject:alertView];
    [alertView showInternal];
}

- (void)pop:(ISVAlertView *)alertView
{
    [alertView hide];
    [self.alertViews removeObject:alertView];
    ISVAlertView *last = [self.alertViews lastObject];
    if (last && !last.view.superview) {
        [last showInternal];
    }
}

@end

