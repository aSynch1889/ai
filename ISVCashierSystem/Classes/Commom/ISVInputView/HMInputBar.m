
#import "HMInputBar.h"
#import "JSQMessagesToolbarContentView.h"
#import "JSQMessagesInputToolbar.h"
#import "JSQMessagesComposerTextView.h"



static void * kJSQMessagesKeyValueObservingContext = &kJSQMessagesKeyValueObservingContext;

@interface HMInputBar () <JSQMessagesInputToolbarDelegate,
                                         JSQMessagesKeyboardControllerDelegate>

@property (weak, nonatomic) IBOutlet JSQMessagesInputToolbar *inputToolbar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarBottomLayoutGuide;

@property (weak, nonatomic) UIView *snapshotView;

@property (assign, nonatomic) BOOL jsq_isObserving;

@property (strong, nonatomic) NSIndexPath *selectedIndexPathForMenu;

@property (weak, nonatomic) UIGestureRecognizer *currentInteractivePopGestureRecognizer;

@property (assign, nonatomic) BOOL textViewWasFirstResponderDuringInteractivePop;

- (void)jsq_configureMessagesViewController;

- (NSString *)jsq_currentlyComposedMessageText;

- (void)jsq_handleDidChangeStatusBarFrameNotification:(NSNotification *)notification;
//- (void)jsq_didReceiveMenuWillShowNotification:(NSNotification *)notification;
//- (void)jsq_didReceiveMenuWillHideNotification:(NSNotification *)notification;

- (void)jsq_updateKeyboardTriggerPoint;
- (void)jsq_setToolbarBottomLayoutGuideConstant:(CGFloat)constant;

- (void)jsq_handleInteractivePopGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

- (BOOL)jsq_inputToolbarHasReachedMaximumHeight;
- (void)jsq_adjustInputToolbarForComposerTextViewContentSizeChange:(CGFloat)dy;
- (void)jsq_adjustInputToolbarHeightConstraintByDelta:(CGFloat)dy;
- (void)jsq_scrollComposerTextViewToBottomAnimated:(BOOL)animated;



- (void)jsq_addObservers;
- (void)jsq_removeObservers;

- (void)jsq_registerForNotifications:(BOOL)registerForNotifications;

- (void)jsq_addActionToInteractivePopGestureRecognizer:(BOOL)addAction;

@end



@implementation HMInputBar

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([HMInputBar class])
                          bundle:[NSBundle bundleForClass:[HMInputBar class]]];
}

+ (instancetype)messagesViewController
{
    return [[[self class] alloc] initWithNibName:NSStringFromClass([HMInputBar class])
                                          bundle:[NSBundle bundleForClass:[HMInputBar class]]];
}

#pragma mark - Initialization

- (void)jsq_configureMessagesViewController
{
    self.view.backgroundColor = HMRGBACOLOR(0, 0, 0, 0.0);
    
    self.jsq_isObserving = NO;
    
    self.toolbarHeightConstraint.constant = self.inputToolbar.preferredDefaultHeight;
    
    self.inputToolbar.delegate = self;
    self.inputToolbar.contentView.textView.delegate = self;
    self.inputToolbar.contentView.textView.tintColor = HMMainlColor;
    UIControl *view = (UIControl *)self.view;
    [view addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchDown];
    
    self.topContentAdditionalInset = 0.0f;
    
    // Don't set keyboardController if client creates custom content view via -loadToolbarContentView
    if (self.inputToolbar.contentView.textView != nil)
    {
        self.keyboardController = [[JSQMessagesKeyboardController alloc]
                                   initWithTextView:self.inputToolbar.contentView.textView
                                   contextView:self.view
                                   delegate:self];
    }
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    self.inputToolbar.contentView.textView.placeHolder = placeHolder;
}

