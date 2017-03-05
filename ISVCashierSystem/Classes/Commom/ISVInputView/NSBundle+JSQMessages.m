
#import "NSBundle+JSQMessages.h"
#import "HMInputBar.h"

@implementation NSBundle (JSQMessages)

+ (NSBundle *)jsq_messagesBundle
{
    return [NSBundle bundleForClass:[HMInputBar class]];
}

+ (NSBundle *)jsq_messagesAssetBundle
{
    NSString *bundleResourcePath = [NSBundle jsq_messagesBundle].resourcePath;
    NSString *assetPath = [bundleResourcePath stringByAppendingPathComponent:@"JSQMessagesAssets.bundle"];
    return [NSBundle bundleWithPath:assetPath];
}

+ (NSString *)jsq_localizedStringForKey:(NSString *)key
{
    return NSLocalizedStringFromTableInBundle(key, @"JSQMessages", [NSBundle jsq_messagesAssetBundle], nil);
}

@end
