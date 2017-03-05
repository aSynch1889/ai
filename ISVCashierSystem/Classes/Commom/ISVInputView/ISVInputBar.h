
#import <UIKit/UIKit.h>

#import "JSQMessagesInputToolbar.h"
#import "JSQMessagesKeyboardController.h"


@protocol ISVInputBarDelegate <NSObject>

- (void)inputViewSendBtnDidPressedWithText:(NSString *)text;

@end

@interface ISVInputBar : UIViewController <UITextViewDelegate>
@property (nonatomic, weak) id <ISVInputBarDelegate> delegate;

/**
 *  Returns the input toolbar view object managed by this view controller.
 *  This view controller is the toolbar's delegate.
 */
@property (weak, nonatomic, readonly) JSQMessagesInputToolbar *inputToolbar;

/**
 *  Returns the keyboard controller object used to manage the software keyboard.
 */
@property (strong, nonatomic) JSQMessagesKeyboardController *keyboardController;

/**
 *  The display name of the current user who is sending messages.
 *
 *  @discussion This value does not have to be unique. This value must not be `nil`.
 */
@property (copy, nonatomic) NSString *senderDisplayName;

/**
 *  Specifies an additional inset amount to be added to the collectionView's contentInsets.top value.
 *
 *  @discussion Use this property to adjust the top content inset to account for a custom subview at the top of your view controller.
 */
@property (assign, nonatomic) CGFloat topContentAdditionalInset;

@property (nonatomic, assign) NSInteger maxWordCount;

+ (UINib *)nib;

/**
 *  Creates and returns a new `JSQMessagesViewController` object.
 *
 *  @discussion This is the designated initializer for programmatic instantiation.
 *
 *  @return An initialized `JSQMessagesViewController` object if successful, `nil` otherwise.
 */
+ (instancetype)messagesViewController;

#pragma mark - Messages view controller


- (void)setPlaceHolder:(NSString *)placeHolder;

@end