- (void)dealloc
{
    [self jsq_registerForNotifications:NO];
    [self jsq_removeObservers];
    
    
    _inputToolbar.contentView.textView.delegate = nil;
    _inputToolbar.delegate = nil;
    _inputToolbar = nil;
    
    _toolbarHeightConstraint = nil;
    _toolbarBottomLayoutGuide = nil;
    
    [_keyboardController endListeningForKeyboard];
    _keyboardController = nil;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[self class] nib] instantiateWithOwner:self options:nil];
    
    [self jsq_configureMessagesViewController];
    [self jsq_registerForNotifications:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    
    [self jsq_updateKeyboardTriggerPoint];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self jsq_addObservers];
    [self jsq_addActionToInteractivePopGestureRecognizer:YES];
    [self.keyboardController beginListeningForKeyboard];
    
    if ([[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending) {
        [self.snapshotView removeFromSuperview];
    }
    
    [self.inputToolbar.contentView.textView becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self jsq_addActionToInteractivePopGestureRecognizer:NO];
    [self jsq_removeObservers];
    [self.keyboardController endListeningForKeyboard];
}


#pragma mark - Input toolbar delegate

- (void)messagesInputToolbar:(JSQMessagesInputToolbar *)toolbar didPressRightBarButton:(UIButton *)sender
{
    [self jsq_currentlyComposedMessageText];
    NSString *text = self.inputToolbar.contentView.textView.text;
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length > self.maxWordCount)
    {
        text = [text substringToIndex:self.maxWordCount];
    }
    [self jsq_currentlyComposedMessageText];
    [self.delegate inputViewSendBtnDidPressedWithText:text];
    [self dismiss];
    self.inputToolbar.contentView.textView.text = nil;
    self.inputToolbar.contentView.rightBarButtonItem.enabled = NO;
}

- (NSString *)jsq_currentlyComposedMessageText
{
    //  auto-accept any auto-correct suggestions
    [self.inputToolbar.contentView.textView.inputDelegate selectionWillChange:self.inputToolbar.contentView.textView];
    [self.inputToolbar.contentView.textView.inputDelegate selectionDidChange:self.inputToolbar.contentView.textView];
    
    return [self.inputToolbar.contentView.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - Text view delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView != self.inputToolbar.contentView.textView)
    {
        return;
    }
    
    [textView becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView != self.inputToolbar.contentView.textView)
    {
        return;
    }
    
    NSString *text = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (textView.markedTextRange==nil || textView.markedTextRange.isEmpty)
    {
        // 限制最多50字
        if (text.length > self.maxWordCount)
        {
            text = [text substringToIndex:self.maxWordCount];
            self.inputToolbar.contentView.rightBarButtonItem.enabled = YES;
        }
        else if (text.length > 0)
        {
            self.inputToolbar.contentView.rightBarButtonItem.enabled = YES;
        }
        else
        {
            self.inputToolbar.contentView.rightBarButtonItem.enabled = NO;
        }
        textView.text = text;
    }
    else
    {
        self.inputToolbar.contentView.rightBarButtonItem.enabled = NO;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView != self.inputToolbar.contentView.textView)
    {
        return;
    }
    
    [textView resignFirstResponder];
}

#pragma mark - Notifications

- (void)jsq_handleDidChangeStatusBarFrameNotification:(NSNotification *)notification
{
    if (self.keyboardController.keyboardIsVisible)
    {
        [self jsq_setToolbarBottomLayoutGuideConstant:CGRectGetHeight(self.keyboardController.currentKeyboardFrame)];
    }
}



//- (void)jsq_didReceiveMenuWillHideNotification:(NSNotification *)notification
//{
//    if (!self.selectedIndexPathForMenu)
//    {
//        return;
//    }
//}

#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kJSQMessagesKeyValueObservingContext)
    {
        
        if (object == self.inputToolbar.contentView.textView
            && [keyPath isEqualToString:NSStringFromSelector(@selector(contentSize))])
        {
            CGSize oldContentSize = [[change objectForKey:NSKeyValueChangeOldKey] CGSizeValue];
            CGSize newContentSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
            
            CGFloat dy = newContentSize.height - oldContentSize.height;
            
            [self jsq_adjustInputToolbarForComposerTextViewContentSizeChange:dy];
        }
    }
}

#pragma mark - Keyboard controller delegate

- (void)keyboardController:(JSQMessagesKeyboardController *)keyboardController keyboardDidChangeFrame:(CGRect)keyboardFrame
{
    //    if (![self.inputToolbar.contentView.textView isFirstResponder] && self.toolbarBottomLayoutGuide.constant == 0.0f)
    //    {
    //        return;
    //    }
    if (![self.inputToolbar.contentView.textView isFirstResponder])
    {
        
        [self jsq_setToolbarBottomLayoutGuideConstant:-self.inputToolbar.height];
        
        return;
    }
    
    CGFloat heightFromBottom = CGRectGetMaxY(self.view.frame) - CGRectGetMinY(keyboardFrame);
    
    heightFromBottom = MAX(0.0f, heightFromBottom);
    
    [self jsq_setToolbarBottomLayoutGuideConstant:heightFromBottom];
    
    [UIView animateWithDuration:0.35 animations:^{
        self.view.backgroundColor = HMRGBACOLOR(0, 0, 0, 0.5);
    }];
}

- (void)jsq_setToolbarBottomLayoutGuideConstant:(CGFloat)constant
{
    self.toolbarBottomLayoutGuide.constant = constant;
    [self.view setNeedsUpdateConstraints];
    [self.view layoutIfNeeded];
    
}

- (void)jsq_updateKeyboardTriggerPoint
{
    self.keyboardController.keyboardTriggerPoint = CGPointMake(0.0f, CGRectGetHeight(self.inputToolbar.bounds));
}

#pragma mark - Gesture recognizers

- (void)jsq_handleInteractivePopGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            if ([[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending)
            {
                [self.snapshotView removeFromSuperview];
            }
            
            self.textViewWasFirstResponderDuringInteractivePop = [self.inputToolbar.contentView.textView isFirstResponder];
            
            [self.keyboardController endListeningForKeyboard];
            
            if ([[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending)
            {
                [self.inputToolbar.contentView.textView resignFirstResponder];
                [UIView animateWithDuration:0.0
                                 animations:^{
                                     [self jsq_setToolbarBottomLayoutGuideConstant:0.0f];
                                 }];
                
                UIView *snapshot = [self.view snapshotViewAfterScreenUpdates:YES];
                [self.view addSubview:snapshot];
                self.snapshotView = snapshot;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
            [self.keyboardController beginListeningForKeyboard];
            if (self.textViewWasFirstResponderDuringInteractivePop)
            {
                [self.inputToolbar.contentView.textView becomeFirstResponder];
            }
            
            if ([[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending)
            {
                [self.snapshotView removeFromSuperview];
            }
            break;
        default:
            break;
    }
}

#pragma mark - Input toolbar utilities

- (BOOL)jsq_inputToolbarHasReachedMaximumHeight
{
    return CGRectGetMinY(self.inputToolbar.frame) == (self.topLayoutGuide.length + self.topContentAdditionalInset);
}

- (void)jsq_adjustInputToolbarForComposerTextViewContentSizeChange:(CGFloat)dy
{
    BOOL contentSizeIsIncreasing = (dy > 0);
    
    if ([self jsq_inputToolbarHasReachedMaximumHeight])
    {
        BOOL contentOffsetIsPositive = (self.inputToolbar.contentView.textView.contentOffset.y > 0);
        
        if (contentSizeIsIncreasing || contentOffsetIsPositive)
        {
            [self jsq_scrollComposerTextViewToBottomAnimated:YES];
            return;
        }
    }
    
    CGFloat toolbarOriginY = CGRectGetMinY(self.inputToolbar.frame);
    CGFloat newToolbarOriginY = toolbarOriginY - dy;
    
    //  attempted to increase origin.Y above topLayoutGuide
    if (newToolbarOriginY <= self.topLayoutGuide.length + self.topContentAdditionalInset) {
        dy = toolbarOriginY - (self.topLayoutGuide.length + self.topContentAdditionalInset);
        [self jsq_scrollComposerTextViewToBottomAnimated:YES];
    }
    
    [self jsq_adjustInputToolbarHeightConstraintByDelta:dy];
    
    [self jsq_updateKeyboardTriggerPoint];
    
    if (dy < 0)
    {
        [self jsq_scrollComposerTextViewToBottomAnimated:NO];
    }
}

- (void)jsq_adjustInputToolbarHeightConstraintByDelta:(CGFloat)dy
{
    CGFloat proposedHeight = self.toolbarHeightConstraint.constant + dy;
    
    CGFloat finalHeight = MAX(proposedHeight, self.inputToolbar.preferredDefaultHeight);
    
    if (self.inputToolbar.maximumHeight != NSNotFound) {
        finalHeight = MIN(finalHeight, self.inputToolbar.maximumHeight);
    }
    
    if (self.toolbarHeightConstraint.constant != finalHeight)
    {
        self.toolbarHeightConstraint.constant = finalHeight;
        [self.view setNeedsUpdateConstraints];
        [self.view layoutIfNeeded];
    }
}

- (void)jsq_scrollComposerTextViewToBottomAnimated:(BOOL)animated
{
    UITextView *textView = self.inputToolbar.contentView.textView;
    CGPoint contentOffsetToShowLastLine = CGPointMake(0.0f, textView.contentSize.height - CGRectGetHeight(textView.bounds));
    
    if (!animated)
    {
        textView.contentOffset = contentOffsetToShowLastLine;
        return;
    }
    
    [UIView animateWithDuration:0.01
                          delay:0.01
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         textView.contentOffset = contentOffsetToShowLastLine;
                     }
                     completion:nil];
}


//- (BOOL)jsq_isMenuVisible
//{
//    //  check if cell copy menu is showing
//    //  it is only our menu if `selectedIndexPathForMenu` is not `nil`
//    return self.selectedIndexPathForMenu != nil && [[UIMenuController sharedMenuController] isMenuVisible];
//}

#pragma mark - Utilities

- (void)jsq_addObservers
{
    if (self.jsq_isObserving) {
        return;
    }
    
    [self.inputToolbar.contentView.textView addObserver:self
                                             forKeyPath:NSStringFromSelector(@selector(contentSize))
                                                options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                                                context:kJSQMessagesKeyValueObservingContext];
    
    self.jsq_isObserving = YES;
}

- (void)jsq_removeObservers
{
    if (!_jsq_isObserving) {
        return;
    }
    
    @try {
        [_inputToolbar.contentView.textView removeObserver:self
                                                forKeyPath:NSStringFromSelector(@selector(contentSize))
                                                   context:kJSQMessagesKeyValueObservingContext];
    }
    @catch (NSException * __unused exception) { }
    
    _jsq_isObserving = NO;
}

- (void)jsq_registerForNotifications:(BOOL)registerForNotifications
{
    if (registerForNotifications) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(jsq_handleDidChangeStatusBarFrameNotification:)
                                                     name:UIApplicationDidChangeStatusBarFrameNotification
                                                   object:nil];
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self
        //                                                 selector:@selector(jsq_didReceiveMenuWillShowNotification:)
        //                                                     name:UIMenuControllerWillShowMenuNotification
        //                                                   object:nil];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(jsq_didReceiveMenuWillHideNotification:)
//                                                     name:UIMenuControllerWillHideMenuNotification
//                                                   object:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIApplicationDidChangeStatusBarFrameNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIMenuControllerWillShowMenuNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIMenuControllerWillHideMenuNotification
                                                      object:nil];
    }
}

- (void)jsq_addActionToInteractivePopGestureRecognizer:(BOOL)addAction
{
    if (self.currentInteractivePopGestureRecognizer != nil) {
        [self.currentInteractivePopGestureRecognizer removeTarget:nil
                                                           action:@selector(jsq_handleInteractivePopGestureRecognizer:)];
        self.currentInteractivePopGestureRecognizer = nil;
    }
    
    if (addAction)
    {
        [self.navigationController.interactivePopGestureRecognizer addTarget:self
                                                                      action:@selector(jsq_handleInteractivePopGestureRecognizer:)];
        self.currentInteractivePopGestureRecognizer = self.navigationController.interactivePopGestureRecognizer;
    }
}

- (void)dismiss
{
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.35 animations:^{
        self.view.backgroundColor = HMRGBACOLOR(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

@end
